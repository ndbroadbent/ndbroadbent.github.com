module Generator
  class Post
    def initialize(options = {:edit_with => :geany})
      @options = options
      @time = Time.now
      if ENV["title"]
        @params = %w(title excerpt tags content).inject({}){|h,n| h[n] = ENV[n]; h }
      else
        @params = params_from_input
      end
      @params["date"] = @time.to_s
    end

    def params_from_input
      params = {}
      params["title"] = ask("Title:  ") { |q| q.validate = /.+/ }
      params["excerpt"] = ask("Excerpt:  ") { |q| q.default = params["title"] }
      params["tags"] = ask("Tags:  ") { |q| q.default = "uncategorized" }
      params
    end

    def generate_from_template(file)
      template = File.read(file)

      date = @time.strftime("%Y-%m-%d")
      slug = @params["title"].downcase.gsub(/[^\w]/, '-').gsub(/--+/, '-')
      output_file = File.join("_posts", "#{date}-#{slug}.markdown")

      rendered = Liquid::Template.parse(template).render(@params)
      File.open(output_file, 'w') {|f| f.puts rendered }
      puts "== Generated new post from template at '#{output_file}'."

      create_images_dir!
      edit_file(output_file, @options[:edit_with]) if @options[:edit_with]
    end

    # Run this command after creating a new post
    def edit_file(file, editor)
      puts "===== Editing post with #{editor}..."
      case editor
      when :gedit; system("nohup gedit #{file} > /dev/null &")
      when :gedit; system("nohup geany #{file}:9 > /dev/null &")
      end
    end

    protected

    def create_images_dir!
      # Ensure a 'images/posts/{year}/{month}' directory for post images
      images_dir = File.join("images", "posts", @time.year.to_s, "%02d" % @time.month)
      unless File.exist?(images_dir)
        puts "===== Creating image directory: #{images_dir}"
        `mkdir -p #{images_dir}`
      end
    end
  end
end

