require 'watcher'
require 'yaml'

module Watcher
  class Jammit < Watcher::Base
    CONFIG = "_assets.yml"
    CMD    = "jammit -o assets -c #{CONFIG}"

    class << self
      def watched_files
        return @watched_files if @watched_files
        config = YAML.load_file(CONFIG)
        js = config['javascripts']['application'].map{|f| f.sub(/^javascripts\//,'**/') }
        css = config['stylesheets'].map{|m,f|f}.flatten.map{|f| f.sub(/^stylesheets\//,'**/') }

        @watched_files = {:js => js, :css => css}
      end

      def watch
        run_jammit

        puts ">>> Jammit Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor do
          path 'javascripts/' do
            glob Jammit.watched_files[:js]
            %w(update create delete).each {|ac| send(ac.to_sym){|b,r| Jammit.run_jammit(b,r) } }
          end

          path 'stylesheets/' do
            glob Jammit.watched_files[:css]
            %w(update create delete).each {|ac| send(ac.to_sym){|b,r| Jammit.run_jammit(b,r) } }
          end
        end
      end

      def run_jammit(*args)
        puts (args.any? ? ">>> #{args[1]} changed. " : ">>> ") << "Running Jammit..."
        system(CMD)
        puts "    Assets packed."
      end
    end
  end
end

