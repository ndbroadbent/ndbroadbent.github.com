desc "Execute all watchers in one process"
task :watch do
  require 'watcher'
  watchers = [Watcher::Haml, Watcher::Jammit, Watcher::Image, Watcher::Asset, Watcher::Tags]
  watchers.each_with_index do |watcher, i|
    i < (watchers.size - 1) ? Thread.new { watcher.watch; }.run : watcher.watch
    sleep 0.05
  end
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
  task(:resize) { require 'watcher/image'; Watcher::Image.regenerate_all }
  desc "Delete all previously generated images"
  task(:delete_resized) { require 'watcher/image'; Watcher::Image.delete_resized }
end

namespace :asset do
  desc "Push changed assets directly into the _site directory. Jekyll takes a while to render posts, and does this last."
  task(:watch) { require 'watcher/asset'; Watcher::Asset.watch }
end

namespace :tags do
  desc 'Watch _posts directory, and regenerate tag indexes on change'
  task(:watch) { require 'watcher/tags'; Watcher::Tags.watch }
end

desc 'Generate tags index and pages'
task :tags do
  require 'watcher/tags'
  Watcher::Tags.regenerate_indexes
end
