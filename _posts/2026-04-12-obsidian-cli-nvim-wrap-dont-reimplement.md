---
layout: post
title: "Wrap, Don't Reimplement: Building obsidian-cli.nvim"
date: 2026-04-12 14:00:00 +0800
tags: [Neovim, Lua, Obsidian, Developer Tools, Open Source]
description: "Why I built a 2,000-line Neovim plugin that wraps Obsidian's official CLI instead of reimplementing the vault format in Lua. Trade-offs, architecture, and real Obsidian search/backlinks/templates over IPC."
image: /images/jeryl.jpg
excerpt: "I built a Neovim plugin for Obsidian as a thin wrapper over Obsidian's official CLI — not a Lua reimplementation of the vault format. Here's why 2,000 lines beat 4,500 lines once the official CLI shipped."
---

## The Moment I Decided Not to Write This Plugin

There's already a good Neovim plugin for Obsidian. [`obsidian-nvim/obsidian.nvim`](https://github.com/obsidian-nvim/obsidian.nvim) has ~4-5k lines of Lua, a strong community, and a clean pure-Lua reimplementation of everything you need to work with an Obsidian vault from inside Neovim. If you want to work with markdown files that happen to follow Obsidian conventions — wiki links, YAML frontmatter, daily notes — it does the job.

I had it installed. It worked. I was ready to move on.

