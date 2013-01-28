---
layout: post
title: "Reinventing the wheel: Or how I learned to stop coding and read the manpages"
date: 2013-01-28 07:55
comments: true
categories: [cli, unix, mapages, lesson]
---

About a month ago I [wrote about a command line utility](/blog/2012/12/30/building-command-line-utilities-in-ruby-that-play-well-with-the-rest-of-the-unix-utilities/) I made that calculates word and character frequencies. It was packaged as a ruby gem and it interacted well with the Unix pipeline interface.

Then, about 2 or 3 weeks later, I come across this post on Twitter:

<blockquote class="twitter-tweet"><p>Show how many times each line in a sorted file is repeated: uniq -c</p>&mdash; Unix tool tip (@UnixToolTip) <a href="https://twitter.com/UnixToolTip/status/292295351518498816">January 18, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

And I realized that I could construct a one-liner that does what my gem did. Probably faster too. I know about uniq and sort, and I've used awk a little bit, but am not really familiar with most of it's capabilities.

The two features I implemented in ruby were (1) counting word frequencies and (2) counting character frequencies. I defaulted everything to lower case and 
