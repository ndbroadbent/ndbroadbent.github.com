---
layout: post
title: Travis CI Status in Shell Prompt
excerpt: Travis CI Status in Shell Prompt
tags: ruby github travis-ci bash prompt
date: 2012-01-31 01:21:13 +0800
---

[Travis CI](http://travis-ci.org/) is a distributed [continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) service for the open source community, and it can be used with any of your public projects on [GitHub](https://github.com/). You've probably seen some 'build status' badges like this:

<img src="https://secure.travis-ci.org/travis-ci/travis-ci.png" alt="Travis CI build status">

Wouldn't it be cool if you could see that build status in your shell prompt whenever you are working on a project?

Here's what my shell prompt looks like now:

<img src="/images/posts/2012/01/travis_ci_prompt.png" alt="Travis CI status in prompt" />

This shows the build status for the current branch.

----------------

You will need to cache the build status, since looking it up takes a few seconds.

You should use my fork of [mislav's](https://github.com/mislav) `travis-ci` script, which can check the build status of a project. Make sure `~/bin` is in your `PATH`, and if you are using RVM, make sure you are using your default ruby.

Run the following to install it:

{% highlight bash %}
mkdir -p ~/bin/
curl -sL https://raw.github.com/gist/1708408/travis.rb > ~/bin/travis-ci \
  && chmod +x ~/bin/travis-ci

gem install hub | tail -2
ruby -e 'require "json"' 2>/dev/null || gem install json
{% endhighlight %}


Next, we need to update the cached status.
The following code is included as part of my [SCM Breeze project](http://madebynathan.com/2011/10/18/git-shortcuts-like-youve-never-seen-before/), but feel free to save the following script to `/usr/bin/update_travis_ci_status`.

{% highlight bash %}
#!/bin/bash
if [ -e ".travis.yml" ]; then
  if type ruby > /dev/null 2>&1 && type travis-ci > /dev/null 2>&1; then
    # Use repo from origin remote
    local branches=$(git branch -a | sed "s/ *remotes\/origin\///;tm;d;:m;/^HEAD/d;")
    local stat_file=".travis_status~"
    echo -n > "$stat_file"
    for branch in $branches; do
      local travis_output=$(travis-ci "$branch" 2>&1)
      case "$travis_output" in
      *built\ OK*)    echo "$branch passed"  >> "$stat_file";;
      *failed*)       echo "$branch failed"  >> "$stat_file";;
      *in\ progress*) echo "$branch running" >> "$stat_file";;
      esac
    done

    # Ignore status from git
    if ! ([ -e .git/info/exclude ] && grep -q "$stat_file" .git/info/exclude); then
      echo "$stat_file" >> .git/info/exclude
    fi
  fi
fi
{% endhighlight %}

We will also need a way to run this update task every few minutes, across all of our local git repos.

The [SCM Breeze project](http://madebynathan.com/2011/10/18/git-shortcuts-like-youve-never-seen-before/) also maintains an index of your git repositories, which gives you the ability to run batch commands via the `git_index` function.
So the build status update can be easily set up as a cron task:

{% highlight text %}
*/5 * * * * /bin/bash -c '. $HOME/.bashrc && git_index --rebuild && git_index --batch-cmd update_travis_ci_status'
{% endhighlight %}

Alternatively, you could save the following script to `/usr/bin/update_all_travis_ci_statuses`.

{% highlight bash %}
#!/bin/bash
# (Replace `$HOME/code` with the location of your projects)
for f in find "$HOME/code" -maxdepth 4 -name .travis.yml; do
  (builtin cd "$(dirname $f)" && update_travis_ci_status)
done
{% endhighlight %}

... and use the following cron task:

{% highlight text %}
*/5 * * * * /bin/bash -c '. $HOME/.bashrc && /usr/bin/update_all_travis_ci_statuses'
{% endhighlight %}

(you need to source your `.bashrc` if your default ruby comes from RVM)


Finally, you need a way to display the cached status in your prompt.

Here are the functions I use to return a colored pass / fail / running symbol:

{% highlight bash %}
# Returns the Travis CI status for a github project
parse_travis_status() {
  local branch="$1"
  if [ -z "$branch" ]; then branch="master"; fi

  local stat_file=$(find_in_cwd_or_parent ".travis_status~")
  if [ -e "$stat_file" ]; then
    case "$(grep -m 1 "^$branch " "$stat_file")" in
    *passed)  echo "\[\e[01;32m\]✔ ";; # green
    *failed)  echo "\[\e[01;31m\]✘ ";; # red
    *running) echo "\[\e[01;33m\]⁇ ";; # yellow
    esac
  fi
}

# Test whether file exists in current or parent directories
find_in_cwd_or_parent() {
  local slashes=${PWD//[^\/]/}; local directory=$PWD;
  for (( n=${#slashes}; n>0; --n )); do
    test -e $directory/$1 && echo "$directory/$1" && return 0
    directory=$directory/..
  done
  return 1
}
{% endhighlight %}

(it also works if you are in a project's sub-directory.)

Finally, add `$(parse_travis_status "$current_branch")` somewhere in your `$PS1`. Set the `$current_branch` variable to the current git branch, but if you leave it blank, it will default to the `master` branch.

You may like to have a look at the [prompt section of my dotfiles](https://github.com/ndbroadbent/dotfiles/blob/master/bashrc/prompt.sh), to see how I do it.


Enjoy! Please let me know if you have any questions, or need some help.
