---
layout: post
title: "Euclid's Algorithm in MIX assembly language vs Scheme"
date: 2013-09-29 20:18
comments: true
categories: [algorithm, scheme, mixal, mathematics, number-theory]
---

I wrote my first* assembly language program today, it was written in
[Donald Knuth's MIX Assembly Language](https://en.wikipedia.org/wiki/MIX), 

it is an implementation of Euclid's Algorithm to compute the greatest common divisor of two
positive integers. Writing in an assembly language is so much more
work than writing in a high-level language like Ruby, Scheme or even
C. However, it gives a much better idea of how the computer actually
works, and gives the programmer much more appreciation for all the
nice abstractions we use in our day jobs and side projects.

Here's the Scheme version (problem 2.01 in SICP):
``` scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

Here's the MIX Assembly Language version:

``` ASM
PRNT  EQU	19	* Typewriter terminal, stdout in MDK (GNU Mix Development Kit)
DVSR  EQU	100	* store n for DIV operation
SWAP  EQU	101	* swap to handle reg-to-reg transfers (inefficient)
START ENTA	0
      ENTX	165
      ENT1	90
E1    ST1	DVSR	* store n in DVSR
      DIV	DVSR	* rA <- m//n; rX <- m%n
E2    CMPX	=0=
      JE	QUIT	* halt if r=0, then CONTENTS(DVSOR)=gcd(m,n)
E3    STX	SWAP
      LD1	SWAP	* n <- r
      LDX	DVSR	* m <- n
      ENTA	0
      JMP	E1	* go to E1
QUIT  LDA	DVSR    * rA <- gcd(m,n)
      CHAR	0       * convert rA to character code
      STX	DVSR	* store least significant digits in DVSR cell
      OUT	DVSR(PRNT)
      HLT
      END	START
```

I came up with the above code to learn how to write MIXAL, and I have
a hunch that it is not as efficient as it could be. I do a lot of
swapping from registers to memory and back. Although to be fair, I
couldn't find a way to transfer data from register A any of the other
registers, if someone knows of a way to do this, please correct me in
the comments, I would like to know.

The algorithm is the first example mentioned in [The Art of Computer Programming](https://en.wikipedia.org/wiki/The_Art_of_Computer_Programming). 
I found that just reading the algorithm
alone doesn't give much insight as to why it works, but reviewing a
little bit of discrete math first, one can see where the steps come
from.

First, start by assuming that m and n are positive integers, with m > 
n, and then the greatest common divisor d is the unique integer such that:

<div markdown="0">
  \[ 0 \le d < n \text { where }  \]

  \[ \exists a,b \in \mathbb{Z} \text{ such that } am + bn = d  \]
</div>

Then, let r = m mod n (the remainder of m divided by n), we will prove
that 

<div markdown="0">
  \[ gcd(m,n) = gcd(n,r) \]
</div>

All we need to show is that there are integers s and t such that 

<div markdown="0">
  \[ sn + tr = d  \]
</div>

Note that since 

* Technically I've written some x86 assembly in a class in 2009, but
  it doesn't count, it wasn't complete, and I barely understood it.