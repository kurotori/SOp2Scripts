#!/usr/bin/env bash

clear
cant_palabras=$(grep -c ".*" "diccionario_base.txt")

palabras=( $(cat "diccionario_base.txt") )

posicion=$(shuf -i 0-"$cant_palabras" -n 1)
echo "${palabras[$posicion]}"
#echo "${cant_palabras}"
