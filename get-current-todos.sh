#!/usr/bin/env bash

git grep -l TODO | xargs -n1 git blame -f -n -w | \
grep TODO | sed "s/.\{9\}//" | \
sed "s/(.*)[[:space:]]*//"