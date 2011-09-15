--- 
layout: post
title: jqgrid on Spree
wordpress_id: 59
tags: guide, ruby, ruby-gems, ruby-on-rails
date: 2010-04-30 17:22:57 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=59
---
Been a fan of jqgrid for quite some time, but wasn't looking forward to the struggle of getting it to work with Rails.

As always, someones already done it for me:<a href="http://www.2dconcept.com/jquery-grid-rails-plugin"> http://www.2dconcept.com/jquery-grid-rails-plugin</a>

Quite literally, that has saved me days or even weeks of work! And instantly made my app look a heck of a lot more stylish :)

It did take a little while to debug some things that were going wrong, though. Firebug was giving me the error: "$.jgrid.formatter is undefined". After some digging around, I realized that no jqgrid locale files were being loaded.

By default, Spree has its i18n locale set to "en-US". <a href="http://www.2dconcept.com/jquery-grid-rails-plugin" target="_blank">2dcJqgrid</a> has a fancy method that sets the jqgrid locale to the same locale as your Rails app, but unfortunately that breaks down for any 'en-**' locales, because jqgrid only has the one 'en' locale file in its 'i18n' directory.

The simple fix is to change the file '2dc_jqgrid.rb' (starting from line 11), from this:
<pre>def jqgrid_javascripts
    locale = I18n.locale rescue :en
    js =  ''
    ...
</pre>
to this:
<pre>
<pre>def jqgrid_javascripts
    locale = I18n.locale rescue :en
    locale = :en if locale.to_s.start_with?("en")
    js =  ''
    ...</pre>
</pre>
Hope it helps someone out.
