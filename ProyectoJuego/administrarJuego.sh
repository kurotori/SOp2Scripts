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
opcion=""
inicio=1
tope=10
while [ "$opcion" != "s" ]; do
    clear
    for indice in "${!info[@]}"
    do
        if [ "$indice" -eq 0 ]; then
            echo "${info[$indice]}"|sed "s/:/\t/g"
            echo "----------------------------"
        else
            if [ "$indice" -ge "$inicio" ] && [ "$indice" -le "$tope" ] ; then
                echo "$indice - ${info[$indice]}"|sed "s/:/\t/g"
            fi
        fi
    done
    echo ""
    echo "Presione S para salir, D para avanzar, A para retroceder"
    read opcion

    case "$opcion" in
        [Ss])
            opcion=s
        ;;
        [dD])
            tope=$(( $tope+10 ))
            inicio=$(( $inicio+10 ))
        ;;
        [aA])
            tope=$(( $tope-10 ))
            inicio=$(( $inicio-10 ))
            #AGREGAR CHEQUEO DE TOPE
        ;;
    esac
    

done

