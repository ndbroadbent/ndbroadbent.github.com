--- 
layout: post
title: Fat Free CRM - rake spec failing
wordpress_id: 119
tags: thoughts
date: 2010-08-07 21:07:59 +08:00
wordpress_url: http://nathanf77.wordpress.com/?p=119
---
Today I checked out 'fat free CRM' from github and tried to write a plugin for it.

I couldn't get the tests to run at all, it was giving me this error:

`const_missing': uninitialized constant Test::Unit::TestResult::TestResultFailureSupport (NameError)

Here is the best, fastest, and most foolproof fix:

$ sudo gem uninstall test-unit

Everything works perfectly. (And you use RSpec anyway, right?)
