require 'rubygems'
require 'fssm'
require 'yaml'

module JammitWatcher
  JAMMIT_CONFIG = "_assets.yml"
  JAMMIT_CMD = "jammit -o assets -c #{JAMMIT_CONFIG}"

  class << self
    def watched_files
      return @watched_files if @watched_files
      config = YAML.load_file(JAMMIT_CONFIG)
      js = config['javascripts']['application'].map{|f| f.sub(/^javascripts\//,'**/') }
      css = config['stylesheets'].map{|m,f|f}.flatten.map{|f| f.sub(/^stylesheets\//,'**/') }

      @watched_files = {:js => js, :css => css}
    end

    def watch
      run_jammit

      puts ">>> JammitWatcher is watching for changes. Press Ctrl-C to Stop."
      FSSM.monitor do
        path 'javascripts/' do
          glob JammitWatcher.watched_files[:js]
          %w(update create delete).each {|ac| send(ac.to_sym){|b,r| JammitWatcher.run_jammit(b,r) } }
        end

        path 'stylesheets/' do
          glob JammitWatcher.watched_files[:css]
          %w(update create delete).each {|ac| send(ac.to_sym){|b,r| JammitWatcher.run_jammit(b,r) } }
        end
      end
    end

    def run_jammit(*args)
      puts (args.any? ? ">>> #{args[1]} changed. " : ">>> ") << "Running Jammit..."
      system(JAMMIT_CMD)
      puts "    Assets packed."
    end
  end
end

