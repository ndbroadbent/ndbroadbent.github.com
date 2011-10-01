---
layout: post
title: Yet another blog post about working with Git projects
excerpt: This is how I work with Git
tags: git bash
date: 2011-10-01 01:14:01 +0800
---

I've been working with git for about 2 years, and I would like to share everything that I've
learnt and developed to make life easier.



My git toolbox has expanded quite a lot since I wrote my other tiny posts
about git [shortcuts](http://madebynathan.com/2010/05/20/git-shortcuts/index.html)
and [functions](http://madebynathan.com/2010/10/29/more-git-shortcuts-filepaths-in-bash-variables/index.html).
So even if you've already seen a lot of blog posts like this one, I hope you will find at least
one or two things useful.

Here's what I will cover:

* Git branch and status in prompt
* Aliases and shortcuts
* Enviroment variables as temporary file shortcuts with <code>git status</code>
* Fast switching between git repositories
* Managing design assets within projects


## Aliases and shortcuts - A definitive guide

Every alias has tab-completion.

Some of the longer aliases might look like overkill, but they really are useful.

When I've committed something, but need to make a small change

alias gcamh='git add -A; git commit --amend -C HEAD'

Keyboard shortcuts
Functions for resolving merge conflicts


## Enviroment variables as temporary file shortcuts with git status



## Fast switching between git repositories





## Managing design assets within projects

This is my solution to the problem where you kind of want your graphic development files
to be a part of your repository, but you feel weird about checking them in because they are binaries
that change often and would just bloat the repo over time.
So I made a 'Design' folder in all of my repos that was ignored by git. I also wanted it to be synchronized
across all of my development machines, so I used Dropbox.

The <code>design</code> function sets all of this up.


* I wanted to organize all of my <code>.psd</code>s and <code>.xcf</code>s

If you've ever wanted a better way to incorporate

The <code>design</code> function helps you to manage your

