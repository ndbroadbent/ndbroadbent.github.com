---
layout: post
title: "An Experiment With A Dumb Website"
date: 2015-04-13 00:26
comments: true
tags: websites jokes
---

Yesterday, I turned a [dumb joke into a webpage](http://whattypeofanimalareyou.com/) (a BuzzFeed parody) and [posted it on Reddit (/r/humor)](http://www.reddit.com/r/humor/comments/329jlq/oc_i_made_a_short_quiz_that_tells_you_what_type/). Here's how I built the site, and what kind of traffic it's seen so far.


### Building and Hosting a Static Site

I love [Octopress](http://octopress.org/), but decided to try out [Middleman](https://middlemanapp.com/) for this site. Even though this is a very simple site, it's really helpful to have templates and an asset pipeline. Everything worked out of the box, and their [documentation](https://middlemanapp.com/basics/install/) is awesome! I used a lot of open source JS libraries, such as [fullPage.js](https://github.com/alvarotrigo/fullPage.js) and [spin.js](http://fgnass.github.com/spin.js/).

I used the [middleman-s3_sync](https://github.com/fredjean/middleman-s3_sync) gem to push the site to Amazon S3, and [configured hosting on the S3 bucket](http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html). I also set up [Cloudflare](https://www.cloudflare.com/), and added a Page Rule to cache the homepage HTML. (Cloudflare automatically caches everything else.)
This means that only the first request hits my S3 bucket, and since [Cloudflare](https://www.cloudflare.com/) doesn't charge for bandwidth, I won't need to pay anything even if the site gets millions of page views. Thanks, [Cloudflare](https://www.cloudflare.com/)!


### Stats

* [600 upvotes on /r/humor](http://www.reddit.com/r/humor/comments/329jlq/oc_i_made_a_short_quiz_that_tells_you_what_type/)
* [0 upvotes on /r/funny](http://www.reddit.com/r/funny/comments/32cmox/i_made_a_short_quiz_that_tells_you_what_type_of/) (tough crowd)
* 20,000 page views over the last 24 hours
* It looks like around 40% of Redditors use AdBlock Plus or uBlock
* Main Facebook audience seems to be women between the ages of 25 and 31.

I also realized that Facebook users are generally:

* Very tired of these quizzes, so unlikely to click at face value
* Not big fans of anti-jokes


Anyway, this has been a fun experiment, and it will probably fizzle out as soon as it drops off Reddit. Even so, I learnt a little more about static site development, as well as Google and Facebook's analytics tools. I also made enough money from ads to buy a good dinner (in Thailand).
