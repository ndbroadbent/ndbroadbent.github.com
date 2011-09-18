require 'watcher/base'

module Watcher
  class Asset < Watcher::Base
    class << self
      def watch
        puts ">>> Changed assets will be immediately written into _site directory. Press Ctrl-C to Stop."
        FSSM.monitor do
          %w(javascripts stylesheets images).each do |asset|
            path "#{asset}/" do
              glob "**/*"
              %w(update create).each {|ac| send(ac.to_sym){|b,r| Asset.push_asset(asset,r) } }
            end
          end
        end
      end

      def push_asset(base, relative)
        path = File.join(base, relative)
        site_path = File.join("_site", path)
        # Ensure directory exists in _site
        system("mkdir -p #{File.dirname(site_path)}")
        # Copy file with system command
        system("cp -f #{path} #{site_path}")
        puts ">>> #{relative} pushed to '#{site_path}'."
      end
    end
  end
end

