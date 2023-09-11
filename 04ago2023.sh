#!/usr/bin/env bash
clear

longitud="${#@}"
echo "$longitud"

echo "el último argumento es ${!longitud}"

for argumento in "$@"; do
    echo "$argumento"
done