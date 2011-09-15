--- 
layout: post
title: Don&#039;t be a Rails idiot
wordpress_id: 90
tags: thoughts
date: 2010-05-28 14:55:05 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=90
---
Every programmer makes mistakes, right?

Every so often though, you make those dumb mistakes that really mess things up. I've made two of them myself, and I felt like a complete noob on both occasions.

Both mistakes simply involved overwriting ActiveRecord methods. The first time, I made an 'update' method in my model. It took me ages to figure that one out.

And just recently, I realized that I had made a named_scope called 'new' for another model.

So just remember, NEVER use method names such as 'create', 'update', 'new', or 'destroy' in ANY of your models... unless its on purpose, of course. Enough said.

Here is the facepalm that now adorns my model:
<pre>#                , -‘”          ``~ ,
#             , -”                  “- ,
#            ,/                       ”:,
#         ,?                           \,
#         /                            ,}
#         /                          ,:`^` }
#        /                         ,:”    /
#       ?   __                    :`    /
#       /__ (   “~-,_              ,:`     /
#      /(_  ”~,_    “~,_          ,:`    _/
#     { _$;_   ”=,_    “-,_   , -~-,}, ~”; /   }
#     ((   *~_    ”=- _   “;,, /`  /”    /    /
#      \`~,   “~ ,          `   }       /
#      (  `=-,,    `            (   ;_,,-”
#      / `~,   `-                \  /\
#      \`~ *-,                  |, /   \,__
#,,_     } &gt;- _\                  |       `=~-,
#   `=~-,_\_   `\,                 \
#          `=~-,, \,                \
#                `:,,              `\       __
#                   `=-,          ,%`&gt;--==``
#                    _\      _,-%    `
#
#  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#          Don't make an 'update' method in any model.
#  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
#  It overrides the Rails update method and breaks EVERYTHING.
#  -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=</pre>
