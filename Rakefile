$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

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
end

