---
layout: post
title: "Switching away from MathJax"
date: 2014-02-23 20:41
comments: true
categories: [blogging, mathematics]
---

I am switching away from [MathJax for my math blogging](/blog/2012/07/18/mathjax-for-octopress/) for a few reasons, first one being that RSS readers won't see rendered formulas, and second one being that rendering complex formulae such as tables of aligned equations can be very slow.

Instead, I've decided to use [this Jekyll plugin](http://www.flx.cat/jekyll/2013/11/10/liquid-latex-jekyll-plugin.html) to pre-render the formulae and insert images into the generated markup.

