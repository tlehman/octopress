---
layout: post
title: "Word frequencies after removing common words"
date: 2015-02-10 21:38
comments: true
categories: [programming, cli, regex]
---

In taking the [Coursera class on Mining Massive Datasets](https://class.coursera.org/mmds-002), the problem of computing word frequency for very large documents came up. I wanted some convenient tools for breaking documents into streams of words, and also a tool to remove common words like 'the', so I wrote up `words` and `decommonize`. The `decommonize` script is just a big `grep -v '(foo|bar|baz)'`, where the words foo, bar and baz come from the words in a file. I made a script `generate_decommonize` that reads in a list of common words, and builds the regex for `grep -v`.

## Example usage of `words` and `decommonize`

The full source code is available [here on github](https://github.com/tlehman/words).

After running `make install`, you should have `words` and `decommonize` in your PATH, you can use them to find key words that are characteristic of a document, I chose

 - the U.S. Declaration of Independence:

```
$ words < declaration_of_independence.txt | decommonize  | sort | uniq -c | sort -n | tail
   4 time
   5 among
   5 most
   5 powers
   6 government
   6 such
   7 right
   8 states
   9 laws
  10 people
```

 - Sherlock Holmes

```
$ words < doyle_sherlock_holmes.txt | decommonize  | sort | uniq -c | sort -n | tail
 174 think
 175 more
 177 over
 212 may
 212 should
 269 little
 274 mr
 288 man
 463 holmes
 466 upon
```

 - Working with Unix Processes (by @jstorimer)

```
$ words < working_with_unix_processes.txt | decommonize  | sort | uniq -c | sort -n | tail
  73 signal
  82 system
  88 ruby
  90 exit
 100 code
 100 parent
 143 its
 146 child
 184 processes
 444 process
```

So `words` breaks up the document into lower-case alphabetic words, then `decommonize` greps out the common words, and `sort` and `uniq -c` are used to count instances of each decommonized word, and then the results are sorted.
