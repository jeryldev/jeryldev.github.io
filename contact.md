---
layout: default
title: Contact
permalink: /contact/
description: "Tell me what's broken. Direct problem diagnosis across accounting, finance, legal tech, and software — any industry welcome. No pitch, no positioning."
---

<section class="section contact-page-section">
  <div class="container">
    <div class="contact-page">
      <header class="contact-page-header">
        <span class="section-eyebrow">Get in touch</span>
        <h1 class="contact-page-title">Tell me what's broken.</h1>
        <p class="contact-page-dek">Direct, honest problem diagnosis. My background spans accounting, finance, and legal tech. Tell me what's failing and I'll tell you if I can fix it — no pitch, no positioning. Any industry welcome.</p>
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
          <label for="problem">What problem are you facing?</label>
          <textarea id="problem" name="problem" rows="5" required placeholder="What's broken? What's frustrating? What have you tried?"></textarea>
        </div>

        <div class="form-group">
          <label for="solved">What would &ldquo;solved&rdquo; look like? <span class="form-optional">(optional)</span></label>
          <textarea id="solved" name="solved" rows="3" placeholder="How would you know it's fixed?"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Send via email →</button>
        <p class="form-note">Opens your email client with the message pre-filled.</p>
      </form>

      <aside class="contact-alt">
        <p><span class="mono-label">Direct</span> <a href="mailto:jeryldevsocial@gmail.com">Send an email</a></p>
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
  const problem = document.getElementById('problem').value;
  const solved = document.getElementById('solved').value;

  const subject = encodeURIComponent('Problem in ' + (industry || 'my industry'));
  const body = encodeURIComponent(
    'Hi Jeryl,\n\n' +
    'My name is ' + name + '.\n\n' +
    (industry ? 'Industry/Domain: ' + industry + '\n\n' : '') +
    'The Problem:\n' + problem + '\n\n' +
    (solved ? 'What "solved" looks like:\n' + solved + '\n\n' : '') +
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
