---
layout: post
title: "citruszest-ghostty.nvim: One Palette for Neovim and Ghostty"
date: 2026-03-26 12:00:00 +0800
tags: [Neovim, Lua, Ghostty, Colorscheme, Developer Tools, Open Source]
description: "A Neovim colorscheme that shares 16 terminal colors exactly with Ghostty. Full Treesitter + LSP semantic token coverage, plus plugin support for Telescope, Snacks, Lazy, Which-key, Noice, and Mini."
image: /images/jeryl.jpg
excerpt: "I wanted my terminal and my editor to use the exact same 16 colors — not just close enough, the same hex values. So I shipped a Neovim colorscheme that shares a palette with Ghostty."
---

I spend most of my day in two places: Ghostty (terminal) and Neovim (editor, running inside Ghostty). For years they disagreed with each other. Ghostty used one palette, Neovim used a different one, and my eyes kept re-adapting every time I switched between a shell and a buffer — even though they were technically in the same window.

I finally got tired of it and built `citruszest-ghostty.nvim` — a Neovim colorscheme that shares its 16 terminal colors exactly with Ghostty. Same hex values, same semantics, one palette.

## The Palette

Inspired by [citruszest.nvim](https://github.com/zootedb0t/citruszest.nvim) and Ghostty's default colors, with a bright citrus bias:

```lua
bg              = "#121212"   -- deep charcoal
fg              = "#bfbfbf"   -- comfortable light gray
fg_bright       = "#f9f9f9"

red             = "#ff5454"   -- errors, exceptions
red_bright      = "#ff1a75"   -- statements, keywords
green           = "#00cc7a"   -- strings, success
green_bright    = "#1affa3"   -- escape chars, special
yellow          = "#ffd400"   -- types, titles, warnings
yellow_bright   = "#ffff00"
blue            = "#00bfff"   -- functions, links
blue_bright     = "#33cfff"   -- built-in functions, modules
magenta         = "#ff90fe"   -- preprocessor, imports
magenta_bright  = "#ffb2fe"   -- macros
cyan            = "#48d1cc"   -- operators, properties
cyan_bright     = "#00fff2"   -- regex, special chars
orange          = "#ff8c00"   -- constants, numbers, search

cursor          = "#00e086"   -- mint, always visible
selection_bg    = "#ff8c00"   -- orange, high-contrast selection
```

The ground is `#121212` — deeper than most "dark" palettes but not pure black, so cursors and selections read cleanly without halation.

The signature move is **orange as the selection background**. Most colorschemes use a muted gray or a tinted-blue selection, which means selected text fades into the ground. Orange selection is unmissable — when you visual-select a block, you know exactly what you've got.

## Why Share a Palette Between Terminal and Editor?

Three reasons:

**1. Eye adaptation.** Every time your terminal's green is `#4caf50` and your Neovim's green is `#98c379`, your eye re-tunes. Over hours that's real cognitive load. When both use `#00cc7a`, your visual system only ever learns one green.

**2. Copy-paste fidelity.** Shell output piped into Neovim (git status in a buffer, error logs opened in a split) keeps the same colors it had in the terminal. A red error stays the same red. A green "Added" stays the same green.

**3. Consistent mental model.** In citruszest-ghostty, **red means error**. Everywhere. Terminal errors, LSP diagnostics, TSX lint squiggles, shell exit codes. One semantics, 16 colors.

## The Neovim Side

The plugin is small — under 300 lines of Lua covering:

- **Neovim core groups:** Normal, Comment, String, Function, Type, Keyword, etc.
- **Treesitter:** full `@variable`, `@function`, `@keyword.*`, `@markup.*`, `@tag.*` coverage
- **LSP semantic tokens:** `@lsp.type.class`, `@lsp.type.function`, `@lsp.type.enumMember`, etc. linked to the Treesitter equivalents so language servers that emit semantic tokens get the same colors as the parser
- **Diagnostics:** error/warn/info/hint with subtle tinted-background virtual text, so inline diagnostics read without stealing focus from your code
- **Plugin support:** Telescope, Snacks picker, Lazy, Which-key, Noice, GitSigns, Mini, IndentBlankline, Treesitter-context
- **Terminal colors:** `vim.g.terminal_color_0` through `terminal_color_15` set from the palette so `:term` inside Neovim matches Ghostty's shell colors exactly

The `vim.g.terminal_color_*` assignment is the detail that closes the loop: when you open a terminal inside Neovim, the shell inherits the same 16 colors the editor is using, so `ls --color`, `git status`, and `rg` all render with the same greens, blues, and oranges you see in your source files.

## Shipping It

```lua
{
  "jeryldev/citruszest-ghostty.nvim",
  lazy = false,
  priority = 1000,
}
```

Then in your LazyVim config:

```lua
{
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "citruszest-ghostty",
  },
}
```

The plugin ships `colorscheme citruszest-ghostty` as the main command, plus `palette` as an importable module so other plugins or user config can reach into the hex values directly:

```lua
local p = require("citruszest-ghostty.palette")
vim.api.nvim_set_hl(0, "MyCustom", { fg = p.orange, bold = true })
```

## Design Notes

A few choices worth calling out:

**Italics on keywords, not bold.** `Keyword`, `@keyword`, `@keyword.return`, `@variable.parameter` are italic. Bold is reserved for `@function`, `@constant.builtin`, `@type.builtin`, and `Boolean` — things that are *named entities*, not syntactic scaffolding. Keywords are structural; they deserve visual distinction but not visual weight.

**Operators in cyan.** `+`, `-`, `->`, `=>`, `::` all read as `#48d1cc`. In a dense Elixir or TypeScript buffer, this means operators "recede" into the background of the syntax — you see the names first, operators second. That's the right reading order for most languages.

**Diagnostics get tinted backgrounds.** Virtual text for `DiagnosticVirtualTextError` uses `#2e1a1a` as its background — a dark red-tinted ink, not a red highlight. It makes the inline error readable without making it shout.

**Yellow is reserved for types.** Types, type definitions, `@constructor`, `@module` (the capital-N namespace) — all yellow. This makes the type system visually scannable in statically-typed buffers without being aggressive about it.

## Where It Fits

This is a small plugin that solves a small problem. Most of the work is in the 200+ highlight group assignments; the hard part is taste, not code. I've been using it as my daily driver since late February and the palette has stayed stable enough that I felt comfortable making the repo public.

If you use Ghostty and Neovim together and the color mismatch has been bothering you, [give it a try](https://github.com/jeryldev/citruszest-ghostty.nvim). If you use a different terminal, the palette still works — the colors are designed to be readable on `#121212`, not specifically tied to Ghostty's renderer.

The palette is MIT-licensed and the whole plugin is open source. PRs welcome, especially for plugin support I haven't added yet.

---

_The `#00cc7a` mint green in this palette is the same accent you see across this site. Portfolio and editor use the same palette for the same reason terminals and editors should: one visual system, one set of meanings._
