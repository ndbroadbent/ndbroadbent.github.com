--- 
layout: post
title: How to preserve indentation in wordpress [sourcecode] tags
wordpress_id: 150
tags: thoughts
date: 2010-10-19 20:58:38 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=150
---
Dont use the visual editor! Copy the code into your 'HTML' view and it will preserve indentation. Copy it into 'Visual' view and your code will be all left-aligned...

Examples:

<strong>Code pasted in 'Visual' View</strong>

[sourcecode language="html"]
<indent>
<indent>
<indent>
</indent>
</indent>
</indent>
[/sourcecode]

<strong>Code pasted in 'HTML' View</strong>

[sourcecode language="html"]
<indent>
    <indent>
        <indent>
        </indent>
    </indent>
</indent>
[/sourcecode]

YMMV, I guess, but this is what works for me.