Then Obsidian shipped an [**official CLI**](https://help.obsidian.md/cli) that speaks IPC to the live Obsidian desktop app. Now there's a binary I can shell out to that has *the actual Obsidian index* — the real search, the real backlinks, the real templates from the real Templater plugin — not a reimplementation.

And I paused. Because once that CLI existed, the pure-Lua approach stopped being the best tool for my workflow.

I wasn't trying to support people who run Neovim over SSH on a headless server. I was trying to navigate my own vault while the Obsidian app is already running in the background on my laptop. For *that* use case, reimplementing the vault format in Lua isn't a feature — it's a liability. Every time Obsidian ships a new core feature (Bases, anyone?), the Lua port has to catch up. Every time the Lua parser disagrees with Obsidian's own parser on a subtle link-resolution edge case, my notes render differently in the two places.

I wanted the *actual Obsidian engine* to be the source of truth. So I wrote a thin wrapper instead.

## What "Thin Wrapper" Means

`obsidian-cli.nvim` is about **2,000 lines of Lua**, compared to ~4,500 in the pure-Lua alternative. That's not because I'm a better engineer — it's because most of the hard problems aren't my problems to solve:

- **Vault discovery?** `obsidian vault info=path` — one subprocess call, Obsidian tells me.
- **Search?** `obsidian search "query"` — Obsidian's actual search index, with aliases, tags, and link semantics baked in.
- **Backlinks?** Obsidian's link graph, cached by the app, returned in milliseconds regardless of vault size.
- **Templates?** Whatever is configured in your Obsidian Templates or Templater settings. The plugin calls `obsidian template run` and lets Obsidian do the substitution.
- **Daily notes path and format?** Read at runtime from Obsidian's own settings file. No duplicate config.
- **Bases** (Obsidian's newer core database feature)? Wrapped: `:ObsidianBases`, `:ObsidianBaseViews`, `:ObsidianBaseQuery`. Because the CLI exposes it, the plugin exposes it.

My Lua code is mostly four things: subprocess wrappers, argument parsing, result formatting for Neovim UI (pickers, virtual text, diagnostics), and keybinding glue.

## What I Gave Up

Not free. Three real trade-offs:

**1. The Obsidian app has to be running.** If it's not, every command errors out with `The CLI is unable to find Obsidian.` For someone SSH'ing into a server to edit markdown, that's a dealbreaker. For my actual workflow (Obsidian already running in the background while I work in Neovim), it's a setup-once thing — add Obsidian to login items and forget it exists.

**2. Cold start is ~2 seconds.** If Obsidian isn't already running, the first command pays the boot cost. Warm, everything is sub-100ms because the app holds the index in memory.

**3. No headless use.** No terminal-only, no SSH, no airgapped boxes. If those matter to you, the pure-Lua plugin is genuinely the right choice.

I put a whole section in the README called ["Pick `obsidian-nvim/obsidian.nvim` if..."](https://github.com/jeryldev/obsidian-cli.nvim#pick-obsidian-nvimobsidiannvim-if) because I don't think I'm making the other plugin look bad — I think we're solving different problems. The pure-Lua plugin is *better* for headless use. My plugin is better for "Obsidian is already running, and I want real parity."

## The Shape of the Code

Neovim plugin architecture mostly works itself out once you have a few primitives right. What worked for me:

**A single `run()` wrapper** around `vim.system` that:
- Handles the "Obsidian not running" error uniformly and offers `:ObsidianStart`
- Parses JSON output where the CLI returns JSON
- Respects an `await` flag (some commands fire-and-forget, some block the UI until IPC returns)
- Is the *only* place that talks to the subprocess — all 44 commands route through it

**Small, focused command modules.** `commands/daily.lua`, `commands/tasks.lua`, `commands/search.lua`, `commands/plugins.lua`. Each one is 50-150 lines. Most of them read like:

```lua
function M.toggle_task()
  local line = vim.api.nvim_get_current_line()
  local toggled = line:gsub("%- %[ %]", "- [x]", 1):gsub("%- %[x%]", "- [ ]", 1)
  vim.api.nvim_set_current_line(toggled)
end
```

That's the whole "toggle task" implementation. I'm not trying to be clever. The tests catch the edge cases.

**Plenary tests as the safety net.** 122 tests across 12 spec files. Every command has a test. Most tests mock `vim.system` to return fixture output and assert that the command does the right thing to buffers, UI, diagnostics, or the mocked CLI's input. This is how you write a CLI-wrapper plugin and sleep at night — if the CLI's output format changes, CI tells you which of the 44 commands broke.

**blink.cmp integration for wiki links.** This is where the plugin earns its keep over plain "just shell out to `obsidian`": autocomplete inside `[[...]]` pulls live from your vault via the CLI's search, so the list is always accurate, aliases work, and tag semantics are respected. The [`completion/blink.lua`](https://github.com/jeryldev/obsidian-cli.nvim/blob/main/lua/obsidian-cli/completion/blink.lua) module is maybe 120 lines.

## The Philosophy

I had two experiences this year that pushed me toward "wrap, don't reimplement" as a default:

1. Building [Namna](/namna/), a private financial planning app for Filipinos, where I decided to start from existing Philippine tax rules and SSS pension formulas rather than invent my own — because the real rules are the source of truth.
2. Getting an App Store rejection under [Guideline 5.2.5](/blog/2026/02/18/first-app-store-rejection-guideline-5-2-5/) for a habit tracker that reimplemented something that was already Apple's turf.

Both pointed at the same lesson: **reimplementations have to be actively maintained to stay synchronized with the source. Wrappers inherit for free.**

When you wrap a binary or an API that someone else owns, your code shrinks, your tests tighten, and every upstream feature becomes an upgrade path instead of a catch-up project. The trade-off is that you're now dependent on someone else's interface staying stable. For Obsidian's official CLI, which is the primary scripting surface the Obsidian team commits to support, that bet is safe.

For a `jq` reimplementation in Lua, it probably isn't. You have to decide per project. But the default worth questioning is "of course I'll reimplement it in my language" — that's often the more expensive path.

## Where It Is Now

The plugin is at **v0.0.4** — early, usable, under my daily driver. It's public at [github.com/jeryldev/obsidian-cli.nvim](https://github.com/jeryldev/obsidian-cli.nvim) with 44 commands, 122 tests, blink.cmp integration, Snacks picker integration, and a plugin manager that can install Obsidian community plugins from Neovim.

The README has an honest "pick one or the other" table up top, because the community is better off with two good plugins serving two genuinely different audiences than with one plugin pretending to serve everyone.

## What's Next

Three things on the v0.1.0 checklist:

1. **Dedicated wrappers for Templater, Dataview, and Tasks** — right now they're reachable via the `:ObsidianCommand` escape hatch, but they deserve first-class commands.
2. **Periodic Notes integration** — daily notes work; weekly/monthly/yearly are next.
3. **Configuration shape cleanup** — the plugin reads most settings from Obsidian at runtime, but the few remaining user-side knobs could be more consistent.

If you run Neovim, keep Obsidian in the background, and want to try it: [install instructions here](https://github.com/jeryldev/obsidian-cli.nvim#install). Issues and PRs welcome. Honest takes on what the plugin is missing for your workflow are more welcome still.

---

_This post is part of a series on indie development choices I've made in 2026. If "wrap, don't reimplement" resonates, you might also like the [RingTrack rejection post](/blog/2026/02/18/first-app-store-rejection-guideline-5-2-5/) or the [Namna launch post](/blog/2026/04/18/namna-financial-independence-for-filipinos/)._
