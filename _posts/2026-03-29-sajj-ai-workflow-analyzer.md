---
layout: post
title: "sajj: Can a Couple of AI Agents Handle Your Workflow?"
date: 2026-03-29 10:00:00 +0800
tags: [AI, Gemini, React, Vercel, Supabase, Research, MIB]
excerpt: "I've been getting the 'can AI handle my workflow?' question enough times to want a serious answer. So I built a free tool that decomposes any business process, scores each step against four criteria, and generates a build spec you can paste into Claude Code or Cursor. It also feeds my graduate research at AIM."
---

The question keeps coming up, and it keeps being asked wrong.

"Can AI automate my job?" — wrong framing.
"Can a couple of AI agents handle my entire workflow?" — closer, but still misses.

The right question is: **which specific steps of your work can AI realistically handle today, which need human oversight, and which should stay human?** That's a per-step question, not a per-role question, and the answer changes by industry, by risk level, and by how tightly the work is structured.

I built [sajj](https://sajj.dev) (pronounced "sɑːdʒ") to answer that question honestly, for any workflow, in under two minutes.

## What It Does

Describe any business process — a sentence or a paragraph, in any of 10 languages — and sajj does three things:

1. **Decomposes** the process into its actual steps using Gemini 2.0 Flash
2. **Scores each step** against four boolean criteria (below)
3. **Generates a build spec** you can paste into Claude Code, Cursor, or any AI coding agent as a starting point

No email gate. No signup. You can run it on any workflow you can describe. The only thing I ask is optional feedback on whether the decomposition matched your actual process — that feedback is what makes the research data useful.

## The Four Criteria

I spent a while on this part, because the usual "AI automation score 1–10" approach is meaningless. A numeric score hides the decision. Four boolean criteria force the decision into the open:

| Criterion | Question | `true` means AI-friendly |
|---|---|---|
| **Structured** | Are the inputs structured and predictable? | Forms, templates, tables |
| **Deterministic** | Can the rules be fully written down? | No "you just know" judgment calls |
| **Low risk** | Is a mistake minor and reversible? | Safe to automate without an off-ramp |
| **No authority** | Does it require signing authority or legal liability? | No real human-power needed |

A step is green (AI Can Handle) when 3–4 criteria are true, yellow (AI + Human Review) when 2 are true, and red (Human Only) when 0–1 are true. There's no magic weight — the tier derives directly from the criteria, so users can inspect exactly why a step was scored the way it was.

This turned out to be the core insight. When a user disagrees with the tier, I don't get back "this number is wrong." I get back "you marked this as deterministic but it actually isn't because the pricing rules change by region." That's the research signal I care about.

## Build Spec (the feature I added after the first week)

After the initial launch, the most common reaction I got was:

> "OK cool, I can see the breakdown — but now what do I actually build?"

Fair point. A breakdown that ends at "AI Can Handle" doesn't tell you *how to build* the thing that handles it.

So I added **Build Spec**. Every workflow assessment now has an Export button that generates a full context-engineering spec — every screen, every form, every interaction, described in detail based on the workflow decomposition. The output is designed specifically to be pasted into Claude Code, Cursor, or Aider as the starting system prompt for actual implementation.

The flow is now:

1. Describe a process
2. See what AI can and can't handle
3. **Export a spec → start building**

If step 3 was the thing that bothered you about the first version, step 3 is the thing I care most about now.

## Why It's Free

Two reasons.

**First, graduate research.** I'm a part-time student in AIM's [Master's in Innovation and Business](https://aim.edu/mib) program, and my research focus is the gap between what LLMs *suggest* about a process and what the process actually *is*. Every submission is an anonymized data point. Corrections are even more valuable — when a user flags "this step is wrong," that's direct evidence of where AI decomposition fails. I can't pay for that data, so I trade free access for the signal.

**Second, the premise matters more than monetization.** If AI workflow automation is going to be this decade's dominant productivity story, the people who actually do the work need an honest tool to evaluate it — not a vendor pitching the "AI does everything" upsell. sajj is calibrated to say no. About a third of the steps it analyzes come back red (Human Only), and I've watched founders breathe audible relief at that.

## The Stack

Small and boring on purpose:

- **Frontend:** React 19 + Vite, single-page app
- **Backend:** Vercel Serverless Functions (Node.js)
- **Database:** Supabase (Postgres + REST)
- **LLM:** Google Gemini 2.0 Flash — fast enough for the interactive loop, cheap enough for free access
- **Tests:** Playwright — 72 end-to-end specs covering landing, analysis, feedback, corrections, and the Build Spec export
- **i18n:** 10 languages, auto-detected from browser locale (English, Chinese, Spanish, Hindi, Arabic, Portuguese, French, German, Japanese, Korean)
- **Catalog:** 208 workflow suggestions across 24 industries so first-time users don't start from a blank text box

The 4-criteria data model in Supabase is where most of the thought went — each generation produces a `generations` row, one `generation_steps` row per step, and a `scorecards` row for internal analytics. When users correct a step, `step_corrections` rows get populated with one of five issue types (`missing_step`, `wrong_desc`, `tier_too_high`, `tier_too_low`, `wrong_rules`). Those corrections are the research gold — they're the ground-truth against which Gemini's decomposition gets measured.

## What I'm Learning

Three early takeaways from the first batch of submissions:

**Process decomposition is harder than the tier assessment.** Once the steps are right, scoring them is mostly mechanical. But getting the steps right — that's where LLMs still get it wrong in subtle ways. Missing dependencies, combining two distinct decisions into one step, labeling a judgment call as "structured." The correction feedback is clustering heavily around `missing_step` and `wrong_desc`, not around tier disagreements.

**Users are more conservative than the tool.** sajj tends to score MORE steps as AI-capable than users do. When users correct, they usually push tiers DOWN (`tier_too_high`), not up. That's honest signal — and it tells me my prompt engineering is slightly overoptimistic about what AI can do.

**"Which industry?" isn't the right axis.** The criteria correlate much more strongly with *risk profile* and *input structure* than with industry. A regulated-industry onboarding task and a retail returns process can have more in common than two different processes in the same company. That's an early insight I want to test more rigorously.

## Try It

[sajj.dev](https://sajj.dev) — free, no signup, 2 minutes.

If sajj gets your process wrong, I want to know. That's where the real insights are, and anonymized correction data directly feeds my research at AIM. The tool has built-in correction flags on every step so you can tell it exactly *where* it's wrong without having to email me.

---

_sajj is open to anyone doing real work — finance, operations, marketing, HR, sales, manufacturing, healthcare, anything. If you're a researcher or builder curious about the data model or the correction-signal pipeline, [drop me a note](/contact/)._
