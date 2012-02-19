require 'jekyll'
include Jekyll::Filters

module Generator
  class Post
    def initialize(options = {})
      @options = options
      @time = Time.now
      @params = post_params_from_user_input
      @params["date"] = @time.to_s
    end

    def jekyll_site
      @site ||= begin
        s = Jekyll::Site.new(Jekyll.configuration({}))
        s.read_posts('')
        s
      end
    end

    def popular_tags(count=-1)
      jekyll_site.tags.sort.map{|t, p| [p.count, t] }.sort {|x,y| y <=> x }.map(&:last)[0..count]
    end

    def choose_tags
      # select tags from a list of the 10 most common tags
      tags = []
      show_tags = 10
      begin
        choice = choose do |menu|
          menu.prompt = "Please choose some tags. Choose 'Done' when finished:"
          menu.choices(*popular_tags(show_tags))
          menu.choice(:Other) { ask("Tag: ") }
          menu.choice('Remove Last Tag')
          menu.choice('Show All Tags')
          menu.choice(:Done)
        end
        case choice
        when 'Remove Last Tag'; tags.pop
        when 'Show All Tags'; show_tags = -1
        when :Done
        else
          tags << choice
        end
        tags = tags.uniq
        puts "Current tag list: #{tags.join(', ')}"
      end while choice != :Done
      tags
    end

    def post_params_from_user_input
      params = {}
      params["title"] = ask("Title:  ") { |q| q.validate = /.+/ }
      params["tags"] = choose_tags.join(' ')
      params
    end

    def generate_from_template(file)
      template = File.read(file)

      date = @time.strftime("%Y-%m-%d")
      slug = @params["title"].downcase.gsub(/[^\w]/, '-').gsub(/--+/, '-')
      output_file = File.join("_posts", "#{date}-#{slug}.markdown")

      rendered = Liquid::Template.parse(template).render(@params)
      File.open(output_file, 'w') {|f| f.puts rendered }
      puts "== Generated new post from template, saved at '#{output_file}'."

      create_images_dir!
      edit_file(output_file)
    end

    # Run this command after creating a new post
    def edit_file(file)
      puts "===== Editing post with Geany..."
      system("nohup geany #{file}:8 > /dev/null &")
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

