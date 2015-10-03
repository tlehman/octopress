---
layout: post
title: "Fixing spaces in filenames"
date: 2012-11-19 19:18
comments: true
categories: [command-line, bash, unix]
---

Sorry this has taken so long, I've been working on the [Cryptography Coursera class](https://www.coursera.org/course/crypto), 
to get rid of all spaces in all files below the current directory, the following bash script will do:

``` bash
for filename in $(find .); do
  newfilename=$(echo $filename | sed 's/ /_/g'); 
  mv $filename $newfilename
done
```
