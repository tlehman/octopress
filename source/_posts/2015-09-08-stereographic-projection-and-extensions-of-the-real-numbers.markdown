---
layout: post
title: "Stereographic projection and extensions of the real numbers"
date: 2015-09-08 07:29
comments: true
categories: [mathematics, geometry, metric-spaces]
---

The [real numbers](https://en.wikipedia.org/wiki/Real_number) are the most useful model of a straight line. Distance in this space is very easy to measure, suppose x and y were real numbers, the distance between them is just |x-y|.

<svg id="real-line" style="width:100%;height:40;">
<desc>the Real Number Line</desc>
<line x1="0" y1="10" x2="100%" y2="10" style="stroke:rgb(0,0,0);stroke-width:1" />
<circle id="point" cx="100" cy="10" r="4" style="fill:rgb(255,0,0);stroke:rgb(255,0,0);" />
</svg>
<script type="text/javascript">
var leftOffset = $("#content").offset().left;
var svg = document.getElementById("real-line");
var point = document.getElementById("point");
svg.onmousemove = function(e) {
  point.attributes.cx.value = e.clientX - $(this).offset().left;
}
</script>


The algebraic operations you can perform on real numbers are almost everywhere defined, I'll explain. Suppose x and y are any two real numbers, then:

 - x + y
 - x - y
 - x * y


Are all defined, but it is not necessarily true that x/y is defined. If y = 0, then x/y is not defined, since dividing by 0 cannot be understood consistently in terms of real numbers. Before we go too far, let's explore why this is. Suppose that 1/0 was defined, and that there was some number r = 1/0. Then we can multiply both sides by 0 and get r*0 = 1, but r*0 = 0, so we have to conclude that 1 = 0. If 1 = 0, then 2 = 0, and 3 = 0, and &pi; = 0, etc. The whole real number line collapses into a single point, 0. And what's worse is that 0/0 isn't defined either!

From this we can conclude that no real number can be divided by 0 to produce another real number.

Moving on, since addition, subtraction, multiplication and division are all continuous functions, we can learn a lot by studying the limiting behavior of these functions, so let's look at division, what is the limit of 1/x as x goes to 0? There is some notation for this:

{% latex %}

\[ \lim_{x \to 0} \frac{1}{x} \]

{% endlatex %}

Looking at it graphically, we see that 1/x approaches infinity as x approaches 0, so we might reasonably guess that _if_ we could consistently define division by 0, then the result might be infinite.

A good solution comes out of [projective geometry](https://en.wikipedia.org/wiki/Projective_Geometry), where all lines, even parallel lines intersect.

__Insert projective geometry perspective art here__


The horizon is imagined as a single point "at infinity", and when this leap of imagination is made, you get the nice property that any two lines intersect at exactly one point. If we adjoin this extra point ∞ to the real numbers, then may be able to state that 1/0 = ∞.



<svg id="stereographic-projection" style="width:100%;height:400;">
<desc>the Real Number Line</desc>
<circle id="unit-circle" cx="50%" cy="50%" r="25%" style="fill:rgb(255,255,255);stroke:rgb(255,0,0);" />
<circle id="point-2" cx="50%" cy="50%" r="4" style="fill:rgb(255,0,0);stroke:rgb(255,0,0);" />
<line x1="0" y1="50%" x2="100%" y2="50%" style="stroke:rgb(0,0,0);stroke-width:1" />
<circle id="point-2_" cx="50%" cy="25%" r="4" style="fill:rgb(255,0,0);stroke:rgb(255,0,0);" />
</svg>
<script type="text/javascript">
var svg2 = document.getElementById("stereographic-projection");
var point2 = document.getElementById("point-2");
var point2_ = document.getElementById("point-2_");
svg2.onmousemove = function(e) {
  var x = e.clientX - $(this).offset().left;
  point2.attributes.cx.value = x;
  point2_.attributes.cx.value = x;
  // solve x^2 + y^2 = y + 1/x for y
  // to get y = 1/2(1 +/- sqrt(4 + x - 4x^3)/sqrt(x))
  point2_.attributes.cy.value = (x==0) ? 1 : 0.5*(1 + Math.sqrt(Math.abs(4 + x - 4*(x*x*x)))/Math.sqrt(Math.abs(x)));
}
</script>

