---
layout: post
title: "word embeddings and semantics"
date: 2016-09-04 15:48
comments: true
categories: [linguistics, machine-learning, linear-algebra, semantics]
---

Can a machine understand what a word means? Right now machines routinely correct spelling and grammar, but are pretty useless when it comes to semantics.

Search engines are an exception, they have a rudimentary understanding of what words mean. One of the ways this can work is explored in Tomas Mikolov's 2013 paper 
on **word embeddings**. Word embeddings are mappings from sets of words to vectors, such that the distances between the vectors represent the semantic similarity 
of the words. These embeddings are learned by programs by scanning through large volumes of text, such as wikipedia articles and royalty-free books, and uses a 
sliding context to adjust the parameters of the embedding.

The goal is to learn a function $$f : Word \to \mathbb{R}^d$$ so that equations like this hold: $$f(\text{waiter}) - f(\text{man}) + f(\text{woman})  f(\text{waitress}) $$



# References

- Efficient estimation of word representations in vector space by Tomas Mikolov, Kai Chen, Greg Corrado, Jeffrey Dean (2013) _arXiv preprint arXiv:1301.3781_
