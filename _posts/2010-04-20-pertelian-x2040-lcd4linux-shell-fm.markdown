---
layout: post
title: Pertelian X2040, lcd4linux, shell-fm
wordpress_id: 25
tags: compaq-evo-t20 lcd4linux linux shell-fm
date: 2010-04-20 13:19:42 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=25
---
I received my Pertelian X2040, and had a bit of trouble getting it work on my 64bit Ubuntu machine. The characters were getting all mixed up.  I gave up on my 64bit machine and decided to focus my efforts on the T20 running tinycore.

To get <a href="http://lcd4linux.bulix.org/">lcd4linux</a> running on tinycore with any lcd screen, you need the dbus, usbutils and usb-serial packages installed.

At first, lcd4linux was asking me for mysql, and then sqlite, and those are pretty hefty packages for a little thin client. So before you compile lcd4linux, do this if you just want the fifo and exec plugins (substitute for your requirements):
<pre>./configure --with-plugins=fifo,exec --with-drivers=Pertelian</pre>
(also keep in mind the suggested compiling flags from the <a href="http://wiki.tinycorelinux.com/tiki-index.php?page=Creating+Extensions">"Creating an Extension"</a> page on the tinycore wiki)

Will post some pics or video once I get it all working nicely. I'm also really keen to build a nice varnished pine box to house my shell.fm player (like the following guy from germany did..), with the LCD screen embedded, but thats another project altogether :)

[caption id="attachment_27" align="alignnone" width="300" caption="T20 Thin Client pine box made by Dominik Huber"]<a href="/images/posts/2010/04/thinclient.jpg"><img class="size-medium wp-image-27" title="thinclient" src="/images/posts/2010/04/thinclient.jpg?w=300" alt="T20 Thin Client pine box made by Dominik Huber" width="300" height="200" /></a>[/caption]

P.S. I bought one of these <a href="http://usb.brando.com/prod_detail.php?prod_id=00666">super-tiny keyboards</a> for my T20 projects. I think they're just really cool!

[caption id="attachment_28" align="alignnone" width="220" caption="Super Tiny USB Keyboard"]<a href="/images/posts/2010/04/supertiny-keyboard.jpg"><img class="size-full wp-image-28" title="Super Tiny USB Keyboard" src="/images/posts/2010/04/supertiny-keyboard.jpg" alt="Super Tiny USB Keyboard" width="220" height="165" /></a>[/caption]

