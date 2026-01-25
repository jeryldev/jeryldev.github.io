---
layout: page
title: RingTrack - Science-Backed Habit Tracker
permalink: /ringtrack/
---

# RingTrack

**Build lasting habits with a habit tracker designed around behavioral science research.**

<div style="text-align: center; margin: 2rem 0;">
  <img src="/images/ringtrack-icon.png" alt="RingTrack App Icon" style="width: 150px; height: 150px; border-radius: 25px;" />
</div>

## Why Only 3 Habits?

Research shows that focusing on fewer habits increases success rates. RingTrack limits you to 3 concurrent habits based on cognitive load research. **Focus beats breadth.**

## Features

- **Maximum 3 habits** - Quality over quantity
- **Beautiful rings** - Visualize daily progress
- **Watch-first design** - Lowest friction logging
- **Timer, counter, and checkbox** - Three habit types
- **66-day automaticity milestone** - Based on habit formation research
- **Milestone celebrations** - At 7, 21, 30, 66, and 100 days
- **Customizable colors** - Personalize your experience
- **Local data** - Complete privacy
- **No subscription** - Free forever

## Science-Backed Approach

RingTrack is built on behavioral science principles:

- **66-day milestone** based on [habit formation research](https://onlinelibrary.wiley.com/doi/abs/10.1002/ejsp.674)
- **Immediate visual feedback** (rings fill as you progress)
- **Friction reduction** (log habits in 2 seconds from your wrist)
- **Identity-based habits** (focus on who you want to become)
- **Never miss twice** recovery system

## Habit Types

<div class="habit-types-grid">
  <div class="habit-type-card">
    <div class="habit-type-icon">⏱️</div>
    <h3>Timer Habits</h3>
    <p>Track time-based activities like meditation, reading, or exercise. Set a goal and watch your ring fill as the timer runs.</p>
  </div>
  <div class="habit-type-card">
    <div class="habit-type-icon">🔢</div>
    <h3>Counter Habits</h3>
    <p>Track countable actions like glasses of water, push-ups, or pages read. Tap to increment throughout the day.</p>
  </div>
  <div class="habit-type-card">
    <div class="habit-type-icon">✅</div>
    <h3>Checkbox Habits</h3>
    <p>Simple yes/no habits like taking vitamins or making your bed. One tap to complete.</p>
  </div>
</div>

## Watch-First Design

Your Apple Watch is the primary interface:

- **Glance** at all 3 rings on your wrist
- **Log** actions in 2 seconds
- **Complications** for quick access
- **Haptic feedback** on completion
- **Works standalone** (no iPhone required)

## Privacy First

Your habits stay on your devices:

- No account creation
- No data collection
- No analytics or tracking
- All data stored locally

## Tip Jar

RingTrack is completely free with no subscription. If you find it valuable, you can leave a tip to support development. Tips are 100% optional.

## Requirements

- iPhone running iOS 18.0 or later
- Apple Watch running watchOS 11.0 or later (optional)

**Start building better habits today.**

## Download

<div style="text-align: center; margin: 2rem 0;">
  <a href="https://apps.apple.com/app/ringtrack" class="btn btn-primary">
    Download on the App Store
  </a>
</div>

_Available soon on the App Store_

## Support {#support}

<div class="support-section">
  <p>Have a question, found a bug, or want to suggest a feature? I'd love to hear from you.</p>

  <form id="support-form" class="support-form">
    <div class="form-group">
      <label for="name">Your Name</label>
      <input type="text" id="name" name="name" required placeholder="What should I call you?">
    </div>

    <div class="form-group">
      <label for="issue-type">What can I help with?</label>
      <select id="issue-type" name="issue-type" required>
        <option value="">Select an option...</option>
        <option value="Bug Report">Bug Report</option>
        <option value="Feature Request">Feature Request</option>
        <option value="Question">Question</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <div class="form-group">
      <label for="message">Tell me more</label>
      <textarea id="message" name="message" rows="5" required placeholder="Describe the issue, question, or idea..."></textarea>
    </div>

    <div class="form-group">
      <label for="device">Device & OS Version (optional)</label>
      <input type="text" id="device" name="device" placeholder="e.g., iPhone 15, iOS 18.2 / Apple Watch Series 9, watchOS 11.2">
    </div>

    <button type="submit" class="btn btn-primary">Send via Email</button>
    <p class="form-note">This will open your email client with the message pre-filled.</p>
  </form>

  <div class="support-alt">
    <p>Prefer to write directly? <a href="mailto:jeryldevsocial@gmail.com">jeryldevsocial@gmail.com</a></p>
    <p><a href="/ringtrack-privacy/">Privacy Policy</a></p>
  </div>
</div>

<script>
document.getElementById('support-form').addEventListener('submit', function(e) {
  e.preventDefault();

  const name = document.getElementById('name').value;
  const issueType = document.getElementById('issue-type').value;
  const message = document.getElementById('message').value;
  const device = document.getElementById('device').value;

  const subject = encodeURIComponent('RingTrack ' + issueType);
  const body = encodeURIComponent(
    'Hi Jeryl,\n\n' +
    'My name is ' + name + '.\n\n' +
    'Issue Type: ' + issueType + '\n\n' +
    'Details:\n' + message + '\n\n' +
    (device ? 'Device Info: ' + device + '\n\n' : '') +
    'Thanks!'
  );

  window.location.href = 'mailto:jeryldevsocial@gmail.com?subject=' + subject + '&body=' + body;
});
</script>

<style>
  .support-section {
    max-width: 900px;
    margin: 0 auto;
  }

  .support-section > p {
    text-align: center;
    margin-bottom: var(--space-4);
  }

  .support-form {
    background: var(--card-bg);
    padding: var(--space-4);
    border-left: 4px solid var(--primary);
    margin-bottom: var(--space-4);
  }

  .support-form .form-group {
    margin-bottom: var(--space-3);
  }

  .support-form .form-group label {
    display: block;
    font-weight: var(--font-semibold);
    color: var(--secondary);
    margin-bottom: var(--space-1);
  }

  .support-form .form-group input,
  .support-form .form-group textarea,
  .support-form .form-group select {
    width: 100%;
    padding: var(--space-2);
    font-size: var(--text-base);
    font-family: inherit;
    border: 2px solid var(--border);
    background: var(--light-bg);
    color: var(--text);
    transition: border-color 0.3s ease;
  }

  .support-form .form-group input:focus,
  .support-form .form-group textarea:focus,
  .support-form .form-group select:focus {
    outline: none;
    border-color: var(--primary);
  }

  .support-form .form-group input::placeholder,
  .support-form .form-group textarea::placeholder {
    color: var(--text-secondary);
    opacity: 0.7;
  }

  .support-form .form-group textarea {
    resize: vertical;
    min-height: 100px;
  }

  .support-form .btn {
    width: 100%;
    padding: var(--space-2);
  }

  .form-note {
    text-align: center;
    font-size: var(--text-sm);
    color: var(--text-secondary);
    margin-top: var(--space-2);
    margin-bottom: 0;
  }

  .support-alt {
    text-align: center;
    color: var(--text-secondary);
  }

  .support-alt a {
    color: var(--primary);
    font-weight: var(--font-medium);
  }

  .support-alt p {
    margin-bottom: var(--space-2);
  }
</style>

---

## About the Developer

RingTrack is independently developed by [Jeryl Donato Estopace](/) as a side project focused on simplicity, science, and privacy. No venture capital. No subscriptions. Just a tool to help you build better habits.

Connect: [LinkedIn](https://www.linkedin.com/in/jeryldev/) · [GitHub](https://github.com/jeryldev)

### Tech Stack

Built with:
- Swift 6.0 (strict concurrency)
- SwiftUI & SwiftData
- VersionedSchema for migrations
- WatchConnectivity for sync
- StoreKit for tips

---

_Last updated: January 25, 2026_
