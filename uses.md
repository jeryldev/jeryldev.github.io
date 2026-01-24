---
layout: default
title: Uses
permalink: /uses/
---

<section class="section">
  <div class="container">
    <div class="section-header">
      <h1 class="section-title">What I Use</h1>
      <p class="section-subtitle">Tools and technologies that power my work</p>
    </div>

    <div class="grid-2">
      <div class="card uses-card">
        <h2 class="uses-heading">Development</h2>
        <dl class="uses-list">
          <div class="uses-item">
            <dt>Editor</dt>
            <dd><a href="https://github.com/jeryldev/nvim" target="_blank">Neovim</a> (custom config)</dd>
          </div>
          <div class="uses-item">
            <dt>Terminal</dt>
            <dd><a href="https://ghostty.org/" target="_blank">Ghostty</a> with <a href="https://github.com/rebelot/kanagawa.nvim" target="_blank">kanagawa</a> colors</dd>
          </div>
          <div class="uses-item">
            <dt>Multiplexer</dt>
            <dd>tmux with <a href="https://github.com/jeryldev/homebrew-tap" target="_blank">dev-session-manager</a></dd>
          </div>
          <div class="uses-item">
            <dt>Shell</dt>
            <dd>Zsh with custom aliases</dd>
          </div>
          <div class="uses-item">
            <dt>Version Control</dt>
            <dd>Git + GitHub</dd>
          </div>
          <div class="uses-item">
            <dt>Package Manager</dt>
            <dd>uv for Python (10-100x faster)</dd>
          </div>
        </dl>
      </div>

      <div class="card uses-card">
        <h2 class="uses-heading">Tech Stack</h2>
        <dl class="uses-list">
          <div class="uses-item">
            <dt>Backend</dt>
            <dd>Elixir, Phoenix, PostgreSQL</dd>
          </div>
          <div class="uses-item">
            <dt>Frontend</dt>
            <dd>Phoenix LiveView, Tailwind CSS, Alpine.js</dd>
          </div>
          <div class="uses-item">
            <dt>Infrastructure</dt>
            <dd>Fly.io, AWS, TigerBeetle</dd>
          </div>
          <div class="uses-item">
            <dt>AI/ML</dt>
            <dd>Python, RAG, embeddings, vector DBs</dd>
          </div>
        </dl>
      </div>
    </div>

    <div class="grid-2" style="margin-top: var(--space-4);">
      <div class="card uses-card">
        <h2 class="uses-heading">This Site</h2>
        <dl class="uses-list">
          <div class="uses-item">
            <dt>Generator</dt>
            <dd>Jekyll 4.4</dd>
          </div>
          <div class="uses-item">
            <dt>Hosting</dt>
            <dd>GitHub Pages</dd>
          </div>
          <div class="uses-item">
            <dt>Design</dt>
            <dd>Custom CSS with Gruvbox palette</dd>
          </div>
          <div class="uses-item">
            <dt>Philosophy</dt>
            <dd>Fast, accessible, no JS frameworks</dd>
          </div>
        </dl>
      </div>

      <div class="card uses-card uses-card-featured">
        <h2 class="uses-heading">Custom Tools</h2>
        <h3 class="uses-tool-name">
          <a href="https://github.com/jeryldev/homebrew-tap" target="_blank">dev-session-manager</a>
        </h3>
        <p class="uses-tool-tagline">tmux session automation</p>
        <p class="uses-tool-desc">
          Automates tmux setup with pre-configured windows. No more manual session creation when switching between projects.
        </p>
        <pre class="uses-code">brew tap jeryldev/tap
brew install dev-session-manager
dev work  # instant setup</pre>
        <a href="https://github.com/jeryldev/homebrew-tap" target="_blank" class="btn btn-ghost btn-sm">View on GitHub →</a>
      </div>
    </div>

    <hr style="margin: var(--space-8) 0;">

    <p style="font-size: var(--text-sm); color: var(--text-secondary); text-align: center;">
      Inspired by <a href="https://uses.tech/" target="_blank" style="color: var(--primary);">uses.tech</a> — a directory of developer setups
    </p>
  </div>
</section>

<style>
  .uses-card {
    border-left-width: 3px;
  }

  .uses-heading {
    font-size: var(--text-xl);
    color: var(--primary);
    margin-bottom: var(--space-3);
    padding-bottom: var(--space-2);
    border-bottom: 1px solid var(--border);
    text-align: left;
    border-top: none;
    margin-top: 0;
    padding-top: 0;
  }

  .uses-list {
    display: flex;
    flex-direction: column;
    gap: var(--space-2);
  }

  .uses-item {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
  }

  .uses-item dt {
    font-weight: var(--font-semibold);
    color: var(--secondary);
    min-width: 120px;
  }

  .uses-item dd {
    margin: 0;
    color: var(--text);
  }

  .uses-item a {
    color: var(--primary);
    text-decoration: none;
  }

  .uses-item a:hover {
    text-decoration: underline;
  }

  .uses-card-featured {
    border-left-color: var(--primary-light);
  }

  .uses-tool-name {
    font-size: var(--text-lg);
    margin-bottom: var(--space-1);
  }

  .uses-tool-name a {
    color: var(--secondary);
    text-decoration: none;
  }

  .uses-tool-name a:hover {
    color: var(--primary);
  }

  .uses-tool-tagline {
    font-size: var(--text-sm);
    color: var(--text-secondary);
    margin-bottom: var(--space-2);
  }

  .uses-tool-desc {
    margin-bottom: var(--space-3);
  }

  .uses-code {
    background: var(--code-bg);
    padding: var(--space-2);
    font-size: var(--text-sm);
    overflow-x: auto;
    margin-bottom: var(--space-3);
  }

  .btn-sm {
    padding: 0.5rem 1rem;
    font-size: var(--text-sm);
  }

  @media (max-width: 767px) {
    .uses-item {
      flex-direction: column;
      gap: 0.25rem;
    }

    .uses-item dt {
      min-width: auto;
    }
  }
</style>
