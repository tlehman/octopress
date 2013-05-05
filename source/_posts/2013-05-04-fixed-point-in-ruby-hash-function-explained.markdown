---
layout: post
title: "Fixed Point in Ruby Hash Function: more"
date: 2013-05-04 20:25
comments: true
categories: [mathematics, programming, ruby, C]
---

*tl;dr* This turned out to be just an exploration through the MRI C
 source code, there are still some questions left unanswered. 

A few days ago I wrote about how Ruby's `Fixnum#hash` function has a
[fixed point](/blog/2013/04/30/fixed-point-in-ruby-hash-function/),
and from some experimentation, found out that the exact values of the
fixed points depended on the Ruby implementation. Also, hmaddocks in
the comments noted that my example didn't work on Ruby 1.8.7.

To find out what is going on when I run `42.hash`, I went to the Ruby
source code, MRI implementation, version 1.9.3. The C function that is
called is in `object.c`:

``` c
/*
 * Generates a Fixnum hash value for this object.  This function must have the
 * property that <code>a.eql?(b)</code> implies <code>a.hash == b.hash</code>.
 *
 * The hash value is used along with #eql? by the Hash class to determine if
 * two objects reference the same hash key.  Any hash value that exceeds the
 * capacity of a Fixnum will be truncated before being used.
 *
 * The hash value for an object may not be identical across invocations or
 * implementations of ruby.  If you need a stable identifier across ruby
 * invocations and implementations you will need to generate one with a custom
 * method.
 */
VALUE
rb_obj_hash(VALUE obj)
{
    VALUE oid = rb_obj_id(obj);
#if SIZEOF_LONG == SIZEOF_VOIDP
    st_index_t index = NUM2LONG(oid);
#elif SIZEOF_LONG_LONG == SIZEOF_VOIDP
    st_index_t index = NUM2LL(oid);
#else
# error not supported
#endif
    st_index_t h = rb_hash_end(rb_hash_start(index));
    return LONG2FIX(h);
}
```

Note in the comments that the hash value does not have to be the same
across implementations of ruby.

The MRI C source code makes heavy use of C macros, so in order to
understand what `rb_object_hash` is doing, we need to run it through
the preprocessor:

``` bash
cpp object.c
```

``` c
rb_obj_hash(VALUE obj)
{
    VALUE oid = rb_obj_id(obj);

    st_index_t index = ((((long)(oid))&0x01)?(((long)oid)>>(int)1):rb_num2long((VALUE)oid));

    st_index_t h = rb_hash_end(rb_hash_start(index));
    return ((VALUE)(((long)(h))<<1 | 0x01));
}
```

The first interesting line is 

``` c
st_index_t index =
((((long)(oid))&0x01)?(((long)oid)>>(int)1):rb_num2long((VALUE)oid));
```
the line on the right of the assignment statement is a ternary
operator, it is equivalent to the following expression: 

``` c
if (((long)(oid))&0x01) {
    (((long)oid)>>(int)1);
} else { 
    rb_num2long((VALUE)oid));
}
```

The condition `((long)(oid))&0x01` takes the rightmost bit of `oid`
(the object_id). In C, 0 is falsey, and anything else is truthy. So if
the least significant bit is 1, then the `index` value gets set to 
`(((long)oid)>>(int)1);`, which is just the `object_id`, under integer
division by 2. Otherwise, `index` is set to the `object_id` itself.

In the example I used the number 42, the `object_id` is 85, which is
odd, so it's least significant bit is 1. That means the index is 42.

Next, we examine the expression `h = rb_hash_end(rb_hash_start(42))`.

Then `rb_hash_start` and `rb_hash_end` are macros that expand out to 
`st_hash_start` and `st_hash_end` respectively.

Here is the source code for these two functions: 

``` c
st_index_t
st_hash_end(st_index_t h)
{
    h = murmur_step(h, 10);
    h = murmur_step(h, 17);
    return h;
}

#undef st_hash_start
st_index_t
st_hash_start(st_index_t h)
{
    return h;
}

```

So `st_hash_start` is the identity function, meaning that our
expression `h = rb_hash_end(rb_hash_start(42))` reduces to 
`h = rb_hash_end(42)`. Now, in order to reduce this further, we have
to find out what `murmur_step` does.


`murmer_step` is a macro defined as `#define murmur_step(h, k)
murmur((h), (k), 16)` and `murmur` is  a function defined as

``` c
static inline st_index_t
murmur(st_index_t h, st_index_t k, int r)
{
    const st_index_t m = MurmurMagic;
#if MURMUR == 1
    h += k;
    h *= m;
    h ^= h >> r;
#elif MURMUR == 2
    k *= m;
    k ^= k >> r;
    k *= m;

    h *= m;
    h ^= k;
#endif
    return h;
}
```

Running that through the preprocessor, we have 
 
