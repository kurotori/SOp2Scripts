#!/usr/bin/env bash
clear


consultaBD()
{
    
}





usuarioBD="estudiante"


consulta="select concat_ws(':',nombreU,ID,nombreP,apellidoP) as 'Usuario:ID:Nombre:Apellido' from juego.usuario;"
usuarios=$(mysql -u "$usuarioBD" -p -e "$consulta")

clear
#echo "$usuarios"|cut -f 1

arrUsuarios=( $(echo "$usuarios") )
echo "$arrUsuarios"

read ok

posI=0
posF=0
tope=${#arrUsuarios[@]}
opcion=""

while [ "$opcion" != "s" ] && [ "$opcion" != "S" ]; do
    clear
    echo "Usuarios"
    echo "--------"

    for((i=0;i<15;i++)); do
        dato="${arrUsuarios[$i]}"
        datos=$(echo "$dato"| sed "s/:/\t/g")
        echo -e "$i\t$datos"
    done

    read opcion
done








