$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))
require 'ruby-debug'

desc "Generate a new post from the default template. Takes params from ENV variables or prompts for input."
task :post do
  require 'generators'
  Generators::Post.new.generate_from_template("_post_templates/default.markdown")
end

namespace :haml do
  desc "Watch the site's HAML templates and recompile them when they change"
  task(:watch) { require 'watcher/haml'; Watcher::Haml.watch }
end

namespace :jammit do
  desc "Watch files specified in _assets.yml, and run the Jammit compressor when they change"
  task(:watch) { require 'watcher/jammit'; Watcher::Jammit.watch }
end

namespace :image do
  desc "Watch images in images/posts, and create resized versions & thumbnails"
  task(:watch) { require 'watcher/image'; Watcher::Image.watch }
  desc "Delete all previously generated images, and regenerates from Watcher::Image::SIZES"
  task(:regenerate) { require 'watcher/image'; Watcher::Image.regenerate_all }
end

