$: << File.expand_path(File.join(File.dirname(__FILE__), "lib"))

namespace :haml do
  desc "Watch the site's HAML templates and recompile them when they change"
  task :watch do
    require 'haml_watcher'
    HamlWatcher.watch
  end
end

namespace :jammit do
  desc "Watch files specified in _assets.yml, and run the Jammit compressor when they change"
  task :watch do
    require 'jammit_watcher'
    JammitWatcher.watch
  end
end

