---
layout: post
title: "Why the argument that &pi; = 4 is wrong"
date: 2014-03-13 22:30
comments: true
categories: [mathematics, pi-day, infinity]
---

A few years ago this false argument was trending on reddit, it claimed to prove that &pi;=4

{% img /images/blogimg/pi_eq_four_arg.png %}

The first step is right, the diameter is 1, so the circumferance is &pi;. 

The second step is right, the bounding square has a perimeter of 4.

The third step is right, as is the fourth step. In fact, any finite number of iterations of that rule will yield a polygon of perimeter 4. Also, the perimeter converges to the circle.

However, the final step is wrong, because it states that &pi; = 4. Since this is not true, this proof must have a flaw somewhere. But where?

When I first saw this, I thought the reason the proof was wrong was that the perimeter _didn't_ converge to the circle, that it instead became some kind of fractal. This turned out to be wrong, as the people on /r/math were quick to point out.

So if the perimeter does converge to the circle, what's wrong?

The answer took me two classes in introductory real analysis to finally understand, the answer is subtle, but it has to do with the fifth step, _repeat to infinity_. Mathematics can certainly handle repeating something to infinity, but it usually defies your intuition. As it did mine.

First, suppose we a sequence of continuous functions:

{% latex %}

$ f_0, f_1, f_2, \dots $

{% endlatex %}

Where for each non-negative integer n, 

{% latex %} 
$ f_n : [0,1] \to \mathbb{R}^2 $ 
{% endlatex %}

That is, it maps a point in the closed unit interval into the plane, since it is continuous, each f<sub>n</sub> defines a curve.

These f<sub>n</sub> functions represent the successive perimeters, f<sub>0</sub> is the square, f<sub>1</sub> is the square with the corners inverted, etc.

Now, what the picture showed holds in the case that n is finite, that is, given any non-negative integer n, f<sub>n</sub> has a perimeter of 4.

Also, what the picture suggested is that the limit of f<sub>n</sub> as n goes to infinity is the circle. Formally:

{% latex %} 
$ \lim_{n \to \infty} f_n = C $
{% endlatex %}

Where C is the function that defines a circle of diameter 1. 

Formally, this means that given any real number t in [0,1], and any &epsilon; > 0, we can find an N high enough so for that all n > N, 

{% latex %} 
$ |f_n(t) - C(t)| < \epsilon $
{% endlatex %}

This just means that any given point on the curve gets arbitrarily close to a point on the circle. This is a kind of convergence called _pointwise convergence_.

One downside to pointwise convergence is that it is possible for a sequence of continuous functions to converge to a non-continuous function. Also, **the limit of the perimiter is not necessarily the perimeter of the limit**.

Therefore, even though the sequence of perimeter 4 polygons converged pointwise to a circle, the limit of the permieter, &pi;, does not necessarily equal the perimeter of the limit, 4.

~~Another kind of convergence, called [uniform convergence](https://en.wikipedia.org/wiki/Uniform_convergence#Definition) does have the properties that the trollface wants, but this sequence does not uniformly converge, the proof of which I will leave to the reader as an exercise.~~

My explanation by non-uniform convergence is wrong, the property that the f<sub>n</sub> sequence must have is that the first-order derivatives f'<sub>n</sub> must converge, which they don't since each one has corners.

To see why, the definition of curve length of f<sub>n</sub> over an interval [a,b] is:


{% latex %} 
$ \int_a^b \sqrt{1 + (f'_n(t))^2 } dt $
{% endlatex %}

At each corner point, the derivative f'<sub>n</sub> is not even defined, therefore the derivatives do not converge.

Thank you commenters for pointing this out, and reminding me how important it is to get the details right. I was wrong about that argument being wrong in multiple ways. 

