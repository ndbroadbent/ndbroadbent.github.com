---
layout: post
title: Skype notifications using libnotify on Linux
tags: scripts guides skype linux
date: 2012-03-24 18:55:18 +0800
---

Run the following script to configure Skype to use `libnotify`, instead of it's own notification system.

{% highlight bash %}
bash < <(curl -s https://raw.github.com/gist/2181122/skype-libnotify.sh)
{% endhighlight %}

This downloads and executes the script from this gist: [https://gist.github.com/2181122](https://gist.github.com/2181122)
