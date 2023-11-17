#!/usr/bin/env bash

## BLOQUE 1
clear

archUsuarios="./usuarios.csv"


if [ ! -f "$archUsuarios" ]; then
    touch "$archUsuarios"
    echo 'idU,nombreU,nombreP,apellidoP,email' > "$archUsuarios"
    
fi


## FIN BLOQUE 1

## BLOQUE 2

linea(){
    long=$(tput cols)
    linea=""
    for((i=0;i<$long;i++)); do
        linea="$linea-"
    done
    echo "$linea"
}


espacio(){
    for((i=0;i<$1;i++)); do
        espacios="$espacios "
    done
    echo "$espacios"
}

## FIN BLOQUE 2

## BLOQUE 3

mostrarTitulo()
{
    titulo="$1" 
    long=$(tput cols)
    chars=${#titulo}
    long=$(((long-chars)/2))
    espacio=$(espacio "$long")

    echo "$espacio$titulo"
}

encabezado()
{
    clear
    linea
    mostrarTitulo "Sistema de Administración de Usuarios"
    linea
}

noValido()
{
    echo "ERROR: opción no válida"
    echo "Presione Enter para continuar"
    read ok
}

## FIN BLOQUE 3

## BLOQUE 4
opcionI=""

while [ "$opcionI" != "s" ]; do
    encabezado
    mostrarTitulo "Menú Principal"
    linea
    echo "1 - Listado de Usuarios"
    echo "2 - Agregar un Usuario Nuevo"
    echo "S - Salir"
    linea
    read opcionI

## FIN BLOQUE 4

    case "${opcionI}" in
        1)
        ## BLOQUE 5
            opcion=""
            info=( $(cat "$archUsuarios") )

            inicio=1
            tope=10
            limite=0
            
            while [ "$opcion" != "s" ]; do
                limite=0
                encabezado
                mostrarTitulo "Listado de Usuarios del Sistema:"
                linea
                for indice in "${!info[@]}"
                do
                    if [ "$indice" -eq 0 ]; then
                        registro=$(echo "${info[$indice]}"|cut -d"," -f2-4|sed "s/,/\t/g")
                        printf '%-4s %-15s %-15s %-15s %-15s\n' '#' $registro
                        linea
                    else
                        if [ "$indice" -ge "$inicio" ] && [ "$indice" -le "$tope" ] ; then
                            registro=$(echo "${info[$indice]}"|cut -d"," -f2-4|sed "s/,/\t/g")
                            printf '%-4s %-15s %-15s %-15s\n' $indice $registro
                        fi
                    fi
                    limite=$(( limite+1 ))
                done
                linea
                printf 'Registros %4s hasta %4s, de %4s\n' "$inicio" "$tope" "$limite" 
                linea
                echo "Presione S para salir, D para avanzar, A para retroceder"
                echo "Ingrese un número de registro para ver detalles"
                read opcion

                ## FIN BLOQUE 5

                ##BLOQUE 6
                case "$opcion" in
                    [Ss])
                        opcion=s
                        clear
                    ;;
                    [dD])
                        if [ "$tope" -le "$limite" ]; then  
                            tope=$(( tope+10 ))
                            inicio=$(( inicio+10 ))  
                        fi
                    ;;
                    [aA])
                        if [ "$inicio" -gt "1" ]; then
                            tope=$(( tope-10 ))
                            inicio=$(( inicio-10 ))
                        fi
                    ;;

                    ## FIN BLOQUE 6

                    ## BLOQUE 7
                    *)
                        if [[ $opcion =~ ^[0-9]+$ ]]; then
                            encabezado
                            echo "Datos del Usuario"
                            linea
                            nombreU=$(echo "${info[$opcion]}"|cut -d":" -f1)
                            infoUsuario=( $(echo "${info[$opcion]}"|sed "s/,/\t/g") )
                            printf '%-10s %-10s\n' "Usuario:" $(echo "${infoUsuario[1]}")
                            linea
                            printf '%-10s %-10s\n' "ID:" $(echo "${infoUsuario[0]}")
                            printf '%-10s %-10s\n' "Nombre:" $(echo "${infoUsuario[2]}")
                            printf '%-10s %-10s\n' "Apellido:" $(echo "${infoUsuario[3]}")
                            linea
                            echo "Presione Enter para continuar"
                            linea
                        else
                            echo "ERROR: opción no válida"
                            echo "Presione Enter para continuar"
                        fi
                        read ok
                    ;;
                    ## FIN BLOQUE 7
                esac
            done
        ;;
        
        2)
            encabezado
            mostrarTitulo "Agregar un Usuario Nuevo"
            linea
            read ok
        ;;


        [Ss])

        ## BLOQUE 8
            encabezado
            mostrarTitulo "Salir del Sistema:"
            linea
            echo "Va a salir del sistema"
            echo "¿Desea Continuar?"
            linea
            echo "S - SI"
            echo "N - NO"
            read opcionI
            case "${opcionI}" in
                [sS])
                    clear
                    opcionI="s"
            esac
            
            ## FIN DEL BLOQUE 8
        ;;
        *)
            noValido
        ;;
    esac
    

    
done



