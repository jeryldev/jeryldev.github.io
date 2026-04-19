---
layout: default
title: Uses — Tools and Stack
permalink: /uses/
description: "The tools and technologies behind the software I ship: Neovim with citruszest-ghostty, Ghostty, tmux with dev-session-manager, Elixir, Phoenix, Ecto, Ash, Python, React, and Expo."
---

<section class="uses-section">
  <div class="container">
    <header class="uses-header">
      <span class="section-eyebrow">Setup</span>
      <h1 class="uses-title">What I use</h1>
      <p class="uses-dek">The tools and technologies behind the software I ship. Updated when something actually changes — not a wishlist.</p>
    </header>

    <div class="uses-block">
      <h2 class="uses-group">Development</h2>
      <dl class="uses-list">
        <div class="uses-row">
          <dt>Editor</dt>
          <dd><a href="https://github.com/jeryldev/nvim" target="_blank" rel="noopener">Neovim</a> with a custom LazyVim config</dd>
        </div>
        <div class="uses-row">
          <dt>Colorscheme</dt>
          <dd><a href="https://github.com/jeryldev/citruszest-ghostty.nvim" target="_blank" rel="noopener">citruszest-ghostty.nvim</a> — my own palette, shared with the terminal</dd>
        </div>
        <div class="uses-row">
          <dt>Terminal</dt>
          <dd><a href="https://ghostty.org/" target="_blank" rel="noopener">Ghostty</a></dd>
        </div>
        <div class="uses-row">
          <dt>Multiplexer</dt>
          <dd>tmux with <a href="https://github.com/jeryldev/homebrew-tap" target="_blank" rel="noopener">dev-session-manager</a></dd>
        </div>
        <div class="uses-row">
          <dt>Notes</dt>
          <dd>Obsidian with <a href="https://github.com/jeryldev/obsidian-cli.nvim" target="_blank" rel="noopener">obsidian-cli.nvim</a></dd>
        </div>
        <div class="uses-row">
          <dt>Python</dt>
          <dd><a href="https://github.com/jeryldev/pyworks.nvim" target="_blank" rel="noopener">pyworks.nvim</a> with uv for package management</dd>
        </div>
        <div class="uses-row">
          <dt>Shell</dt>
          <dd>Zsh with custom aliases</dd>
        </div>
        <div class="uses-row">
          <dt>Version control</dt>
          <dd>Git + GitHub</dd>
        </div>
      </dl>
    </div>

    <div class="uses-block">
      <h2 class="uses-group">Stack</h2>
      <dl class="uses-list">
        <div class="uses-row">
          <dt>Backend</dt>
          <dd>Elixir, Phoenix, Ecto, PostgreSQL, Ash</dd>
        </div>
        <div class="uses-row">
          <dt>Frontend</dt>
          <dd>Phoenix LiveView, Tailwind CSS, JavaScript, TypeScript</dd>
        </div>
        <div class="uses-row">
          <dt>Mobile</dt>
          <dd>Expo (React Native), TypeScript</dd>
        </div>
        <div class="uses-row">
          <dt>Storage</dt>
          <dd>PostgreSQL, SQLite (expo-sqlite), TigerBeetle for double-entry</dd>
        </div>
        <div class="uses-row">
          <dt>Infrastructure</dt>
          <dd>Fly.io, AWS, Vercel</dd>
        </div>
        <div class="uses-row">
          <dt>AI / ML</dt>
          <dd>Python, Claude API, Gemini API, RAG, embeddings, vector DBs</dd>
        </div>
        <div class="uses-row">
          <dt>Scripting</dt>
          <dd>Lua (Neovim plugins), Bash (automation)</dd>
        </div>
      </dl>
    </div>

    <div class="uses-block">
      <h2 class="uses-group">This site</h2>
      <dl class="uses-list">
        <div class="uses-row">
          <dt>Generator</dt>
          <dd>Jekyll 4.4</dd>
        </div>
        <div class="uses-row">
          <dt>Hosting</dt>
          <dd>GitHub Pages</dd>
        </div>
        <div class="uses-row">
          <dt>Type</dt>
          <dd>Geist (body + headings), Geist Mono (labels, code)</dd>
        </div>
        <div class="uses-row">
          <dt>Accent</dt>
          <dd>Citruszest mint green — shared with the editor colorscheme</dd>
        </div>
        <div class="uses-row">
          <dt>Philosophy</dt>
          <dd>Fast, accessible, no JS framework, no tracking</dd>
        </div>
      </dl>
    </div>

    <p class="uses-footer">
      Inspired by <a href="https://uses.tech/" target="_blank" rel="noopener">uses.tech</a> — a directory of developer setups.
    </p>
  </div>
</section>

<style>
  .uses-section {
    padding: var(--space-8) 0 var(--space-10);
  }

  .uses-header {
    margin: 0 auto var(--space-6);
    max-width: var(--width-index);
  }

  .uses-title {
    font-family: "Geist", sans-serif;
    font-size: clamp(1.875rem, 4vw, 2.5rem);
    line-height: 1.15;
    letter-spacing: -0.028em;
    color: var(--secondary);
    margin: var(--space-1) 0 var(--space-3);
    font-weight: 600;
  }

  .uses-dek {
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    line-height: 1.6;
    color: var(--text-secondary);
    max-width: 56ch;
    margin: 0;
  }

  .uses-block {
    max-width: var(--width-index);
    margin: 0 auto var(--space-6);
    padding-top: var(--space-5);
    border-top: 1px solid var(--border);
  }

  .uses-block:first-of-type {
    border-top: none;
    padding-top: 0;
  }

  .uses-group {
    font-family: "Geist", sans-serif;
    font-size: 0.75rem;
    font-weight: 500;
    color: var(--text-tertiary);
    text-transform: uppercase;
    letter-spacing: 0.12em;
    margin: 0 0 var(--space-4);
  }

  .uses-list {
    margin: 0;
    padding: 0;
    display: grid;
    gap: 0.75rem;
  }

  .uses-row {
    display: grid;
    grid-template-columns: 1fr;
    gap: 0.15rem 1rem;
    align-items: baseline;
  }

  .uses-row dt {
    font-family: "Geist Mono", monospace;
    font-size: 0.75rem;
    font-weight: 500;
    color: var(--text-tertiary);
    text-transform: uppercase;
    letter-spacing: 0.08em;
  }

  .uses-row dd {
    margin: 0;
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    line-height: 1.5;
    color: var(--text);
  }

  .uses-row dd a {
    color: var(--primary);
    text-decoration: none;
    border-bottom: 1px solid transparent;
    transition: border-color 0.2s ease;
  }

  .uses-row dd a:hover {
    border-bottom-color: var(--primary);
  }

  .uses-footer {
    max-width: var(--width-index);
    margin: var(--space-8) auto 0;
    padding-top: var(--space-4);
    border-top: 1px solid var(--border);
    font-family: "Geist", sans-serif;
    font-size: 0.875rem;
    color: var(--text-tertiary);
  }

  .uses-footer a {
    color: var(--text-secondary);
    text-decoration: none;
    border-bottom: 1px solid var(--border);
  }

  .uses-footer a:hover {
    color: var(--primary);
    border-bottom-color: var(--primary);
  }

  @media (min-width: 768px) {
    .uses-row {
      grid-template-columns: 10rem 1fr;
      gap: 1rem;
    }
  }
</style>
