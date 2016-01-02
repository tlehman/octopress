---
layout: post
title: "Approximate derivatives of real-valued functions in Haskell"
date: 2016-01-02
comments: true
categories: [mathematics, calculus, functional-programming, haskell]
---

This is an exploration of single-variable differential calculus,
namely, the derivative.

As any first-year calculus student learns, if we have a function $f:\mathbb{R}
\to \mathbb{R}$, we can compute the rate of change of $f$, also known as the
derivative, using the following formula:

## $\frac{d}{dx}f(x) = \lim\limits_{h\to 0}\frac{f(x+h) - f(x)}{h}$

Since this generalizes to higher dimensions, and we usually go to great lengths
to avoid dependence on coordinates (like $x$), we will use a capital $D$ to
denote the differentiation operator:

## $Df(x) = \lim\limits_{h\to 0}\frac{f(x+h) - f(x)}{h}$

We will now implement $D$ in Haskell, we will call it `derive`


    derive h f x = (f (x+h) - f x)/h


    f x = x**3


    derive 0.0001 f 1


    3.0003000099987354



    f 1


    1.0


So checking our results above, since $df/dx = 3x^2$, we would expect $(df/dx)(1)
= 3$, and $f(1) = 1$, which is approximately what we got.

Can we make a differentiation function that lets us use the function directly?
Yes! We can use partial application of the [curried
function](https://en.wikipedia.org/wiki/Currying) `derive` to give us the
derivative, $df/dx$, or equivalently, using Newton's notation, $f'$


    f' = derive 0.0001 f


    :t f'


<span class='get-type'>f' :: forall a. Floating a => a -> a</span>



    :t f


<span class='get-type'>f :: forall a. Floating a => a -> a</span>


As we can see from the above two lines, $f$ and $f'$ have the same type, which
we would expect.

Next, let's compute the derivative of sin, and compare it to cosine, since
$\frac{d}{dx}sin(x) = cos(x)$, we would expect them to be similar.


    dsin = derive 1e-12 sin
    dsin 1
    cos 1 - dsin 1


    0.5403455460850637



    -4.3240216923923214e-5



    dsin 1


    0.5403455460850637



    cos 1


    0.5403023058681398


And indeed, they are similar. This is not true differentiation, but it is a good
approximation, and it shows off some of Haskell's functional features.


    
