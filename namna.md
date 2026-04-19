---
layout: page
title: Namna — Philippine Financial Independence Planner for iPhone
permalink: /namna/
description: "An offline-first Philippine financial independence planner for iPhone. Estimate when your savings and investments may support the life you want — with MP2, PERA, RTBs, SSS, GSIS. No accounts, no tracking."
---

**A people-first Philippine financial independence planner. Estimate when your savings and investments may support the life you want — without accounts, ads, or tracking.**

<div style="text-align: center; margin: 2rem 0;">
  <img src="/images/namna-icon.png" alt="Namna App Icon" style="width: 150px; height: 150px; border-radius: 25px;" />
</div>

## What Namna Does

Namna takes five simple inputs — your age, take-home pay, monthly savings, monthly retirement target, and current foundation — and gives you a clear estimate of when your money could be enough to support the life you want.

No accounts. No bank connections. No cloud sync. Your plan stays on your phone.

## Features

- **Offline-first** — Everything runs on your phone, even with no internet
- **Take-home pay first** — Works with the number that actually reaches your account, not gross income
- **Built for Philippine vehicles** — MP2, PERA, RTBs, PSE stocks, SSS, GSIS, time deposits, digital banks
- **Future scenarios** — Model life changes (new house, tuition, career break) without changing your current plan
- **Excel and JSON exports** — Your data is yours to take anywhere
- **English and Filipino** — Full bilingual support
- **No account, no ads, no tracking** — Private by design
- **One-time purchase** — No subscription, no upsells

## Built for the Philippines

Most financial independence tools are built for US 401(k)s and Roth IRAs. Namna starts from what Filipinos actually use:

- **MP2 (Pag-IBIG)** with a conservative dividend proxy
- **PERA** with the ₱200K/year contribution cap
- **RTBs and corporate bonds** with coupon-style yield
- **PSE stocks** with a conservative market-return planning rate
- **SSS and GSIS pensions** estimated from your salary basis and service years
- **Time deposits, digital banks, and cooperative share capital**
- **Custom items** for anything your plan includes that we don't

## Privacy First

Your plan stays on your devices:

- No account creation, no login, no email
- No cloud sync, no server
- No analytics, no crash reporting, no advertising SDKs
- All data stored locally using on-device SQLite

## What Namna Is Not

Namna is a planning tool, not financial advice. It does not:

- Connect to your bank, broker, or any financial institution
- Execute trades, transfers, or any kind of transaction
- Promise a specific return, age, or outcome
- Model inflation — all amounts are shown in today's pesos
- Give personalized investment recommendations

Every projection is an **estimate** under the assumptions you set. Real-world results will differ.

## Requirements

- iPhone running iOS 15.1 or later

## Download

<div style="text-align: center; margin: 2rem 0;">
  <a href="https://apps.apple.com/app/namna" class="btn btn-primary">
    Download on the App Store
  </a>
</div>

_Available soon on the App Store_

## Support

Have a question, found a bug, or want to suggest a feature?

<div style="margin: 2rem 0;">
  <a href="/namna-support/" class="btn btn-ghost">Contact Support</a>
  <a href="/namna-privacy/" class="btn btn-ghost">Privacy Policy</a>
</div>

---

## About the Developer

Namna is independently developed by [Jeryl Donato Estopace](/). It grew out of wanting a planning tool that starts from Filipino take-home reality and stays private by default.

Connect: [LinkedIn](https://www.linkedin.com/in/jeryldev/) · [GitHub](https://github.com/jeryldev)

### Tech Stack

Built with:

- React Native with Expo
- TypeScript
- SQLite (expo-sqlite) for on-device persistence
- Zustand for state
- React Native SVG for the projection chart
- ExcelJS for workbook exports
- Jest for unit tests, Maestro for end-to-end flows

---

**Disclaimer:** Namna provides planning estimates only. It is not financial advice and is not a substitute for consulting a licensed financial professional. Past performance and reference rates shown in the app do not guarantee future results.
