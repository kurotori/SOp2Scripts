#!/usr/bin/env bash
clear

usuarioBD="estudiante"
constraseniaBD="estudiante"

consulta="select concat_ws(':',nombreU,nombreP,apellidoP) as 'nombreU:nombreP:apellidoP' from juego.usuario;"
# "select concat_ws(':',nombreU,nombreP,apellidoP) 
# as 'nombreU:nombreP:apellidoP' from juego.usuario;"

datos=$(mysql -u "$usuarioBD" -p -e "$consulta")
echo "$datos"

arrUsuarios=( $(echo "$datos") )
echo "${#arrUsuarios[@]}"

for elemento in "${arrUsuarios[@]}"
do
    echo "$elemento"|cut -d":" -f1,2
done
