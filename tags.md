---
layout: archive
---
<!-- The following part extracts all the tags from your posts and sort tags, so that you do not need to manually collect your tags to a place. -->

{% assign rawtags = "" %}
{% for post in site.posts %}
{% assign ttags = post.tags | join:'|' | append:'|' %}
{% assign rawtags = rawtags | append:ttags %}
{% endfor %}
{% assign rawtags = rawtags | split:'|' | sort %}


<!-- The following part removes dulpitaged tags and invalid tags like blank tag. -->

{% assign tags = "" %}
{% for tag in rawtags %}
{% if tag != "" %}
{% if tags == "" %}
{% assign tags = tag | split:'|' %}
{% endif %}
{% unless tags contains tag %}
{% assign tags = tags | join:'|' | append:'|' | append:tag | split:'|' %}
{% endunless %}
{% endif %}
{% endfor %}
<!--- -->


<!-- table of contents -->
<div class="archive-page clearfix">
	<!-- table of contents -->
	<nav id="archive-toc"></nav>

	<!-- tags -->
	<section id="archive-wrapper">
		<div id="archive-inner">
			<!-- page title -->
			<h1>All tags</h1>

			<!-- list all tag groups and items -->
			<div id="archive-content">
				{% for tag in tags %}
				<div class="archive-group">
					<h2 class="group-title" id="tag-{{ tag | slugify }}">{{ tag }}</h2>

					{% for post in site.posts %}
					{% if post.tags contains tag %}
					<a class="post-title" href="{{ post.url }}">
						{{ post.title }} &nbsp;
						<time class="post-date">{{ post.date | date: "%d %b %Y"}}</time>
					</a>
					{% endif %}
					{% endfor %}
				</div>
				{% endfor %}
			</div>
		</div>
	</section>
</div>
