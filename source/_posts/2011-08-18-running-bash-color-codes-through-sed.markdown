---
layout: post
comments: true
title: Running bash color codes through sed
wordpress_id: 569
tags: bash scripts
date: 2011-08-18 04:48:59 +08:00
wordpress_url: http://madebynathan.com/?p=569
---
<p>I have a script that runs a search and replace on a git status. I recently found out how to do 'git config color.status always', so that git status gives color codes to my functions. However, this broke the substitution, and it took me a while to figure it out.</p>

<p>At the end of every line, there was an invisible 'reset' color code, and this meant that 'sed "s/string$/$replace"' was no longer finding 'string$'.</p>

<p>Here is an example of how to use sed when your string contains color codes:</p>

{% highlight bash %}
# Need to strip the color character from the end of the line, otherwise
# EOL '$' doesn't work. This gave me a headache for long time.
# The echo ~> regex is time-consuming, so perform a simple search first.
if [[ $line == *$search* ]]; then
    line=$(echo $line | sed -r "s:$search(\x1B\[m)?$:$replace:g")
fi
{% endhighlight %}

<p>You might also find this page useful: <a href="http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed">http://www.commandlinefu.com/commands/view/3584/remove-color-codes-special-characters-with-sed</a></p>

