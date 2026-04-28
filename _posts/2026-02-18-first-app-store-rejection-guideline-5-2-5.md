---
layout: post
title: "My First App Store Rejection, and Why I'm Okay With It"
date: 2026-02-18 12:00:00 +0800
tags: [iOS, App Store, watchOS, Indie, Lessons, RingTrack]
description: "My habit-tracker app got rejected under Apple's Guideline 5.2.5 (trademark similarity). The honest breakdown of what the name and visual metaphor collided with, and the 30-minute checklist that would have caught it before shipping."
image: /images/jeryl.jpg
excerpt: "I spent four weekends building my first Apple Watch app with an accompanying iPhone companion. Designed it, coded it, submitted it, and got rejected under Guideline 5.2.5 — a trademark issue. Here's what I learned, and why I'm genuinely fine with it."
---

My habit-tracker app got rejected by Apple and I'm okay with it. 🤣

I spent four weekends building my first watch app with an accompanying iPhone app. Designed it. Coded it. Sought out AI guidance where I needed it. Submitted it. Then I got the rejection notice from Apple — Guideline 5.2.5, trademark issue.

But I feel good. I built something. I learned the process. I shipped.

Now I just need to redesign and resubmit. This is just a step toward success. I'll get it right next time.

This post is the longer version of that — what happened, what Guideline 5.2.5 actually says, what I think I got wrong, and the things I would tell a past version of myself before starting.

## The Four Weekends

The idea was simple: a habit tracker for Apple Watch that caps you at three concurrent habits, because cognitive-load research suggests focus beats breadth when you're trying to build new behavior. I wanted to visualize progress clearly, lean on the Apple Watch's lowest-friction tap surface, and keep everything private by default.

I called it **RingTrack**. That name, in hindsight, is doing more work than I realized.

Over four weekends I designed the interface, wrote the watchOS and iOS code in Swift, wired up `SwiftData` for persistence and `WatchConnectivity` for device sync, added widgets, and shipped it into App Store Connect for review.

The build itself went fine. I learned a lot of new tooling — Xcode cloud signing, provisioning profiles, App Store Connect metadata, TestFlight invitations, the whole dance. I wrote a privacy policy. I set up a support form. I published the product page on this site. I took screenshots for six device sizes. I submitted.

Then the rejection came.

## What Guideline 5.2.5 Actually Says

For anyone else staring at this review decision in their inbox, here's the specific guideline:

> **5.2.5 Apple Products:** Don't create an app that appears confusingly similar to an existing Apple product, interface (e.g. Finder), app (such as the App Store, iTunes Store, or Messages) or advertising theme.

It's one of the shorter review guidelines. It's also one of the broader ones. In practice it's a bucket Apple uses for trademark/IP protection that spans naming, iconography, visual language, and overall product framing.

The review message I got didn't point to a single smoking gun. It said the app appeared confusingly similar to Apple products, referenced the guideline, and suggested I review my name, my iconography, and the visual language of the app.

With some distance, my best honest guess is that the rejection was a combination of factors, not any one of them:

1. **The name.** "RingTrack" on an Apple Watch app where the core visualization is filling rings is hard to read as anything other than a reference to Apple's Activity rings — which Apple has protected aggressively as a recognizable part of the Fitness brand.
2. **The visualization.** My progress rings were visually distinct from Apple's — different proportions, different colors, different stroke treatment — but they still live in the same conceptual space on the same device.
3. **The category framing.** "Habit tracker for Apple Watch" that fills rings starts downstream of Apple's existing design vocabulary.

Apple didn't say which of these tripped the guideline. They don't usually, and I respect why — the guideline is intentionally fuzzy so developers can't line-item around it.

## What I Got Wrong

Here's the thing I'd tell past me, before the fourth weekend:

**Trademark due diligence isn't a launch-week task. It's a day-one task.**

I treated naming as a branding problem to solve after the product worked. I searched for domain availability. I checked the App Store for direct naming conflicts. What I *didn't* do was run the name, the category, the visual metaphor, and the hardware target as a single combined search against Apple's own trademarks and recognizable brand properties.

If I had, I'd have found that "rings" + "Apple Watch" + "tracking" is a saturated space that Apple occupies structurally — not because they trademarked the word "ring," but because the *combination* reads as an Apple vocabulary.

The second thing I'd tell past me: **naming is the cheapest thing to change when you haven't shipped yet.** Every day that passes with a name, the name gets more embedded — in the bundle identifier, the domain, the code comments, the README, the mental model. Changing it at week four is harder than at week zero, even though the code doesn't care.

## What I'd Do Differently

A short checklist I'll use next time, before writing any code:

- **USPTO + WIPO search** for the candidate name, and for the category the app falls under
- **Apple brand asset guidelines** — [their trademark list](https://www.apple.com/legal/intellectual-property/trademark/appletmlist.html) and [brand guidelines for third-party developers](https://developer.apple.com/brand-guidelines)
- **Visual metaphor audit** — what's the dominant visual unit, and does Apple already own real estate in that space on the hardware I'm targeting?
- **Review guideline walk-through** — actually read [App Review Guidelines §5](https://developer.apple.com/app-store/review/guidelines/#legal) for the platform you're shipping to, not just the common ones I already know
- **Category-specific rejection research** — skim r/iOSProgramming, [Apple Developer forums](https://developer.apple.com/forums/), and recent indie blog posts for the rejection patterns in the specific category I'm shipping into

Thirty minutes of this, spread across a couple of evenings, before any code gets written. Cheaper than four weekends.

## What's Actually Great About This

Two things.

First, I shipped. The full loop — design, build, policy, screenshots, metadata, submission — is a muscle I had never exercised before. Now I have. The next app I submit will take a fraction of the time because I know what the end looks like.

Second, the rejection is survivable. Guideline 5.2.5 isn't a moral judgment. It's Apple asking me to resubmit with a different name and a different visual metaphor. The *product* is fine. The *positioning* collides. Those are independently changeable.

## What Comes Next

RingTrack the name is retired. The code is kept. The product concept — three habits, focus over breadth, wrist-first logging, local-only data — still stands on its own and doesn't need Apple's visual language to be useful. A rename with a non-ring metaphor and a different primary visualization is probably a weekend of work, not another four.

I'll put it behind other things first, though. At the time, I was getting [Namna](/namna/) — the private financial planning app for Filipinos I was building for iPhone — ready for review, and I applied the lesson there too. I ran the name, the metaphor, and the category through the same checklist before I wrote a line of code.

If you're an indie developer reading this and you're about to ship your first iOS app, here's my one takeaway: **spend thirty minutes on trademark and visual-language research before you spend four weekends on a name that can't survive review.** Everything else you build will be ready to submit. The name is the part that can quietly cost you the weekend loop.

A rejection isn't a verdict on the work. It's a note on the packaging. And packaging is cheap to change — as long as you're willing to change it.

---

_If you're working on a habit tracker, a finance planner, or another indie iOS project and want a second set of eyes on the positioning before you submit, [drop me a note](/contact/). I'd rather help someone else skip the rejection loop than keep the lesson to myself._
