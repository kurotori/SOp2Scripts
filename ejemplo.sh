#!/usr/bin/env bash
lista=( $(ls ~) )
echo "${#lista[@]}"

for archivo in "${lista[@]:5:2}"; do
    echo "$archivo/"
    ls -l "$HOME/$archivo/"
done
