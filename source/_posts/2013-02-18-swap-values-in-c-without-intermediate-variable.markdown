---
layout: post
title: "Swap values in C without intermediate variable"
date: 2013-02-18 14:36
comments: true
categories: [mathematics, algebra, macros, C]
---

Using the following properties of the XOR function:

 - Associativity
<div markdown="0">
  \[(a \oplus b) \oplus c =  a \oplus (b \oplus c) \]
</div>
 - Commutativity
<div markdown="0">
  \[a \oplus b =  b \oplus a \]
</div>
- Identity
<div markdown="0">
  \[a \oplus 0 = a \]
</div>
- Self-Inverse
<div markdown="0">
  \[a \oplus a = 0 \]
</div>

As a bit of trivia, note that all n-bit integers form an [Abelian Group](http://en.wikipedia.org/wiki/Abelian_group) under XOR. The proof of which can be found by using the obvious isomorphism of n-bit integers with `{0,1}`<sup>n</sup> under addition modulo 2. Note that addition modulo 2 is equivalent to bitwise XOR.

So, using the C programming language, we can use the convenient `^=` operator as a way to swap the values of a and b without using an intermediate variable.

```c
  a ^= b;      // (a ^ b)
  b ^= a;      // b ^ (a ^ b)   which is the original a
  a ^= b;      // (a ^ b) ^ b   which is the original b
```

Here is a full working program that implements this operation using a C macro:

```c
#include <stdio.h>

#define show(a,b)	printf("a = %d, b = %d\n", a, b);

#define swap(a,b) \
  a^=b;  \
  b^=a;  \
  a^=b;

int main(int argc, char *argv[]) {
  int a = 3, b = 5;
  show(a,b);

  swap(a,b);

  show(a,b);
  return 0;
}
```


