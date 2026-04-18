---
layout: post
title: "Building Namna: A Financial Independence Planner for Filipinos"
date: 2026-04-18
tags: [React Native, Expo, TypeScript, Personal Finance, Philippines, Mobile]
excerpt: "I built an offline iPhone app that estimates when your money could be enough — starting from Filipino take-home pay and local vehicles like MP2, PERA, SSS, and GSIS. Here's why, and what I learned along the way."
---

## The Problem: Most FIRE Tools Are Built for Someone Else

Every financial independence calculator I could find online was built around US 401(k) accounts, Roth IRAs, and a gross salary I don't get paid. Plugging Philippine numbers into them always felt like translating from a foreign language — and the translation was never quite right.

A few examples of why:

- They ask for **gross income**. Filipinos get paid **take-home**. The difference matters — payroll deductions, withholding, SSS, PhilHealth, Pag-IBIG, and 13th-month math don't map cleanly onto "just multiply annual expenses by 25."
- They don't know what **MP2** is. Or **PERA**. Or **RTBs**. They certainly don't know the nuances of **SSS pension estimation** based on credited months.
- They quietly assume **infinite account contribution room**. Philippine PERA has a ₱200K annual cap.
- They tell you FIRE at 45. Most Filipinos reading that think, _"That's a US number. I have SSS until 60 and I want to stay close to family."_ The math is foreign AND the life assumption is foreign.

I wanted a tool that started from Filipino reality. Not a spreadsheet I had to build and maintain myself — a calm app that estimated when my money could be enough, **given how I actually get paid and what I actually invest in.**

That's how Namna started.

## Enter Namna

Namna is an offline-first Philippine financial independence planner for iPhone. It takes five inputs:

1. Your age
2. Your monthly take-home pay
3. Your monthly savings
4. Your monthly retirement target (what you want available each month in retirement)
5. Your current foundation — the savings and investments you already have

And it returns a single, clear estimate: **the age when your savings and investments may support the monthly amount you want in retirement without relying on work income.**

No accounts. No bank connections. No cloud sync. The plan stays on your phone.

## Three Decisions That Shaped the Product

### 1. Financial Independence, not FIRE

Namna used to be positioned as a FIRE planner — the tool still uses the canonical math (goal amount ≈ 25× annual expenses, derived from a conservative 4% withdrawal rate). But the brand moved to **financial independence** because FIRE in the Philippines doesn't land the way it does in US forums.

Most Filipino salaried professionals I've talked to don't want to retire at 40. They want to know **when they'd have the option**. They want a floor of security, not an exit ticket. "Financial independence" frames the same math as _permission to choose_, not _obligation to quit_.

The dashboard now reads "Your independence age" instead of "Your FIRE age." Same numbers. Different framing. Much broader audience.

### 2. Offline-First with No Accounts

The cheapest and fastest architecture for a planning app is a single-user offline app with local storage. Namna leans into this completely:

- SQLite for persistence, wrapped with `expo-sqlite`
- Zustand for in-memory state
- Zero auth, zero backend, zero cloud

This means:

- **No privacy risk.** There's no server to get breached.
- **No subscription required.** There's no server cost to recoup.
- **No forced account creation.** The friction from "sign up to see your estimate" kills the funnel for most planning apps.
- **Works anywhere.** Metro traffic jam, provincial trip, airplane — Namna just works.

The trade-off: no multi-device sync yet. You can export a JSON backup and import it on another device, which is workable. iCloud sync is a future option if users ask for it.

### 3. Built Around Philippine Vehicles

The preset catalog is opinionated:

- **Pag-IBIG MP2** with a conservative dividend-yield planning rate
- **PERA** with the ₱200K/year contribution cap encoded
- **PSE stocks** with a conservative growth + dividend split
- **RTBs and corporate bonds** using coupon-style yield
- **Time deposits and digital banks** separated so 2025 rates map cleanly
- **Cooperative share capital** with a dividend planning proxy
- **SSS and GSIS** modeled distinctly from investment items — they use salary basis + credited service months + claim age instead of a current amount

Every rate is a **conservative planning proxy**, not a guaranteed return. Users can customize any field. The goal is to start most plans from reasonable defaults so the first estimate is useful, not wishful.

## What Namna Is Not

This part matters more than the features list:

- Namna does not connect to your bank or broker
- Namna does not execute trades or transfers
- Namna does not model inflation — all amounts are shown in today's pesos
- Namna does not give personalized investment advice
- Namna does not promise a specific outcome

Every projection is an **estimate** under the assumptions the user sets. The app says "may" and "could" and "estimate" throughout. This isn't legal hedging — it's the honest framing. Compound interest is a real force. So is sequence-of-returns risk. So is life. A planning tool's job is to help you reason about a range of futures, not promise a single one.

## The Tech Stack

A minimal, boring stack by design:

- **React Native + Expo** — cross-platform ready, iOS first
- **TypeScript** — strict mode, `noUnusedLocals` + `noUnusedParameters` on
- **expo-sqlite** — on-device persistence, no backend
- **Zustand** — simple state, no Redux overhead
- **React Native SVG** — hand-rolled projection chart so we don't ship a 400KB charting library for one view
- **ExcelJS** — lazy-loaded so the ~2MB library doesn't bloat startup; only pulled in when the user exports a workbook
- **Jest + Maestro** — unit tests cover 35 suites / 210+ tests; Maestro handles end-to-end onboarding, holdings, and scenario flows

Build story is plain Expo: `npx expo prebuild`, archive in Xcode, upload.

## What I Learned Building This

**Start from the user's language, not the engine's language.** The internal code still has files called `fire.ts` and functions called `projectFirePlan`. That's fine — it's engineering naming. But the UI had to move off FIRE the moment I realized the audience wasn't the r/phinvest hardcore segment. Two naming layers: one for code, one for copy.

**Offline-first is a moat, not a limitation.** Every time someone hears "your data stays on your phone," their posture changes. That's worth more than cloud sync for v1.

**Conservative defaults protect everyone.** If MP2's planning rate is 6% and the user's actual dividends come in at 6.5%, they feel good. If the defaults were 7% and actuals were 6.5%, they feel tricked. Always round defaults toward conservatism.

**Ship the disclaimer inline, not just in legalese.** The reveal screen literally says "This estimate assumes..." and "Amounts are shown in today's pesos — inflation is not applied." That's doing work for both the user and the App Review process.

## Where Namna Goes Next

For v1.0, the focus is a calm, clear, honest estimate for Filipinos who want a floor under their plan — not a retirement calculator that pretends to know their future.

Post-launch priorities:

- Native-speaker Filipino copy review before a broader public push
- Cebuano and other Philippine languages, once reviewed
- Inflation-aware projections as an opt-in view
- Nudges like "if you saved an extra ₱1,000/mo, this moves to age X"
- Maybe iCloud sync, if users ask

The app is small on purpose. My test for every feature idea is whether it helps someone understand their number better — not whether it makes Namna more like every other finance app.

---

**Namna is currently in App Store review.** When it lands, you'll find it at [/namna/](/namna/). It's an offline-first iPhone app, one-time purchase, no subscription, no tracking.

_This is the kind of problem I enjoy working on — messy, specific to a market, and tractable with simple tools. If you've got a similar shape of problem, [I'd like to hear about it](/contact/)._
