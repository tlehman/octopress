---
layout: post
title: "How many possible flags are there?"
date: 2013-05-11 12:00
comments: true
categories: [mathematics, combinatorics, cli]
---

I have been thinking about Mars a lot more lately, and about possible colonization. The [Mars One](http://mars-one.com/) project is a non-governmental not-for-profit organization that is looking to send groups of four people, independent of nationality, to Mars in 2022. 

One thing that came to mind was independence, just as the early North American settlers declared independence from Great Britain, I think that Martian settlers would eventually declare independence from the countries of Earth, provided they had a sustainable, self-reliant colony. 

As a side effect, the Martian settlers would probably choose a new flag, and then the math geek in me wondered how far this could go, **how many different flags are possible?** As humanity grows, evolves and expands, assuming that each nation that emerged had a flag, how many unique flags could possibly be created?

If we allow for any arbitrary size and aspect ratio, the number is infinite. However, most flags have the same aspect ratio, and their implementation as cloth is usually in fixed sizes. 

To find the aspect ratios of the current flags of Earth, I found [this](https://en.wikipedia.org/wiki/User:SiBr4/List_of_national_flags_by_aspect_ratio) on wikipedia. I went to the edit view and then copied the wiki source. On Mac OS X, the `pbpaste` command writes the contents of the clipboard to standard out on the command line. On GNU/Linux under Xorg, you can use `xclip -o` to achieve the same thing.

So I played around with the data and came up with this one-liner:

``` bash
> pbpaste | pre nts | awk -F\| '{print $3}' | sed 's/[\}]//g' | pcregrep '^\d' | sort -n | uniq -c
   1 0.820
   2 1
   1 1.154
   1 1.167
   1 1.25
   1 1.321
   5 1.333
   3 1.375
   1 1.389
   2 1.4
   2 1.429
   1 1.467
 114 1.5
   1 1.571
   5 1.6
   1 1.618
   1 1.636
  22 1.667
   2 1.75
   1 1.772
   1 1.864
   4 1.9
  83 2
   1 2.545
```

Most countries use 1.5, 2 and 1.667. As fractions, these are 3/2, 2/1, 5/3, respectively. Also, one country (Togo in Africa) uses 1.618 = &phi;, the Golden Ratio!

Since the overwhelming majority of flags use the 3/2 ratio, let us assume for this problem that this is the only ratio that will be used. We can relax this assumption later and make it a parameter of a more general formula.

Also, note that flags are physically made of thread, another simplifying assumption we will make is that all flags are made of the same width thread, and that the thread is evenly spaced.

One final assumption we will have to make is how big the flag will be.

