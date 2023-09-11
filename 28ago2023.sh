#!/usr/bin/env bash
clear
opcion=""

while [ "$opcion" != "s" ] && [ "$opcion" != "S" ]
do
    clear
    usuarios=$(cat usuarios.txt|cut -d":" -f2,3)
    echo "Usuarios:"
    echo "Nombre      Estado"
    echo "-----------------------------------"
    echo "$usuarios"|sed "s/:/\t/"

    echo "OPCIONES:"
    echo "1 - Ver detalles de un usuario"
    echo "S - Salir"
    read opcion

    case "$opcion" in
        "1")
            echo "Ingrese el nombre del usuario:"
            read nomUsuario
            datosUsuario=$(echo "$usuarios"|grep "$nomUsuario")
            echo "$datosUsuario"|sed "s/:/\t/g"
            read ok
        ;;
    esac
    
done

