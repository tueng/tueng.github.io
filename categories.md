---
layout: archive
---
<!-- The following part extracts all the categories from your posts and sort categories, so that you do not need to manually collect your categories to a place. -->

{% assign rawcategories = "" %}
{% for post in site.posts %}
{% assign tcategories = post.categories | join:'|' | append:'|' %}
{% assign rawcategories = rawcategories | append:tcategories %}
{% endfor %}
{% assign rawcategories = rawcategories | split:'|' | sort %}


<!-- The following part removes dulpicated categories and invalid categories like blank category. -->

{% assign categories = "" %}
{% for category in rawcategories %}
{% if category != "" %}
{% if categories == "" %}
{% assign categories = category | split:'|' %}
{% endif %}
{% unless categories contains category %}
{% assign categories = categories | join:'|' | append:'|' | append:category | split:'|' %}
{% endunless %}
{% endif %}
{% endfor %}
<!--- -->


<!-- table of contents -->
<div class="archive-page clearfix">
	<!-- table of contents -->
	<nav id="archive-toc"></nav>

	<!-- categories -->
	<section id="archive-wrapper">
		<div id="archive-inner">
			<!-- page title -->
			<h1>All categories</h1>

			<!-- list all category groups and items -->
			<div id="archive-content">
				{% for category in categories %}
				<div class="archive-group">
					<h2 class="group-title" id="category-{{ category | slugify }}">{{ category }}</h2>

					{% for post in site.posts %}
					{% if post.categories contains category %}
					<a class="post-title" href="{{ post.url }}">
						{{ post.title }}&nbsp;
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
