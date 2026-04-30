---
layout: post
title: "Building Namna: From a Spreadsheet Question to a Private Financial Planning App for Filipinos"
date: 2026-04-18
tags: [React Native, Expo, TypeScript, Personal Finance, Philippines, Mobile]
description: "I built Namna from a simple question: when will my money be enough for the life I want? What started as an Excel file became a private financial planning app for Filipinos on iPhone."
image: /images/namna-screenshots/03-home-current-plan.png
excerpt: "I first tried answering a personal money question in Excel. The spreadsheet worked, but it did not feel like the right tool. That question eventually became Namna."
---

> **Update — April 29, 2026:** The product has moved past its earlier “financial independence planner” framing. The clearest label now is **private financial planning app for Filipinos on iPhone**. It is now live on the App Store at **₱99 one-time**.

I built Namna from a question I asked myself one day while walking:

> **When will my money be enough for the life I want?**

Not in a dramatic way. Not as a slogan. Just as a real question.

I wanted to know whether the money I already had, plus the money I could keep saving, might eventually become enough to support the kind of life I wanted.

## It started as an Excel file

Like a lot of people, I started with a spreadsheet.

At first, that made sense. Excel is flexible, familiar, and good for rough planning. I built the file for myself because I wanted to see the relationship between:

- what I already had
- what I might keep saving every month
- where that money might be placed
- and when it might become enough later

The spreadsheet helped, but only to a point.

It gave me numbers, but it did not feel like the right home for a question like that. It felt too mechanical for something that is actually personal, emotional, and tied to real tradeoffs. I could make it work, but I did not feel like I would want to return to it often. I also did not think it would feel approachable for most people.

Then another question came to mind:

> **Have other Filipinos been trying to answer the same thing?**

I thought the answer was probably yes.

## Why an app made more sense

The more I sat with the spreadsheet, the more I felt that the problem deserved a better form.

I did not want another generic retirement calculator that felt imported from another country and another life. I wanted something that starts closer to how ordinary Filipinos actually think and plan:

- with **take-home pay**, not gross salary
- with local options like **MP2, PERA, RTBs, SSS, and GSIS**
- with family obligations, unstable income, and practical tradeoffs in mind
- with privacy by default
- and with a tone that does not make people feel poor, late, or stupid for starting small

That idea became Namna.

## Why Namna is still a planner

One thing I became clearer about over time is that Namna is still a **planner**.

That matters.

It is not a bank dashboard. It is not a brokerage app. It is not a robo-advisor. It is not a budgeting tracker trying to do everything.

Its job is simpler than that:

- help you understand where your current plan stands
- help you map the money you already have today
- help you compare future What If changes
- help you estimate when that overall plan may be enough

The clearest description I have now is:

> **Namna is a private financial planning app for Filipinos on iPhone.**

## Naming it was harder than I expected

Thinking of a product name was genuinely difficult.

I knew from the beginning that I wanted a Filipino-rooted name. I only speak Tagalog and a little Bicolano, but I knew the app itself was meant for Filipinos in a Philippine context, so an English-only name did not feel right.

While searching, I found the Ilokano word **namnama**, which carries meanings around hope, desire, and expectation. I liked it immediately.

It felt emotionally right for the kind of app I was building. Planning for the future is not just about numbers. It is also about hope.

I thought **namnama** was a little too long for the product name, so I shortened the inspiration into **Namna**.

I do not frame Namna as a dictionary claim. I use it as a product name inspired by *namnama*.

That felt honest, and it stayed.

## What the product became

After that, I spent weeks thinking through the app structure, logo, page screens, language, and planning logic before building it.

The current product is built around a few core ideas:

### 1. Start from what is real today

Namna starts with:

- age
- take-home pay
- monthly savings
- target monthly amount later
- the money you already have in your plan

That sounds simple, but it changes the tone immediately. It feels more grounded.

### 2. Make the money visible

Instead of hiding everything behind one total, Namna lets users add the money they already have as clear items inside **Money Today**.

That means people can plan around things they actually recognize:

- MP2
- PERA
- RTBs
- PSE stocks
- digital banks
- SSS
- GSIS
- and custom entries

### 3. Separate the current plan from future changes

One of the strongest ideas in the app is **What If**.

A user can test tuition, family support, repairs, a career break, or a savings change without overwriting the current plan. That matters because many financial decisions are really comparisons between possible futures.

### 4. Keep the product private and small

Namna is intentionally local-first:

- no account
- no ads
- no analytics tracking
- no bank connection
- no cloud sync

The app stays smaller because of that, but also safer.

## The app got better when the claims got smaller

One of the most important lessons while building Namna was that truthfulness matters as much as features.

The product became stronger when I stopped trying to make it sound bigger than it was.

That meant being more literal about what it does:

- projections are **planning estimates**
- values are shown in **today’s pesos**
- inflation is **not modeled yet**
- workbook export is for **records or sharing only**
- workbook export is **not** a restore or reimport format
- the app has **no live financial integrations**
- the app has **no personal financial advice layer**

That kind of restraint sounds smaller in marketing copy, but it builds more trust.

For finance apps, trust is a feature.

## What ships in Namna today

The current build helps users:

- estimate when their current plan may be enough
- add the money they already have today
- compare What If changes without overwriting the main plan
- keep automatic local snapshots and progress history on the same phone
- export a readable Excel workbook for their own records or sharing

It also supports both **English and Filipino** in the UI.

## What I wanted the app to feel like

More than anything, I wanted Namna to feel respectful.

Not flashy. Not aggressive. Not built only for people who already have extra money.

I wanted it to feel like:

- start where you are
- think clearly
- keep going
- do not be ashamed of small beginnings

That emotional tone matters more than many people admit, especially in personal finance.

## Pricing and current status

Namna is now available on the App Store for **₱99 one-time**.

That felt like the right opening move:

- low enough to reduce hesitation
- still paid, which protects the no-ads, no-tracking posture
- honest for a local-first utility app

As of this update:

- the support and privacy pages are live
- the product screenshots reflect the current build
- the App Store listing is public: [Namna on the App Store](https://apps.apple.com/us/app/namna/id6763838525)

The product page at [/namna/](/namna/) remains the source of truth for the current positioning and links.

## Why I’m still proud of it

Namna is not trying to be everything.

It does not try to be a bank. It does not try to be a trading app. It does not try to pretend its projections are guarantees.

It tries to do one thing well:

> help a Filipino user think more clearly about when their money might be enough

That started as a personal spreadsheet question. Now it is a real app.

And that feels meaningful to me.

---

Namna is live on the App Store: [View Namna on the App Store](https://apps.apple.com/us/app/namna/id6763838525)

If you care about private software, local-market products, or finance tools that try to speak more honestly, [say hello](/contact/).
