---
layout: post
title: "Bayesian Drunk Driving"
date: 2015-04-19 09:43
comments: true
categories: [probability, bayesian, mathematics, statistics]
---

Driving drunk is illegal for a good reason, it's way riskier than driving sober. This article isn't about driving drunk 
though, it's more about the sloppy thought processes that can too easily confuse something as obvious as that first 
sentence. Here's an example of a bogus argument that appears to support the idea that drunk driving is actually safer:

<blockquote class="twitter-tweet" lang="en">
<p>From a recent talk: 1/3 of accidents involve drunk drivers, so 2/3 don’t =&gt; sober drivers 2× as bad.</p>
&mdash; Colin Beveridge (@icecolbeveridge)
<a href="https://twitter.com/icecolbeveridge/status/587317304335147008">April 12, 2015</a>
</blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

So the argument is as follows: In 2012, 10,322 people were killed in alcohol-impaired driving crashes,
accounting for nearly one-third (31%) of all traffic-related deaths in the United States [1].
That means that approximately one third of traffic-related deaths involve drunk driving, meaning that 
two thirds of traffic-related deaths don't involve drunk driving. Therefore, sober drivers are twice as
likely to die in a traffic accident.

If you think something is wrong with that argument, you are right, but it's not just because the conclusion 
intuitively seems wrong, it's because it involves a mistake in conditional probability. To see the mistake, 
it helps to introduce a litle notation, we will define:

 - P(D) to be the probability that a person is drunk
 - P(A) to be the probability that a person will die in a traffic-related accident 
 - P(D | A) _(pronounced probability of D given A)_ is the probability that a person is drunk, given that 
   there was a death in a traffic-related accident they were in

So using the 2012 CDC data, we can assign 31%, P(D | A) = 0.31. This is that the probability of a drunk 
driver being involved __given that there was a deadly driving accident__.

The first thing to point out is that the statement that 'sober drivers are twice as likely as drunk drivers 
to die in an accident' is really a statement about P(A | D), that is, the probability of a deadly driving 
accident __given that that person is drunk__. We don't know this yet, however, we can figure it out using 
Bayes' theorem.

## Baye's Theorem

[1] Impaired Driving: Get the Facts *Centers for Disease Control*
http://www.cdc.gov/Motorvehiclesafety/impaired_driving/impaired-drv_factsheet.html
