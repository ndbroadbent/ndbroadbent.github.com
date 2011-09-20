---
layout: post
title: Bash Color Index
wordpress_id: 552
tags: bash scripts
date: 2011-08-16 08:47:38 +08:00
wordpress_url: http://madebynathan.com/?p=552
---
Sometimes it's nice to add color output to your bash scripts. Here's a nicely formatted 'color index' function for your .bashrc for when you need to look up the color codes.

{% highlight bash %}
# Bash Colors index
# ------------------------------------------------
color_index() {
  # Show an index of all available bash colors
  echo -e "\n              Usage: \\\033[*;**(;**)m"
  echo -e   "            Default: \\\033[0m"
  local blank_line="\033[0m\n     \033[0;30;40m$(printf "%41s")\033[0m"
  echo -e "$blank_line" # Top border
  for STYLE in 2 0 1 4 9; do
    echo -en "     \033[0;30;40m "
    # Display black fg on white bg
    echo -en "\033[${STYLE};30;47m${STYLE};30\033[0;30;40m "
    for FG in $(seq 31 37); do
        CTRL="\033[${STYLE};${FG};40m"
        echo -en "${CTRL}"
        echo -en "${STYLE};${FG}\033[0;30;40m "
    done
    echo -e "$blank_line" # Separators
  done
  echo -en "     \033[0;30;40m "
  # Background colors
  echo -en "\033[0;37;40m*;40\033[0;30;40m \033[0m" # Display white fg on black bg
  for BG in $(seq 41 47); do
      CTRL="\033[0;30;${BG}m"
      echo -en "${CTRL}"
      echo -en "*;${BG}\033[0;30;40m "
  done
  echo -e "$blank_line" "\n" # Bottom border
}
{% endhighlight %}

Calling 'color_index' produces something like this:

<img src="/images/posts/2011/08/color_index3.png" alt="color_index()" width="540px" />

