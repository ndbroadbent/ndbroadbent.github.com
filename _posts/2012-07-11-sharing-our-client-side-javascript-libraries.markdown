---
layout: post
title: A better way to share client-side Javascript libraries
wordpress_id: 189
tags: thoughts
date: 2012-07-11 01:38:37 +12:00
---
Why are we still downloading so many copies of jQuery? Should client-side Javascript libraries should be treated as packages that are downloaded once, and shared across all the websites that use them.

Take a look at [this article, titled "6,953 reasons why I still let Google host jQuery for me"](http://encosia.com/6953-reasons-why-i-still-let-google-host-jquery-for-me/), which shows that
many top websites are referencing jQuery on Google's public CDN. This means that if your website
also references Google's CDN, it's very likely that your users will already have a cached copy of jQuery
that they downloaded while visiting one of those sites.

However:

* Why isn't every site doing this?

Today, I had the idea for a browser extension (or core feature) that would solve this shared library problem.
Instead of 'caching' a library, why not think about 'installing' them. 
And I thought it would also be great to go one step further, and build something like [Bundler](http://gembundler.com/) for client-side javascript libraries.

Imagine if you could declare that your site depends on 'backbone ~> 0.9.2', and 'underscore > 1.3.1' is automatically loaded as a dependency.

Website developers could add tags like:

    <jslib name="jquery" version="~> 1.7.2" />

The browser would then inject a script tag for a locally stored version of jQuery that matches '1.7.*'. If no matching version of jQuery was found, it would be downloaded from a free CDN (such as http://cdnjs.com/).

The browser could then re-use the same library for every website that needs it. Newer versions of libraries would be used whenever they are released, providing security patches or bug fixes (only on 'patch' increments, if the libraries follow semantic versioning - see http://semver.org/).

To get any traction, maybe this needs to be implemented as a core feature of Google Chrome. But I don't know if that's too hard to imagine, since Google already tried to solve this problem by offering their free CDN ( https://developers.google.com/speed/libraries/ ).

If every browser was  could potentially be using the same cached copy of every library...

I just think it's wrong that us Rails developers are bundling our own copies of every library into our compiled assets... Even if they're gzipped and compressed, it still seems like we could be doing better.


Here's a comment from a member of the AJAX Libraries team at Google, explaining why they host the service, and that they're not being evil... http://www.johnon.com/647/google-ajax-api.html#comment-128665

