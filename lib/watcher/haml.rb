require 'watcher'
require 'haml'

module Watcher
  class Haml < Watcher::Base
    class << self
      def watch
        refresh
        puts ">>> Haml Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor(config["path"], "**/*.haml") do
          update do |base, relative|
            puts ">>> Change detected to: #{relative}"
            Haml.compile(relative)
          end
          create do |base, relative|
            puts ">>> File created: #{relative}"
            Haml.compile(relative)
          end
          delete do |base, relative|
            puts ">>> File deleted: #{relative}"
            Haml.remove(relative)
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
          origin = File.open(File.join(config["path"], file)).read
          result = ::Haml::Engine.new(origin).render
          # Ensure output directory exists
          system("mkdir -p #{File.dirname(output_file_name)}")
          File.open(output_file_name,'w') {|f| f.write(result)}
          # Write rendered HTML to file
          puts status_message(output_file_name)
        rescue Exception => ex
          puts "\033[1;31m!!! Error while processing #{file}: #{ex.message}\033[0m"
        end
      end

      # Check that all haml templates have been rendered.
      def refresh
        glob_pattern = File.join(config["path"], "**/*.haml")
        Dir.glob(glob_pattern).each do |file|
          file.gsub!(/^_haml\//, '')
          compile(file) unless File.exist?(output_file(file))
        end
      end
    end
  end
end

