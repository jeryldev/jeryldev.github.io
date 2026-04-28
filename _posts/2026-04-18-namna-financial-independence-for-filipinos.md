---
layout: post
title: "Building Namna: A Private Financial Planning App for Filipinos"
date: 2026-04-18
tags: [React Native, Expo, TypeScript, Personal Finance, Philippines, Mobile]
description: "Namna is a private financial planning app for Filipinos on iPhone. Built around take-home pay, Money Today, What If changes, and local-first storage — with MP2, PERA, RTBs, SSS, and GSIS."
image: /images/namna-screenshots/03-home-current-plan.png
excerpt: "I built a private iPhone planning app for Filipinos that starts from take-home pay, local vehicles, and real-life What If changes. Here’s what changed as the product became more truthful and more useful."
---

> **Update — April 28, 2026:** The product has moved past its earlier “financial independence planner” framing. The clearest label now is **private financial planning app for Filipinos on iPhone**. It currently has no public App Store page yet, and the planned launch price is **₱99 one-time**.

## The Problem: Most Planning Tools Still Start From Someone Else’s Life

Every retirement or FIRE calculator I tried felt like it was translated from a different country, a different salary structure, and a different relationship with money.

The mismatch showed up immediately:

- they asked for **gross income**, not the take-home number people actually plan around
- they assumed US account types instead of **MP2, PERA, RTBs, SSS, and GSIS**
- they quietly treated future contributions like abstract spreadsheet math instead of money that has to live somewhere real
- they often sounded more certain than they had any right to be

I didn’t want another “optimize your wealth” app. I wanted something calmer:

> a private app that helps a Filipino user understand where their current plan stands, what changes might help or hurt, and what the assumptions really are

That is the product Namna became.

## What Namna Actually Is

Namna is still a **planner**.

That part matters.

It is not a budgeting app, not a bank connection layer, not a brokerage dashboard, and not a robo-advisor. The reason “planner” still fits is that the core job is:

- map the money you already have
- map the monthly savings you expect to keep adding
- compare future What If changes
- estimate when that overall plan may be enough

The simplest accurate description I’ve landed on is:

> **Namna is a private financial planning app for Filipinos on iPhone.**

It starts from:

1. age
2. take-home pay
3. monthly savings
4. the monthly amount you want your money to support
5. the savings, investments, and retirement-support items you already have today

From there, the app builds a planning estimate instead of a promise.

## The Product Got Better When The Claims Got Smaller

One of the most important changes during development was learning to make the app more honest, not more impressive.

That meant tightening what Namna claims in public and in the UI:

- projections are **estimates**
- amounts are shown in **today’s pesos**
- inflation is **not modeled yet**
- workbook export is **for records or sharing only**
- workbook export is **not** a restore or reimport format
- there are **no bank, broker, Pag-IBIG, SSS, or GSIS connections**
- there are **no accounts, no cloud sync, no analytics, no ads**

That kind of truthfulness sounds smaller in marketing copy, but it makes the product feel much safer.

For finance software, trust is a feature.

## What Ships In The Current Build

The current app is built around four surfaces:

### 1. Current plan

The home screen leads with the main estimate first. That was deliberate. Users should understand the core answer before they get pulled into structure or detail.

<figure>
  <img src="/images/namna-screenshots/03-home-current-plan.png" alt="Namna home screen showing the current plan estimate and chart" />
  <figcaption>The current-plan view keeps the estimate first, then shows the chart and next-step prompts.</figcaption>
</figure>

### 2. Money Today

This is the strongest part of the product UX right now. Users add the money they already have as clear, tappable items instead of a faceless total. It supports planning around things Filipinos actually use: MP2, PERA, RTBs, PSE stocks, digital banks, SSS, GSIS, and custom entries.

<figure>
  <img src="/images/namna-screenshots/05-money-today-overview.png" alt="Namna Money Today overview screen" />
  <figcaption>Money Today turns a pile of balances into a visible, reviewable plan.</figcaption>
</figure>

### 3. What If changes

The strongest product idea in Namna is that the user can save a future change without overwriting the current plan.

That makes the app useful for real decisions:

- tuition
- family support
- repairs
- career breaks
- savings shifts

<figure>
  <img src="/images/namna-screenshots/09-what-if-chart.png" alt="Namna What If chart comparing the current plan and a saved change" />
  <figcaption>What If compares one saved change against the current plan instead of burying the user in abstractions.</figcaption>
</figure>

### 4. Local progress history

Instead of asking users to do extra admin work, the app keeps automatic local snapshots on the same phone so progress history becomes part of the product rather than another chore.

That change made the app feel more humane.

## Why The App Feels Filipino

A lot of software tries to become “local” through branding alone.

What mattered more here was product structure:

- start from **take-home pay**
- support the instruments people actually know
- let users plan around family obligations and temporary costs
- stay usable even without internet
- support both **English and Filipino**

That is why Namna feels more believable than a generic FIRE calculator with Philippine numbers typed into it.

## The Architecture Is Intentionally Small

Namna is local-first by design:

- **React Native + Expo**
- **TypeScript**
- **SQLite** for on-device persistence
- **Zustand** for state
- **React Native SVG** for the chart
- **ExcelJS** for workbook export
- **Jest + Maestro** for test coverage

There is no backend.

That is not a shortcut. It is a product choice.

No server means:

- lower privacy risk
- lower operating cost
- no forced account creation
- no subscription pressure just to keep the lights on

## What I’d Rather Be Honest About

There are still things Namna does **not** do yet:

- no inflation modeling
- no live market data
- no bank sync
- no cross-device sync
- no workbook restore
- no guaranteed outcomes

I think saying those things clearly makes the app stronger, not weaker.

Finance products lose people the moment they feel slippery.

## Pricing And Current Status

The planned launch price is **₱99 one-time**.

That felt like the right opening move:

- low enough to reduce hesitation
- still paid, which protects the no-ads / no-tracking posture
- honest for a local-first utility app

As of this update:

- the support and privacy pages are live
- the product screenshots reflect the current build
- the App Store listing itself is **not public yet**

When that changes, the product page at [/namna/](/namna/) will be the source of truth.

## What I Learned Building It

Three things mattered more than I expected:

**1. Product language matters as much as math.**  
“FIRE planner” was too narrow. “Private financial planning app for Filipinos” is broader and more accurate.

**2. Trust surfaces are part of the product.**  
Export wording, privacy wording, pricing, screenshot captions, and support copy all affect whether a finance app feels safe.

**3. Restraint beats feature theater.**  
The best parts of Namna are the parts that feel clear, quiet, and useful. Not the parts that try to sound bigger than they are.

## Where Namna Goes Next

The next wave of work is less about “more features” and more about better planning realism:

- clearer explanation of where monthly savings are assumed to go
- stronger support for unstable income and family-support realities
- better short-term goal framing alongside retirement
- optional inflation-aware views without making the main product noisy

The bar is simple:

> if a careful Filipino user opens the app, reads the copy, and exports a workbook, they should never feel tricked

That standard is shaping the product more than any single technical decision.

---

_If you work on software in finance, regulated products, or local-market consumer apps, this is the kind of product problem I enjoy: specific, trust-sensitive, and full of hidden assumptions. [Say hello](/contact/) if that sounds like your world._
