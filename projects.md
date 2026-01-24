---
layout: default
title: Projects
permalink: /projects/
---

<section class="section">
  <div class="container">
    <div class="section-header">
      <h1 class="section-title">Things I've Built</h1>
      <p class="section-subtitle">Projects showcasing technical depth across mobile, backend, and developer tools</p>
    </div>

    <div class="grid-2">
      {% assign sorted_projects = site.data.projects | sort: 'date' | reverse %}
      {% for project in sorted_projects %}
      <div class="card project-card">
        <h3 class="card-title">{{ project.name }}</h3>
        <p class="project-tagline">{{ project.tagline }}</p>

        <div class="project-status" style="margin-bottom: var(--space-2);">
          <span class="badge badge-primary" style="font-size: var(--text-xs);">{{ project.status }}</span>
        </div>

        <div class="project-tech" style="margin-bottom: var(--space-3);">
          {% for tech in project.tech %}
            <span class="badge">{{ tech }}</span>
          {% endfor %}
        </div>

        <p class="card-body">{{ project.description }}</p>

        <ul class="project-highlights" style="font-size: var(--text-sm); line-height: var(--leading-relaxed); margin-bottom: var(--space-4); padding-left: 1.5rem;">
          {% for highlight in project.highlights %}
            <li style="margin-bottom: 0.5rem;">{{ highlight }}</li>
          {% endfor %}
        </ul>

        {% if project.links.size > 0 %}
        <div class="card-footer">
          {% for link in project.links %}
            <a href="{{ link.url }}" class="btn btn-ghost btn-sm" {% if link.url contains 'http' %}target="_blank"{% endif %}>
              {{ link.label }}
            </a>
          {% endfor %}
        </div>
        {% endif %}
      </div>
      {% endfor %}
    </div>
  </div>
</section>

<style>
  .project-card {
    display: flex;
    flex-direction: column;
  }

  .project-tagline {
    font-size: var(--text-sm);
    color: var(--text-secondary);
    font-weight: var(--font-medium);
    margin-bottom: var(--space-2);
  }

  .project-tech {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
  }

  .project-highlights {
    flex-grow: 1;
  }
</style>
