require 'watcher'
require 'RMagick'

module Watcher
  class Image < Watcher::Base
    PATH = ["images/posts/", "**/*.*"]
    SIZES = {:post => [540, 540], :thumb => [75, 75]}

    class << self
      def watch
        puts ">>> Image Watcher is watching for changes. Press Ctrl-C to Stop."
        FSSM.monitor(*PATH) do
          update do |base, relative|
            unless Image.is_processed?(relative)
              puts ">>> Change detected to image: #{relative}"
              Image.process(Image.full_path(relative))
            end
          end
          create do |base, relative|
            unless Image.is_processed?(relative)
              puts ">>> Image created: #{relative}"
              Image.process(Image.full_path(relative))
            end
          end
        end
      end

      def is_processed?(file)
        file =~ /-\d+x\d+\./
      end

      def full_path(file)
        File.join(PATH.first, file)
      end

      def output_file(file, x, y)
        ext = file[/\.([^\.]*)$/, 1]
        filename = file.sub(Regexp.new("\\.#{ext}$"), '')
        "#{filename}-#{x}x#{y}.#{ext}"
      end

      def process(file)
        sizes = SIZES.dup
        image = Magick::Image.read(file).first

        # Process thumbnail
        sizes.delete(:thumb).tap do |x, y|
          thumb = image.crop_resized(75, 75, Magick::NorthGravity)
          dest = output_file(file, x, y)
          puts status_message(dest)
          thumb.write(dest)
        end
        # Process other sizes
        sizes.each do |tag, (x, y)|
          resized = image.resize_to_fit(x, y)
          dest = output_file(file, x, y)
          puts status_message(dest)
          resized.write(dest)
        end
      end

      def regenerate_all
        # 1st pass - delete previously generated images
        Dir.glob(PATH.join).each do |file|
          if is_processed?(file)
            puts "\033[0;31m   remove\033[0m #{file}"
            File.delete(file)
          end
        end
        # 2nd pass - regenerate
        Dir.glob(PATH.join).each {|file| process(file) }
      end
    end
  end
end

