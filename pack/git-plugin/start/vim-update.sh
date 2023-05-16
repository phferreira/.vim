#!/usr/bin/env bash

[[ $# -gt 1 ]] && echo 'Just have one args' && exit 1

[[ $# -eq 1 ]] && diretory=$1 || diretory=/home/paulo/.vim/pack/git-plugin/start

echo $diretory

for DIR in $diretory/*
do 
  if [ -d "$DIR" ]; then
    cd $DIR
    git fetch
    branch=$(git branch --show-current)
    git fetch
    git pull origin $branch --recurse-submodules
  else
      echo "Warning: '$DIR' NOT found.";
  fi
done
