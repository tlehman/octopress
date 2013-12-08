#!/bin/sh

git grep 'categories: \[' | perl -n -e '/\[([^\]]+)\]/ && print "$1\n"' | tr ', ' '\n' | awk NF | tr '[A-Z]' '[a-z]' | sort | uniq -c 
