require 'rubygems'
require 'fssm'
require 'RMagick'

module Watcher
  class Image
    PATH = ["images/_posts/", "**/*.*"]

    class << self
      def watch
        puts ">>> Image Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor(*PATH) do
          update do |base, relative|
            puts ">>> Change detected to image: #{relative}"
            Image.process(relative)
          end
          create do |base, relative|
            puts ">>> Image created: #{relative}"
            Image.process(relative)
          end
          delete do |base, relative|
            puts ">>> Image deleted: #{relative}"
            Image.remove(relative)
          end
        end
      end

      def output_file(filename, x, y)
        ext = filename[/\.[^.]$/, 1]
        debugger
        # photo-540x540.png
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

      def process(file)

        output_file(filename, x, y)

        # convert dragon.gif    -resize 64x64\!  exact_dragon.gif

        clown = Magick::Image.read("clown.jpg").first
        clown.crop_resized!(75, 75, Magick::NorthGravity)
        clown.write('crop_resized.jpg')

        img.resize(540, 540)

        puts "    Assets packed."
      end
    end
  end
end

