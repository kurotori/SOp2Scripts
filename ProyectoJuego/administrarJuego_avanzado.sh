#!/usr/bin/env bash
clear



consulta="select concat_ws(':',nombreU,nombreP,apellidoP)
 as 'Usuario:Nombre:Apellido' from juego.usuario;"

datosUsuario="select concat_ws(':',ID,nombreU,nombreP,apellidoP)
as 'ID:Usuario:Nombre:Apellido' from juego.usuario where nombreU="

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

ejecutarConsulta()
{
    datos=$(mysql -u "$1" -p"$2" -e "$3")
    echo "$datos"
}


encabezado
mostrarTitulo "Iniciar Sesión:"
linea
echo " Nombre de Usuario:"
read usuarioBD
echo " Contraseña:"
read -s contraseniaBD


#ejecutarConsulta "$usuarioBD" "$contraseniaBD" "SET sql_notes=0;"
opcionI=""

while [ "$opcionI" != "s" ]; do
    encabezado
    mostrarTitulo "Menú Principal"
    linea
    echo "1 - Listado de Usuarios"
    echo "S - Salir"
    linea
    read opcionI

    case "${opcionI}" in
        1)
            opcion=""
            info=( $(ejecutarConsulta "$usuarioBD" "$contraseniaBD" "$consulta") )

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
                        registro=$(echo "${info[$indice]}"|sed "s/:/\t/g")
                        printf '%-4s %-10s %-10s %-10s\n' '#' $registro
                        linea
                    else
                        if [ "$indice" -ge "$inicio" ] && [ "$indice" -le "$tope" ] ; then
                            registro=$(echo "$indice:${info[$indice]}"|sed "s/:/\t/g")
                            printf '%-4s %-10s %-10s %-10s\n' $registro
                        fi
                    fi
                    limite=$(( $limite+1 ))
                done
                linea
                printf 'Registros %4s hasta %4s, de %4s\n' "$inicio" "$tope" "$limite" 
                linea
                echo "Presione S para salir, D para avanzar, A para retroceder"
                echo "Ingrese un número de registro para ver detalles"
                read opcion

                case "$opcion" in
                    [Ss])
                        opcion=s
                        clear
                    ;;
                    [dD])
                        if [ "$tope" -le "$limite" ]; then  
                            tope=$(( $tope+10 ))
                            inicio=$(( $inicio+10 ))  
                        fi
                    ;;
                    [aA])
                        if [ "$inicio" -gt "1" ]; then
                            tope=$(( $tope-10 ))
                            inicio=$(( $inicio-10 ))
                        fi
                        #AGREGAR CHEQUEO DE TOPE
                    ;;
                    *)
                        if [[ $opcion =~ ^[0-9]+$ ]]; then
                            encabezado
                            echo "Datos del Usuario"
                            linea
                            nombreU=$(echo "${info[$opcion]}"|cut -d":" -f1)
                            infoUsuario=( $(ejecutarConsulta "$usuarioBD" "$contraseniaBD" "${datosUsuario}'${nombreU}'") )
                            printf '%-10s %-10s\n' "Usuario:" $(echo "${infoUsuario[1]}"|cut -d":" -f2 )
                            linea
                            printf '%-10s %-10s\n' "ID:" $(echo "${infoUsuario[1]}"|cut -d":" -f1 )
                            printf '%-10s %-10s\n' "Nombre:" $(echo "${infoUsuario[1]}"|cut -d":" -f3 )
                            printf '%-10s %-10s\n' "Apellido:" $(echo "${infoUsuario[1]}"|cut -d":" -f4 )
                            linea
                            echo "Presione Enter para continuar"
                            linea
                        else
                            echo "no valido"
                        fi
                        
                        read ok
                    ;;
                esac
                

            done
        ;;
        [Ss])
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
            
            
        ;;
        *)
            echo "default (none of above)"
        ;;
    esac
    

    
done



