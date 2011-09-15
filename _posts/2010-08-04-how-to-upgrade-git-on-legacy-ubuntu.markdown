--- 
layout: post
title: How to upgrade git on legacy Ubuntu
wordpress_id: 113
tags: thoughts
date: 2010-08-04 23:28:02 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=113
---
Follow these steps to get git 1.7 + on ubuntu 9.10 or less. (10.04 comes with the latest version)
<ul>
	<li>sudo apt-get install libcurl4-dev  # (for new http[s] support)</li>
	<li>cd /tmp</li>
	<li>wget http://kernel.org/pub/software/scm/git/git-1.7.2.1.tar.gz</li>
	<li>tar -xf git-1.7.2.1.tar.gz</li>
	<li>cd git-1.7.2.1/</li>
	<li>./configure</li>
	<li>make</li>
	<li>sudo make install</li>
	<li>ln -nfs /usr/bin/git /usr/local/bin/git</li>
</ul>
