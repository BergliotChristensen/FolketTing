---
layout: default
---

# Welcome to my blog!

{% for post in site.posts %}
  <article class="post">
    <h2>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    </h2>
    <div class="post-meta">{{ post.date | date: "%B %d, %Y" }}</div>
    {% if post.description %}
      <p>{{ post.description }}</p>
    {% endif %}
  </article>
{% endfor %}
