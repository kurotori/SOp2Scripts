#!/usr/bin/env bash
clear

echo "Nombre de Usuario:"
read usuarioBD
echo "Contraseña:"
read -s contraseniaBD

consulta="select concat_ws(':',nombreU,nombreP,apellidoP)
 as 'nombreU:nombreP:apellidoP' from juego.usuario;"

ejecutarConsulta()
{
    datos=$(mysql -u "$1" -p"$2" -e "$3")
    echo "$datos"
}

#ejecutarConsulta "$usuarioBD" "$contraseniaBD" "SET sql_notes=0;"

info=( $(ejecutarConsulta "$usuarioBD" "$contraseniaBD" "$consulta") )

for indice in "${!info[@]}"
do
    echo "${info[$indice]}"|sed "s/:/\t/g"
    if [ "$indice" -eq 0 ]; then
        echo "----------------------------"
    fi
done
