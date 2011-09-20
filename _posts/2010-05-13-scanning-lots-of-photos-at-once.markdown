---
layout: post
title: Scanning lots of photos at once with GIMP on Ubuntu Linux
wordpress_id: 74
tags: gimp guides projects photography
date: 2010-05-13 22:13:09 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=74
---
I needed a way to scan a lot of photos at once. I was going to write a GIMP plugin to extract out multiple images from a single scanned image of 3 or 4 photos, and then rotate them automatically. But as always, someone had already beat me to it :)

See <a href="http://www.gimptalk.com/forum/divide-or-crop-multiple-images-from-single-scan-t36438s0.html">this forum on GimpTalk</a> for the original script.

(The only problem I had is that the <a href="http://registry.gimp.org/node/2958">Deskew</a> plugin for GIMP is located on a website whose server seems to be permanently offline. I did manage to find an alternative location, so I've posted a self-hosted link to the plugin below)

<strong>Steps to scan in multiple images:</strong>
<ol>
	<li>Download <a href="http://ffaat.pointclark.net/incoming/scripts/DivideScannedImages.scm">DivideScannedImages.scm</a> to  <em>~/.gimp-2.6/scripts</em></li>
	<li>Download <a href="https://docs.google.com/uc?id=0B_kEFWyVsTF-NTc1Mzg3NWEtMzRhYS00ZGRiLWE0ZDMtYTE4NWYwMmRlZGI0&amp;export=download&amp;hl=en">deskew</a> to<em> /usr/lib/gimp/2.0/plug-ins</em></li>
	<li>Start GIMP</li>
	<li>Click Filters -&gt; Batch Tools -&gt; Batch Divide Scanned Images</li>
</ol>
The rest is easy to figure out. Just make sure your 'size threshold' is large enough. Also, it may help to cover the photos with a couple of sheets of A4 paper, to give an even white background. Then place a few photos (3 or 4) on the scanner, with adequate spaces between them, scan them, and let the plugin do the rest!

Thanks to <strong> <a href="http://www.gimptalk.com/forum/memberlist.php?mode=viewprofile&amp;u=10783">RobA</a> </strong> <img title="Offline" src="http://www.gimptalk.com/forum/styles/GimpTalkPro/imageset/en/icon_user_offline.gif" alt="Offline" />for the awesome script!

&nbsp;

Example:

<img src="http://www.majhost.com/gallery/ffaat/gimp/scan1.jpg" width="540px">

<h3>becomes</h3>

<img src="http://www.majhost.com/gallery/ffaat/gimp/scan1-a.jpg" width="540px">
<img src="http://www.majhost.com/gallery/ffaat/gimp/scan1-b.jpg" width="540px">
<img src="http://www.majhost.com/gallery/ffaat/gimp/scan1-c.jpg" width="540px">

