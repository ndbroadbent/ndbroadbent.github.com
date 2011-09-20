desc "Generate a new post from the default template. Takes params from ENV variables or prompts for input."
task :post do
  require 'generator'
  Generator::Post.new.generate_from_template("_post_templates/default.markdown")
end

