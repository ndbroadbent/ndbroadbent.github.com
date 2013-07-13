---
layout: post
title: RSpec tasks on Rails 3
wordpress_id: 125
tags: rspec rails-3 bugfixes rails
date: 2010-09-25 19:51:35 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=125
---
Problem:
uninitialized constant RSpec::Rake

Solution:

You are using rails 3 (and rspec 2), and trying to define a custom rake task with <code>Spec::Rake::SpecTask.new</code>

Instead, do:

{% highlight ruby %}
RSpec::Core::RakeTask.new(:spec) do |t|
...
{% endhighlight %}

and make sure to change:

{% highlight ruby %}
t.spec_files = FileList['spec/**/*_spec.rb']
{% endhighlight %}

to

{% highlight ruby %}
t.pattern   = 'spec/**/*_spec.rb'
{% endhighlight %}

