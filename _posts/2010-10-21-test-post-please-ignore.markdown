---
layout: post
title: Test Post, Please Ignore
excerpt: Testing Jekyll blog
keywords: jekyll, rails, ruby, rails 3.1
---

## This is a test post.

Here is some ruby:

{% highlight ruby linenos %}
module Jekyll
  class Site
    def compile_haml(files, input_regex, output_extension)
      Dir.glob(files).each do |file|
        # './_haml' retains the base directory structure
        # (i.e. pop 'haml/' and '.haml' to obtain output path)
        output_file_name = file.gsub(input_regex,output_extension).gsub(/^haml\//, '')
        origin = File.open(file).read
        puts "HAML: Rendering #{file} to #{output_file_name}..."
        result = Haml::Engine.new(origin).render
        raise HamlErrorException.new if result.empty?
        # Write rendered HTML to file
        if !File.exists?(output_file_name) || result != File.read(output_file_name)
          File.open(output_file_name,'w') {|f| f.write(result)}
        end
      end
    end
  end
end
{% endhighlight %}

Feel free to have some bash:

{% highlight bash %}
sudo apt-get install cowsay
{% endhighlight %}

### What has been changed?

No more wordpress!

[I'm on github.]:https://github.com/ndbroadbent

