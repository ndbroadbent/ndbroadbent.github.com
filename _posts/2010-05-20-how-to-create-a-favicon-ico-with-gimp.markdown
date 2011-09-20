---
layout: post
title: How to create a favicon.ico with GIMP
wordpress_id: 85
tags: gimp guides web-design
date: 2010-05-20 13:19:13 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=85
---
<strong>UPDATE</strong>: Theres an easier way to do this here: <a href="http://www.htmlcenter.com/blog/creating-a-favicon-for-your-website/">http://www.htmlcenter.com/blog/creating-a-favicon-for-your-website/</a>.

<a href="http://linuxproblem.org/art_19.html">http://linuxproblem.org/art_19.html</a>

By<strong> <a href="http://linuxproblem.org/auth_1.html">Mathias Kettner</a> </strong>:

You need an image file that GIMP can open (PNG, GIF, etc.). And you need the command line tool <tt>ppmtowinicon</tt> from the <tt>netpbm</tt>-tools (on SuSE you have to have installed the package <tt>netpbm</tt>). Now perform the following actions:
	<li>Open your image with GIMP.</li>
	<li>If your image is not a square then resize the canvas with GIMP.</li>
	<li>Scale the image to 16x16 pixel (Image, Scale image).</li>
	<li>Choose <em>File, save as..</em> and save as <tt>favicon.pnm</tt> or <tt>favicon.ppm</tt> with <em>raw</em> encoding.</li>
	<li>Close GIMP</li>
	<li>Convert <tt>favicon.pnm</tt> resp. <tt>favicon.ppm</tt> using the command line utility <tt>ppmtowinicon</tt>:
<pre>&gt; <strong>ppmtowinicon -output favicon.ico favicon.pnm</strong>
</pre>
resp.
<pre>&gt; <strong>ppmtowinicon -output favicon.ico favicon.ppm</strong>
</pre>
</li>
That's all. Now copy your <tt>favicon.ico</tt> to the document root of Apache, for example to <tt>/srv/www/htdocs/favicon.ico</tt>, if you are using SuSE Linux &gt;= 8.1.

