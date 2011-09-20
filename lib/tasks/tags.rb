def load_jekyll
  require 'jekyll'
  include Jekyll::Filters
  @options = Jekyll.configuration({})
  @site = Jekyll::Site.new(@options)
  @site.read_posts('')
end

namespace :tags do
  desc "Generate a tag cloud for sidebar"
  task :cloud do
    load_jekyll

    puts 'Generating tag cloud...'
    html = ''
    @site.tags.sort.each do |tag, posts|
      s = posts.count
      font_size = 12 + (s*1.2);
      html << "<a href=\"#{@options["url"]}/tag/#{tag}/\" title=\"Pages tagged #{tag}\" style=\"font-size: #{font_size}px; line-height:#{font_size}px\" rel=\"tag\">#{tag}</a>\n"
    end

    FileUtils.mkdir_p "tags"
    File.open('_includes/tags.html', 'w+') do |file|
      file.puts html
    end
    puts 'Done.'
  end

  task :index do

  end
end


desc 'Generate tags pages'
task :tags do
  load_jekyll

  puts "Generating tags..."

  # Remove tags directory before regenerating
  FileUtils.rm_rf("tags")

  @site.tags.sort.each do |tag, posts|
    html = <<-HTML
---
layout: default
title: "tagged: #{tag}"
---
<div id="content">
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
    File.open("tags/#{tag}/index.html", 'w+') do |file|
      file.puts html
    end
  end
  puts 'Done.'
end

