---
layout: default
title: Projects
permalink: /projects/
---

<section class="projects-section">
  <div class="container">
    <header class="projects-header">
      <span class="section-eyebrow">Work</span>
      <h1 class="projects-title">Things I've built</h1>
      <p class="projects-dek">Indie iOS apps, Neovim plugins, and developer tools — some still shipping, some open-sourced, all things I use myself.</p>
    </header>

    <ol class="projects-list">
      {% assign sorted_projects = site.data.projects | sort: 'date' | reverse %}
      {% for project in sorted_projects %}
        <li class="project-item">
          <time class="project-date" datetime="{{ project.date | date_to_xmlschema }}">{{ project.date | date: "%Y · %b %-d" }}</time>
          <div class="project-body">
            <header class="project-head">
              <h2 class="project-name">{{ project.name }}</h2>
              <span class="project-status">{{ project.status }}</span>
            </header>
            <p class="project-tagline">{{ project.tagline }}</p>
            {% if project.tech %}
              <div class="project-tech">
                {% for tech in project.tech %}<span class="badge">{{ tech }}</span>{% endfor %}
              </div>
            {% endif %}
            <p class="project-desc">{{ project.description }}</p>
            {% if project.highlights %}
              <ul class="project-highlights">
                {% for highlight in project.highlights %}
                  <li>{{ highlight }}</li>
                {% endfor %}
              </ul>
            {% endif %}
            {% if project.links.size > 0 %}
              <div class="project-links">
                {% for link in project.links %}
                  <a href="{{ link.url }}" {% if link.url contains 'http' %}target="_blank" rel="noopener"{% endif %}>{{ link.label }} →</a>
                {% endfor %}
              </div>
            {% endif %}
          </div>
        </li>
      {% endfor %}
    </ol>
  </div>
</section>

<style>
  .projects-section {
    padding: var(--space-8) 0 var(--space-10);
  }

  .projects-header {
    margin: 0 auto var(--space-6);
    max-width: var(--width-index);
  }

  .projects-title {
    font-family: "Geist", sans-serif;
    font-size: clamp(1.875rem, 4vw, 2.5rem);
    line-height: 1.15;
    letter-spacing: -0.028em;
    color: var(--secondary);
    margin: var(--space-1) 0 var(--space-3);
    font-weight: 600;
  }

  .projects-dek {
    font-family: "Geist", sans-serif;
    font-size: 1rem;
    line-height: 1.6;
    color: var(--text-secondary);
    max-width: 60ch;
    margin: 0;
  }

  .projects-list {
    list-style: none;
    margin: 0 auto;
    padding: 0;
    max-width: var(--width-index);
  }

  .project-item {
    display: grid;
    grid-template-columns: 1fr;
    gap: 0.75rem;
    padding: var(--space-5) 0;
    border-bottom: 1px solid var(--border);
  }

  .project-date {
    font-family: "Geist Mono", monospace;
    font-size: 0.75rem;
    font-weight: 500;
    color: var(--text-tertiary);
    text-transform: uppercase;
    letter-spacing: 0.12em;
  }

  .project-body {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
  }

  .project-head {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 0.5rem 1rem;
  }

  .project-name {
    font-family: "Geist", sans-serif;
    font-size: 1.5rem;
    line-height: 1.2;
    letter-spacing: -0.025em;
    color: var(--secondary);
    font-weight: 600;
    margin: 0;
  }

  .project-status {
    font-family: "Geist Mono", monospace;
    font-size: 0.6875rem;
    font-weight: 500;
    color: var(--primary);
    text-transform: uppercase;
    letter-spacing: 0.12em;
    flex-shrink: 0;
  }

  .project-tagline {
    font-family: "Geist", sans-serif;
    font-size: 0.9375rem;
    line-height: 1.45;
    color: var(--text);
    margin: 0;
  }

  .project-tech {
    display: flex;
    flex-wrap: wrap;
    gap: 0;
  }

  .project-desc {
    font-family: "Geist", sans-serif;
    font-size: 0.9375rem;
    line-height: 1.6;
    color: var(--text-secondary);
    margin: 0;
    max-width: 60ch;
  }

  .project-highlights {
    list-style: none;
    padding: 0;
    margin: 0;
    display: grid;
    gap: 0.3rem;
  }

  .project-highlights li {
    font-family: "Geist", sans-serif;
    font-size: 0.875rem;
    line-height: 1.5;
    color: var(--text-secondary);
    padding-left: 1.1rem;
    position: relative;
  }

  .project-highlights li::before {
    content: "→";
    position: absolute;
    left: 0;
    top: 0;
    color: var(--primary);
    font-family: "Geist Mono", monospace;
    font-size: 0.8125rem;
  }

  .project-links {
    display: flex;
    flex-wrap: wrap;
    gap: 1.25rem;
    padding-top: 0.25rem;
  }

  .project-links a {
    font-family: "Geist", sans-serif;
    font-size: 0.875rem;
    font-weight: 500;
    color: var(--text);
    text-decoration: none;
    border-bottom: 1px solid var(--border);
    transition: color 0.2s ease, border-color 0.2s ease;
  }

  .project-links a:hover {
    color: var(--primary);
    border-bottom-color: var(--primary);
  }

  @media (min-width: 768px) {
    .project-item {
      grid-template-columns: 9rem 1fr;
      column-gap: var(--space-5);
      gap: 0;
      align-items: baseline;
    }
    .project-date {
      padding-top: 0.5rem;
    }
  }
</style>
