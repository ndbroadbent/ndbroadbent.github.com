require 'watcher/base'
require 'jekyll'
require 'active_support/core_ext/string'
include Jekyll::Filters

module Watcher
  class Tags < Watcher::Base
    class << self
      def watch
        regenerate_indexes
        puts ">>> Tags Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor do
          path '_posts/' do
            glob '**/*'
            %w(update create delete).each {|ac| send(ac.to_sym){|b,r| Tags.regenerate_indexes } }
          end
        end
      end

      def regenerate_indexes
        @options = Jekyll.configuration({})
        @site = Jekyll::Site.new(@options)
        @site.read_posts('')

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
title: "Categories Index"
---
<div id="content">
  <div id="tag_cloud">
    <h3>Categories</h3>
HTML

        @site.tags.sort.each do |tag, posts|
          font_size = 14 + (posts.count * 1.3);
          html << "<a href=\"/tags/%s/\" style=\"font-size: #{font_size}px;\">%s</a>\n" % [tag, tag.gsub("-", '&nbsp;')]
        end

        html << <<-HTML
  </div>
</div>

{% include default_sidebar.html %}
HTML

        File.open("tags/index.html", 'w+') {|f| f.puts html }
        puts 'Done.'
      end
    end
  end
end

