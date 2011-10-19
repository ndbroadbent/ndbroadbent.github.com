---
layout: post
title: Git Shortcuts Like You've Never Seen Before
tags: git bash zsh scripts projects
date: 2011-10-19 01:14:01 +0800
---

## Introducing 'SCM Breeze'

**SCM Breeze** is a set of shell scripts (for `bash` and `zsh`) that enhance your interaction with tools
such as git. It integrates with your shell to give you numbered file shortcuts,
a repository index with tab completion, and a community driven collection of useful SCM functions.

Disclaimer: **git** is currently the only supported SCM, because it's the only one I use.
I've kept the project's name open because it won't be difficult to port it for other SCMs.


## File Shortcuts

SCM Breeze makes it really easy to work with changed files, and groups of changed files.
Whenever you view your SCM status, each modified path is stored in a numbered environment variable.
You can configure the variable prefix, which is 'e' by default.


### `git_status_shortcuts`:

<div class="centered">
<img src="/images/posts/2011/10/status_with_shortcuts-resized-post.png" alt="Git Status With Shortcuts" />
</div>
<br/><br/>

These numbers (or ranges of numbers) can be used with any SCM or system command.

For example, if `ga` was your alias for `git add`, instead of typing something like:

{% highlight bash %}
$ ga assets/git_breeze/config* assets/git_breeze/install.sh
{% endhighlight %}

You can type this instead:

{% highlight bash %}
$ ga $e2 $e3 $e11
{% endhighlight %}

But SCM Breeze is also smart enough to expand integers and ranges, so all you need to type is:

{% highlight bash %}
$ ga 2 3 11
{% endhighlight %}

And if you want to add all unstaged changes (files 1 to 10):

{% highlight bash %}
$ ga 1..10
{% endhighlight %}

(Note that `ga` will also remove deleted files, unlike the standard `git add` command.
This behaviour can be turned off if you don't like it.)


You can also diff, reset or checkout a file by typing:

{% highlight bash %}
$ gd 3
$ grs 4
$ gco 5
{% endhighlight %}


You can use these shortcuts with system commands by passing your command through `exec_git_expand_args`
(default alias is 'ge'):


{% highlight bash %}
$ echo $e4
# => assets/git_breeze/git_breeze.sh
$ ge echo 4
# => assets/git_breeze/git_breeze.sh
$ ge echo 1..3
# expands to echo $e1 $e2 $e3
# => _shared.sh assets/git_breeze/config.example.sh assets/git_breeze/config.sh
{% endhighlight %}


## Keyboard bindings

My most common git commands are `git status`, `git add` and `git commit`, so I wanted these
to be as streamlined as possible. One way of speeding up commonly used commands is by binding them to
keyboard shortcuts.

Here are the default keyboard bindings:

* `CTRL`+`SPACE` => `git_status_shortcuts` - show git status with file shortcuts
* `CTRL`+`x` `c` => `git_add_and_commit` - add given files (if any), then commit staged changes
* `CTRL`+`x` `SPACE` => `git_commit_all` - commit everything


The commit shortcuts use the `git_commit_prompt` function, which gives a simple prompt like this:

<div class="centered">
<img src="/images/posts/2011/10/git_commit_all-resized-post.png" alt="Git Commit All" />
</div>
<br/>
(When using bash, this commit prompt gives you access to your bash history via the arrow keys.)
<br/>

And if you really want to speed up your workflow, you can do this:

{% highlight bash %}
$ 2 3 <CTRL+x c>
{% endhighlight %}

Which sends the `HOME` key, followed by `git_add_and_commit`:

<div class="centered">
<img src="/images/posts/2011/10/git_add_and_commit_params-resized-post.png" alt="Git Add And Commit" />
</div>
<br/>


## Repository Index

The second feature is a repository index for all of your projects.
This gives you super-fast switching between your project directories with tab completion,
and it can even tab-complete project subdirectories.
It's similar to [autojump](https://github.com/joelthelion/autojump), but it doesn't need to 'learn' anything,
and it can do SCM-specific stuff like:

* Running a command for all of your repos (useful if you ever need to update a lot of remote URLs)
* Auto-updating a repo when you switch to it and it hasn't been updated for at least 5 hours.

The default alias for `git_index` is 's', which could stand for 'source' or 'switch' :)

You first need to configure your repository directory, and then build the index:

{% highlight bash %}
$ s --rebuild
# => == Scanning /home/ndbroadbent/src for git repos & submodules...
# => ===== Indexed 64 repos in /home/ndbroadbent/src/.git_index
{% endhighlight %}

Then you'll be able to switch between your projects, or show the list of indexed repos:

<div class="centered">
<img src="/images/posts/2011/10/source_list-resized-post.png" alt="Git Status With Shortcuts" />
</div>
<br/>



## Anything else?

I mentioned there was a 'community driven collection of useful SCM functions'.
Well... The 'community' hasn't quite started yet.

If you have any awesome SCM scripts lurking in your `.bashrc` or `.zshrc`,
please feel free to send me a pull request.
It would be cool to make this project into an [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) for SCMs.


# Installation

{% highlight bash %}
git clone git://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
cd ~/.scm_breeze
./install.sh
source ~/.bashrc   # or source ~/.zshrc
{% endhighlight %}

# Configuration

SCM Breeze is configured via automatically installed `~/.*.scmbrc` files.
To change git configuration, edit `~/.git.scmbrc`.

I know we grow attached to the aliases we use every day, so I've made them completely customizable.
Just change any aliases in `~/.git.scmbrc`, and tab completions will also be updated.
You can also change or remove any keyboard shortcuts.

Each feature is modular, so you are free to ignore the parts you don't want to use.
Just comment out the relevant line in `~/.scm_breeze/scm_breeze.sh`.

# Updating

Run `update_scm_breeze`. This will update SCM Breeze from Github,
and will create or patch your `~/.*.scmbrc` files if any new settings are added.


## Enjoy!

I look forward to your pull requests!

