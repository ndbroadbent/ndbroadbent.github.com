require 'watcher'
require 'haml'

module Watcher
  class Haml < Watcher::Base
    PATH = "_haml"
    class << self
      def watch
        refresh
        puts ">>> Haml Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor(PATH, "**/*.haml") do
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
          origin = File.open(File.join(PATH, file)).read
          result = ::Haml::Engine.new(origin).render
          File.open(output_file_name,'w') {|f| f.write(result)}
          # Write rendered HTML to file
          puts status_message(output_file_name)
        rescue Exception => ex
          puts "\033[1;31m!!! Error while processing #{file}: #{ex.message}\033[0m"
        end
      end

      # Check that all haml templates have been rendered.
      def refresh
        Dir.glob("#{PATH}/**/*.haml").each do |file|
          file.gsub!(/^_haml\//, '')
          compile(file) unless File.exist?(output_file(file))
        end
      end
    end
  end
end

