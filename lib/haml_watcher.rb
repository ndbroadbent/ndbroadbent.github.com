require 'rubygems'
require 'fssm'
require 'haml'

module HamlWatcher
  HAML_PATH = "_haml"
  class << self
    def watch
      refresh
      puts ">>> HamlWatcher is watching for changes. Press Ctrl-C to Stop."
      FSSM.monitor(HAML_PATH, "**/*.haml") do
        update do |base, relative|
          puts ">>> Change detected to: #{relative}"
          HamlWatcher.compile(relative)
        end
        create do |base, relative|
          puts ">>> File created: #{relative}"
          HamlWatcher.compile(relative)
        end
        delete do |base, relative|
          puts ">>> File deleted: #{relative}"
          HamlWatcher.remove(relative)
        end
      end
    end

    def output_file(filename)
      # './haml' subdirs retain base folder structure
      filename.gsub(/\.html\.haml$/,'.html')
    end

    def remove(file)
      output = output_file(file)
      begin
        File.delete output
        puts "\033[0;31m   remove\033[0m #{output}"
      rescue
      end
    end

    def compile(file)
      output_file_name = output_file(file)
      begin
        origin = File.open(File.join(HAML_PATH, file)).read
        result = Haml::Engine.new(origin).render
        # Write rendered HTML to file
        color, action = File.exist?(output_file_name) ? [33, 'overwrite'] : [32, '   create']
        puts "\033[0;#{color}m#{action}\033[0m #{output_file_name}"
        File.open(output_file_name,'w') {|f| f.write(result)}
      rescue Exception => ex
        puts "\033[1;31m!!! Error while processing #{file}: #{ex.message}\033[0m"
      end
    end

    # Check that all haml templates have been rendered.
    def refresh
      Dir.glob("#{HAML_PATH}/**/*.haml").each do |file|
        file.gsub!(/^_haml\//, '')
        compile(file) unless File.exist?(output_file(file))
      end
    end
  end
end

