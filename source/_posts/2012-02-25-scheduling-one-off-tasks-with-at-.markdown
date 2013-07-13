---
layout: post
comments: true
title: Scheduling one-off tasks with 'at'
tags: linux bash administration server
date: 2012-02-25 17:00:27 +0800
---

You might be familiar with the [cron](http://en.wikipedia.org/wiki/Cron) job scheduler,
which is great for repeating tasks.
But when you want to schedule a command to only run once in the future,
the [at](http://linux.die.net/man/1/at) command is what you are looking for.

In my case, I was updating a plugin for our 
[Thoughtworks Mingle](http://www.thoughtworks-studios.com/mingle-agile-project-management) instance,
but the update wasn't hugely important. Many of our staff rely on Mingle for their work,
and restarting it takes it offline for a few minutes.

So I used the `at` command to schedule the restart to happen at midnight, after everyone had gone home:

{% highlight bash %}
$ echo "/etc/init.d/mingle restart" | at -m 00:00
job 6 at 2012-02-26 00:00
{% endhighlight %}


Use `atq` or `at -l` to see the list of pending jobs:

{% highlight bash %}
$ atq
6	2012-02-26 00:00 a root
{% endhighlight %}

Use `at -c <job id>` to view the script that will be run:

{% highlight bash %}
$ at -c 6

#!/bin/sh
# atrun uid=0 gid=0
# mail     root 1
umask 22
HOSTNAME=...
<lots of environment variables set here>

/etc/init.d/mingle restart
{% endhighlight %}

To delete a scheduled task, run `at -d <job id>`:

{% highlight bash %}
$ at -d 6
$ atq
(no output)
{% endhighlight %}
