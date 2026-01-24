---
layout: default
title: Contact
permalink: /contact/
---

<section class="section">
  <div class="container">
    <div class="contact-page">
      <div class="section-header">
        <h1 class="section-title">Let's Talk</h1>
        <p class="section-subtitle">Have a problem worth solving? I'd love to hear about it.</p>
      </div>

      <div class="contact-intro">
        <p>
          I'm genuinely curious about problems across industries — not just tech.
          Whether you're in healthcare, education, logistics, retail, or something I've never encountered,
          I want to understand what's broken and why.
        </p>
        <p>
          My background spans accounting, finance, and legal tech, but the pattern is always the same:
          understand the real problem first, then figure out if technology can help.
        </p>
        <p>
          <strong>No pitch required.</strong> Just tell me what you're dealing with.
        </p>
      </div>

      <form id="contact-form" class="contact-form">
        <div class="form-group">
          <label for="name">Your Name</label>
          <input type="text" id="name" name="name" required placeholder="What should I call you?">
        </div>

        <div class="form-group">
          <label for="industry">Industry / Domain</label>
          <input type="text" id="industry" name="industry" placeholder="e.g., Healthcare, Education, Logistics, Finance...">
        </div>

        <div class="form-group">
          <label for="problem">What problem are you facing?</label>
          <textarea id="problem" name="problem" rows="5" required placeholder="What's broken? What's frustrating? What have you tried?"></textarea>
        </div>

        <div class="form-group">
          <label for="solved">What would "solved" look like? (optional)</label>
          <textarea id="solved" name="solved" rows="3" placeholder="How would you know it's fixed?"></textarea>
        </div>

        <button type="submit" class="btn btn-primary">Send via Email</button>
        <p class="form-note">This will open your email client with the message pre-filled.</p>
      </form>

      <div class="contact-alt">
        <p>Prefer to write directly? <a href="mailto:jeryldevsocial@gmail.com">jeryldevsocial@gmail.com</a></p>
      </div>

      <div class="contact-social">
        <p>You can also find me on:</p>
        <div class="social-links">
          <a href="https://www.linkedin.com/in/jeryldev/" target="_blank" class="btn btn-ghost">LinkedIn</a>
          <a href="https://github.com/jeryldev" target="_blank" class="btn btn-ghost">GitHub</a>
        </div>
      </div>
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
  .contact-page {
    max-width: 900px;
    margin: 0 auto;
  }

  .contact-intro {
    margin-bottom: var(--space-6);
    font-size: var(--text-base);
    line-height: var(--leading-relaxed);
  }

  .contact-intro p {
    margin-bottom: var(--space-3);
  }

  .contact-form {
    background: var(--card-bg);
    padding: var(--space-6);
    border-left: 4px solid var(--primary);
    margin-bottom: var(--space-6);
  }

  .form-group {
    margin-bottom: var(--space-4);
  }

  .form-group label {
    display: block;
    font-weight: var(--font-semibold);
    color: var(--secondary);
    margin-bottom: var(--space-1);
  }

  .form-group input,
  .form-group textarea {
    width: 100%;
    padding: var(--space-2);
    font-size: var(--text-base);
    font-family: inherit;
    border: 2px solid var(--border);
    background: var(--light-bg);
    color: var(--text);
    transition: border-color 0.3s ease;
  }

  .form-group input:focus,
  .form-group textarea:focus {
    outline: none;
    border-color: var(--primary);
  }

  .form-group input::placeholder,
  .form-group textarea::placeholder {
    color: var(--text-secondary);
    opacity: 0.7;
  }

  .form-group textarea {
    resize: vertical;
    min-height: 100px;
  }

  .contact-form .btn {
    width: 100%;
    padding: var(--space-3);
    font-size: var(--text-lg);
  }

  .form-note {
    text-align: center;
    font-size: var(--text-sm);
    color: var(--text-secondary);
    margin-top: var(--space-2);
    margin-bottom: 0;
  }

  @media (min-width: 768px) {
    .contact-form .btn {
      width: auto;
      padding: var(--space-2) var(--space-6);
      font-size: var(--text-base);
    }
  }

  .contact-alt {
    text-align: center;
    margin-bottom: var(--space-6);
    color: var(--text-secondary);
  }

  .contact-alt a {
    color: var(--primary);
    font-weight: var(--font-medium);
  }

  .contact-social {
    text-align: center;
    padding-top: var(--space-6);
    border-top: 2px solid var(--border);
  }

  .contact-social p {
    color: var(--text-secondary);
    margin-bottom: var(--space-3);
  }

  .contact-social .social-links {
    display: flex;
    gap: var(--space-3);
    justify-content: center;
    flex-wrap: wrap;
  }
</style>
