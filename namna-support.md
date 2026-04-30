---
layout: page
title: Namna Support
permalink: /namna-support/
description: "Get help with Namna — a private financial planning app for Filipinos on iPhone. Common questions about on-device storage, Excel exports, What If changes, inflation, iPhone support, and refunds."
---

Have a question, found a bug, or want to suggest a feature? I'd love to hear from you.

## Common Questions

### Where is my data stored?

Your plan stays on your iPhone using on-device storage. Nothing is sent to a server. If you want a copy for your own records, you can export an Excel workbook from Help in the More tab.

### How much does Namna cost?

Namna is available on the App Store at **₱99 one-time** on iPhone, with **no subscription**.

You can view the listing here: [Namna on the App Store](https://apps.apple.com/us/app/namna/id6763838525).

### Does Namna connect to my bank, broker, or government agencies?

No. Namna does not connect to banks, brokers, Pag-IBIG, SSS, GSIS, or any external system. All values are entered manually and stay on your device.

### How do I move my plan to another device?

There is **not currently a user-facing full restore flow** for moving your plan from one device to another.

Right now:

- The **Excel workbook export** is for your own records, review, or sharing
- It is **not** meant to be reimported into the app
- If a future release adds a supported migration flow, this page will be updated

### Why is my estimate still far away?

The estimate depends on your current savings, monthly savings, retirement target, and the long-term assumptions behind the money you added. Small changes to your savings rate, target spending, or money mix can move the estimate meaningfully. What If changes can also make the result later or earlier depending on the costs and money changes you add.

### How do What If changes work?

What If changes let you test a different version of your future without changing your main plan.

Right now they can include:

- **Money changes** for specific items you already have
- **Temporary costs** such as tuition, repairs, caregiving, or a career break

These changes only affect that saved What If version. Your main plan stays the same unless you edit the main plan separately.

### Does Namna include inflation?

Not yet. Current projections are shown in today's pesos, so future purchasing power may differ. This is called out in the app's planning note on the reveal screen.

### Does Namna give financial advice?

No. Namna is a planning tool that shows estimates under the assumptions you set. It is not a substitute for consulting a licensed financial professional, and it does not recommend specific investments or products.

### What happens to my data if I uninstall?

Everything is deleted. Because nothing is stored on a server, uninstalling removes all of your plan data permanently. Export an Excel workbook first if you want a copy for your own records.

### What are snapshots and progress history?

Namna keeps automatic local snapshots of your current plan on that same phone. Those saved snapshots help show your progress history over time without asking you to save anything manually each time.

- Snapshots stay on your device
- They are not synced to a server
- They help you compare how your estimate changes over time

### Is there an Android version?

Not yet. Namna currently ships for iPhone only.

### How do refunds work?

Refunds for App Store purchases are handled directly by Apple. Visit [reportaproblem.apple.com](https://reportaproblem.apple.com) to request one.

### Does Namna use a server or account?

No. Namna does not require an account, and it does not store your plan on a server. Your plan stays on your device unless you choose to export a workbook yourself.

## Contact

<div class="support-section">
  <p>Prefer a structured form? Fill this out and it will open your email client with everything pre-filled.</p>

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
        <option value="Privacy">Privacy Question</option>
        <option value="Refund">Refund Question</option>
        <option value="Other">Other</option>
      </select>
    </div>

    <div class="form-group">
      <label for="message">Tell me more</label>
      <textarea id="message" name="message" rows="5" required placeholder="Describe the issue, question, or idea..."></textarea>
    </div>

    <div class="form-group">
      <label for="device">Device &amp; iOS Version (optional)</label>
      <input type="text" id="device" name="device" placeholder="e.g., iPhone 15, iOS 18.2">
    </div>

    <button type="submit" class="btn btn-primary">Send via Email</button>
    <p class="form-note">This will open your email client with the message pre-filled.</p>
  </form>

  <div class="support-alt">
    <p>Prefer to write directly? Email <a href="mailto:jeryldevsocial@gmail.com">jeryldevsocial@gmail.com</a></p>
    <p><a href="/namna-privacy/">Privacy Policy</a> · <a href="/namna/">Product Page</a></p>
  </div>
</div>

<script>
document.getElementById('support-form').addEventListener('submit', function(e) {
  e.preventDefault();

  const name = document.getElementById('name').value;
  const issueType = document.getElementById('issue-type').value;
  const message = document.getElementById('message').value;
  const device = document.getElementById('device').value;

  const subject = encodeURIComponent('Namna ' + issueType);
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

**Disclaimer:** Namna provides planning estimates only. It is not financial advice and is not a substitute for consulting a licensed financial professional.

---

[← Back to Namna](/namna/)
