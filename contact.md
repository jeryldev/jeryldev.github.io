---
layout: default
title: Contact
permalink: /contact/
description: "Consulting and solution-building inquiries. Accepting a small number of engagements each quarter — Elixir/Phoenix backends, React Native apps, AI workflows, developer tools."
---

<section class="section contact-page-section">
  <div class="container">
    <div class="contact-page">
      <header class="contact-page-header">
        <span class="section-eyebrow">Consulting</span>
        <h1 class="contact-page-title">Working on something?</h1>
        <p class="contact-page-dek">I take on a small number of consulting and solution-building engagements each quarter. If you're shipping a product and need an engineer who can take it end-to-end — strategy, architecture, and code — tell me what you're building.</p>
        <p class="contact-page-engagements"><span class="mono-label">Typical work</span> Elixir / Phoenix backends · React Native apps · AI workflows · Developer tools</p>
      </header>

      <form id="contact-form" class="contact-form">
        <div class="form-group">
          <label for="name">Your name</label>
          <input type="text" id="name" name="name" required placeholder="What should I call you?">
        </div>

        <div class="form-group">
          <label for="industry">Industry or domain</label>
          <input type="text" id="industry" name="industry" placeholder="Healthcare, education, logistics, finance…">
        </div>

        <div class="form-group">
          <label for="project">What are you building?</label>
          <textarea id="project" name="project" rows="5" required placeholder="A product, a feature, a rebuild, a prototype — what's the shape of the work?"></textarea>
        </div>

        <div class="form-group">
          <label for="success">What does success look like? <span class="form-optional">(optional)</span></label>
          <textarea id="success" name="success" rows="3" placeholder="How would you know the engagement worked?"></textarea>
        </div>

        <div class="form-group">
          <label for="timeline">Timeline <span class="form-optional">(optional)</span></label>
          <input type="text" id="timeline" name="timeline" placeholder="e.g., 2-week discovery, 3-month build, ongoing advisory">
        </div>

        <button type="submit" class="btn btn-primary">Tell me about your project →</button>
        <p class="form-note">Opens your email client with the message pre-filled. Response within a few days.</p>
      </form>

      <aside class="contact-alt">
        <p class="contact-alt-heading">Just saying hi?</p>
        <p><span class="mono-label">Email</span> <a href="mailto:jeryldevsocial@gmail.com">jeryldevsocial@gmail.com</a></p>
        <p><span class="mono-label">Elsewhere</span>
          <a href="https://www.linkedin.com/in/jeryldev/" target="_blank" rel="noopener">LinkedIn</a>
          <span class="sep">·</span>
          <a href="https://github.com/jeryldev" target="_blank" rel="noopener">GitHub</a>
        </p>
      </aside>
    </div>
  </div>
</section>

<script>
document.getElementById('contact-form').addEventListener('submit', function(e) {
  e.preventDefault();

  const name = document.getElementById('name').value;
  const industry = document.getElementById('industry').value;
  const project = document.getElementById('project').value;
  const success = document.getElementById('success').value;
  const timeline = document.getElementById('timeline').value;

  const subject = encodeURIComponent('Consulting inquiry' + (industry ? ' — ' + industry : ''));
  const body = encodeURIComponent(
    'Hi Jeryl,\n\n' +
    'My name is ' + name + '.\n\n' +
    (industry ? 'Industry/Domain: ' + industry + '\n\n' : '') +
    'What I\'m building:\n' + project + '\n\n' +
    (success ? 'What success looks like:\n' + success + '\n\n' : '') +
    (timeline ? 'Timeline: ' + timeline + '\n\n' : '') +
    'Looking forward to hearing from you.'
  );

  window.location.href = 'mailto:jeryldevsocial@gmail.com?subject=' + subject + '&body=' + body;
});
</script>

<style>
  .contact-page-section {
    padding: var(--space-8) 0 var(--space-10);
  }

  .contact-page {
    max-width: var(--width-index);
    margin: 0 auto;
  }

  .contact-page-header {
    margin-bottom: var(--space-6);
  }

  .contact-page-title {
    font-family: "Geist", sans-serif;
    font-size: clamp(1.875rem, 4vw, 2.5rem);
    line-height: 1.15;
    letter-spacing: -0.028em;
    color: var(--secondary);
    margin: var(--space-1) 0 var(--space-3);
    font-weight: 600;
  }

  .contact-page-dek {
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    line-height: 1.6;
    color: var(--text-secondary);
    max-width: 56ch;
    margin-bottom: var(--space-3);
  }

  .contact-page-engagements {
    font-family: "Geist", sans-serif;
    font-size: 0.9375rem;
    line-height: 1.55;
    color: var(--text);
    max-width: 56ch;
    margin: 0;
  }

  .contact-alt-heading {
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    font-weight: 600;
    color: var(--secondary);
    margin: 0 0 var(--space-2) !important;
    letter-spacing: -0.01em;
  }

  .contact-form {
    padding: var(--space-5) 0 var(--space-2);
    margin-bottom: var(--space-5);
  }

  .form-group {
    margin-bottom: var(--space-3);
  }

  .form-group label {
    display: block;
    font-family: "Geist", sans-serif;
    font-size: 0.8125rem;
    font-weight: 600;
    color: var(--secondary);
    letter-spacing: 0.02em;
    margin-bottom: 0.4rem;
    text-transform: none;
  }

  .form-optional {
    color: var(--text-tertiary);
    font-weight: 400;
  }

  .form-group input,
  .form-group textarea {
    width: 100%;
    padding: 0.65rem 0.85rem;
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    border: 1px solid var(--border);
    border-radius: 6px;
    background: var(--light-bg);
    color: var(--text);
    transition: border-color 0.2s ease;
  }

  .form-group input:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: var(--primary);
  }

  .form-group input::placeholder,
  .form-group textarea::placeholder {
    color: var(--text-tertiary);
  }

  .form-group textarea {
    resize: vertical;
    min-height: 7rem;
  }

  .form-note {
    font-family: "Geist", sans-serif;
    font-size: 0.8125rem;
    color: var(--text-tertiary);
    margin: 0.75rem 0 0;
  }

  .contact-alt {
    border-top: 1px solid var(--border);
    padding-top: var(--space-4);
    font-family: "Geist", sans-serif;
    font-size: 0.9375rem;
    color: var(--text-secondary);
  }

  .contact-alt p {
    margin: 0.35rem 0;
  }

  .contact-alt a {
    color: var(--text);
    text-decoration: none;
    border-bottom: 1px solid var(--border);
    transition: color 0.2s ease, border-color 0.2s ease;
  }

  .contact-alt a:hover {
    color: var(--primary);
    border-bottom-color: var(--primary);
  }

  .mono-label {
    font-family: "Geist Mono", monospace;
    font-size: 0.7rem;
    color: var(--text-tertiary);
    text-transform: uppercase;
    letter-spacing: 0.14em;
    margin-right: 0.75rem;
  }

  .contact-alt .sep {
    color: var(--border);
    margin: 0 0.5rem;
  }
</style>
