#!/bin/bash
search=$1
path=$(git status --porcelain | sed s/^...//)

rg --color=never --no-heading --with-filename --line-number --column --smart-case -- $search $path

