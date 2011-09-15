--- 
layout: post
title: Bundler with a plugin
wordpress_id: 122
tags: guide, ruby, ruby-gems, ruby-on-rails
date: 2010-08-20 15:09:31 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=122
---
What do you do if you want to use bundler to set up the gem environment for a plugin? Bundler will look at the 'superproject's working directory, and wont find the plugin's Gemfile. The best solution is to temporarily change the current working directory to the plugins directory. Ruby lets us call Dir.chdir with a block,  like this:
<pre>Dir.chdir File.join(File.dirname(__FILE__)) do
    Bundler.setup
end</pre>
