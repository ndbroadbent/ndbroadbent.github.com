def load_jekyll
  require 'jekyll'
  include Jekyll::Filters
  @options = Jekyll.configuration({})
  @site = Jekyll::Site.new(@options)
  @site.read_posts('')
end

desc 'Generate tags index and pages'
task :tags do
  load_jekyll
  require 'active_support/core_ext/string'

  puts "Generating tag pages..."

  # Remove tags directory before regenerating
  FileUtils.rm_rf("tags")

  @site.tags.sort.each do |tag, posts|
    html = <<-HTML
---
layout: default
title: "tagged: #{tag}"
---
<div id="content">
  <h2>Listing posts tagged with: #{tag}</h2>
  <div class="posts-list">
    {% for post in site.posts %}
      {% for tag in post.tags %}
        {% if tag == "#{tag}" %}
          {% include post_excerpt.html %}
        {% endif %}
      {% endfor %}
    {% endfor %}
  </div>
</div>

{% include default_sidebar.html %}

HTML

    FileUtils.mkdir_p("tags/#{tag}")
    File.open("tags/#{tag}/index.html", 'w+') {|f| f.puts html }
  end

  puts "Generating tags index (cloud)..."

  # Generate tag cloud as index
  # ----------------------------------------------------

  html = <<-HTML
---
layout: default
title: "Tags Index"
---
<div id="content">
  <div id="tag_cloud">
    <h3>Tags</h3>
HTML

  @site.tags.sort.each do |tag, posts|
    font_size = 14 + (posts.count * 1.3);
    html << "<a href=\"/tags/%s/\" style=\"font-size: #{font_size}px;\">%s</a>\n" % [tag, tag.gsub("-", ' ')]
  end

  html << <<-HTML
  </div>
</div>

{% include default_sidebar.html %}
HTML

  File.open("tags/index.html", 'w+') {|f| f.puts html }
  puts 'Done.'
end

