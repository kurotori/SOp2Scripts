#!/usr/bin/env bash
clear

usuarioBD="estudiante"
constraseniaBD="estudiante"

consulta="select concat_ws(':',nombreU,ID,nombreP,apellidoP) from juego.usuario;"

usuarios=$(mysql -u "$usuarioBD" -p"$constraseniaBD" -e "$consulta")

#echo "$usuarios"|cut -f 1

arrUsuarios=( $(echo "$usuarios"|cut -d ":" -f 1,2) )

for item in "${arrUsuarios[@]}"; do
   echo "${item}"
done

read ok

posI=0
posF=0
tope=${#arrUsuarios[@]}
opcion=""

while [ "$opcion" != "s" ] && [ "$opcion" != "S" ]; do
    clear
    echo "Usuarios"
    echo "--------"

    for((i=1;i<15;i++)); do
        echo "$i    ${arrUsuarios[$i]}"
    done

    read opcion
done








