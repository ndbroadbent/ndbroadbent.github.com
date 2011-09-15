--- 
layout: post
title: Cucumber generator not found with Rails 2.3.8
wordpress_id: 127
tags: thoughts
date: 2010-08-22 22:27:25 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=127
---
Your starting a new Rails app, with 2.3.8. You've installed cucumber, cucumber-rails and capybara, but ...
<pre>$ ./script/generate cucumber --capybara
Couldn't find 'cucumber' generator</pre>
<h2><strong>?</strong></h2>
sudo gem install bundler --pre

(latest version fixes this issue and loads all gems for generators to use.)