``` c
static __inline st_index_t
murmur(st_index_t h, st_index_t k, int r)
{
    __const st_index_t m = (st_index_t)0x5bd1e995;

    k *= m;
    k ^= k >> r;
    k *= m;

    h *= m;
    h ^= k;

    return h;
}

```

I turned the `murmur` function in a pure function so that I could
reduce the original expression completely. To make sure that it
worked, I made sure the values agreed over some reasonably large
portion of the `h,k,r` space of integer triplets. The type
`st_index_t` is an `unsigned long`, so here is the function and it's
pure equivalent:

``` c 
unsigned long murmur(unsigned long h, unsigned long k, int r) {
	int m = 0x5bd1e995;
	
	k *= m;
	k ^= k >> r;
	k *= m;
	
	h *= m;
	h ^= k;
	
	return h;
}
```

can be expressed as:

``` c
unsigned long murmur_pure(unsigned long h, unsigned long k, int r) {
	int m = 0x5bd1e995;

	return ((h * m) ^ ((((k*m) ^ ((k*m) >> r))) * m));
}
```

And just to make sure, I ran this test to make sure that
`murmur(h,k,r) == murmur_pure(h,k,r)`

``` c 
#include <assert.h>

int main(int argc, char *argv[]) {
	for(unsigned long h = 0; h < 5; h++)	{
		for(unsigned long k = 0; k < 5; k++)	{
			for(int r = 0; r < 5; r++)	{
				assert(murmur(h,k,r) == murmur_pure(h,k,r));
			}
		}
	}
}
```

The above 125 test cases pass, so now we can finally expand the
expression `h = rb_hash_end(42)` into a more primitive form.

I will write it as a sequence of C expressions, with `==` as a
delimiter.

``` c
rb_hash_end(42) 
== st_hash_end(42)
== murmur(murmur(42, 10, 16), 17, 16)
== murmur(((42 * m) ^ ((((10*m) ^ ((10*m) >> 16))) * m)), 17, 16)
== murmur(1498110599, 17, 16)
== 1141833420685329578
```

Then finally, the return statement:

``` c
    return ((VALUE)(((long)(1141833420685329578))<<1 | 0x01));
```

The number 1141833420685329578 is the same value as a `long` or and
`unsigned long`, but `<<1` multiplies it by 2 to give
2283666841370659156 (since `VALUE` is just `unsigned int`).

Then `2283666841370659156 | 0x01` sets the least significant bit to 1, 
since 2283666841370659156 is even, it's least significant bit is 0, so
the number becomes 2283666841370659157, which is the same number
incremented.

However, this value not only varies from implmentation to
implmentation, it also varies from session to session. If I start up
irb several times, I get different answers:

``` bash
irb(main):001:0> 42.hash
=> 4282931690090059683
irb(main):001:0> 42.hash
=> 125925666573944215
irb(main):001:0> 42.hash
=> 4507128204239453813
```

This hash algorithm is taken from 
[Murmur Hash](https://sites.google.com/site/murmurhash/), the name is
explained here: 

> The name, if you're wondering, comes from the simplest sequence of
  operations which will thoroughly mix the bits of a value - "x *= m;
  x = rotate_left(x,r);" - multiply and rotate. Repeat that about 15
  times using 'good' values of m and r, and x will end up
  pseudo-randomized. Unfortunately multiply+rotate has a few major
  weaknesses when used in a hash function, so I used
  multiply+shift+xor. I liked the name Murmur better than Musxmusx, so
  I kept it. 


Hash algorithms are supposed to be indistinguishable from randomness,
so if there is any variation in the computation or the input, the
output should appear as a completely different number.

The only source of variation I can see is in the `murmur` function
definition, the `m` value looks like this:

``` c
const st_index_t m = MurmurMagic;
```

Magic numbers, always a headache for understanding code, fortunately,
`ack` or `git grep` will help in figuring out what it is.

```
~/ruby (origin/ruby_1_9_3)> git grep -n MurmurMagic

doc/ChangeLog-1.9.3:10755:      * st.c (MurmurMagic): get rid of literal overflow.
st.c:1287:#define MurmurMagic_1 (st_index_t)0xc6a4a793
st.c:1288:#define MurmurMagic_2 (st_index_t)0x5bd1e995
st.c:1290:#define MurmurMagic MurmurMagic_1
st.c:1293:#define MurmurMagic ((MurmurMagic_1 << 32) | MurmurMagic_2)
st.c:1295:#define MurmurMagic MurmurMagic_2
st.c:1302:    const st_index_t m = MurmurMagic;
st.c:1326:    h *= MurmurMagic;
st.c:1460:      h *= MurmurMagic;
```

So `MurmurMagic` is a symbol defined at the preprocessing stage,
meaning it doesn't vary from session to session.

At this point I have to say I don't understand the source code well
enough to actually explain the fixed point.

