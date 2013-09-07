---
layout: post
title: "Monoids in Scheme"
date: 2013-09-07 11:15
comments: true
categories: [abstract-algebra, scheme]
---

There is a structure in abstract algebra called a monoid. There are several ways to define a monoid, but before we start, we should answer the obvious question: *why should you care?*

The reason being aware of monoids is important is that they are everywhere, and knowing the properties of general monoids will allow you to make inferences about specific instances. I'll give a good example to start out with: lists.

<img src="/images/blogimg/list.png">

For the sake of simplicity, I am going to use scheme values and the `cons` operation. In [Section 2.2 of SICP](https://mitpress.mit.edu/sicp/full-text/sicp/book/node32.html), the closure property of was defined. _This is distinct from the notion of closure of an expression over the surrounding environment_.

An operation `#` is said to be 'closed' in the sense that given two values `A` and `B` of the same type, the expression `A # B` is a value of the same type.

Given a list `A` and a list `B`, we can concatenate the two lists and get a new list, `(append A B)`

``` scheme
(append (append '(a) '(b)) '(c))
; => (a b c)
```

Another way to construct it is:
``` scheme
(append '(a) (append '(b) '(c)))
; => (a b c)
```

The fact that `(a b c)` can be constructed in either way means that `append` is an associative operation, and readers of this blog should recognize that [`fold-left` and `fold-right` would give the same result in this case](/blog/2013/09/02/quasiquoting-in-scheme-to-study-a-computation/).

## Set-theoretic Definition of a monoid
This leads to the first two properties that define a general monoid, a monoid is:


<div markdown="0">
\[ \text{a set } M \text{ with an associative operation } *:M \times M \to M \] 
</div>

Note, the closure property is implicit in the defintion of the operation as a function, since it is impossible for the output of the function to be anything outside of M.

Where there is an identity element e in M, it is defined by:

<div markdown="0">
\[ \forall m \in M : e*m = m*e = m \]
</div>
