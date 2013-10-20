#!/bin/sh

git grep 'categories: \[' | perl -n -e '/\[([^\]]+)\]/ && print "$1\n"' | tr ', ' '\n' | awk NF | sort | uniq -c 
