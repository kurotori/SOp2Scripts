#!/usr/bin/env bash
clear

usuarioBD="estudiante"
constraseniaBD="estudiante"

consulta="select nombreU,nombreP,apellidoP from juego.usuario;"

mysql -u "$usuarioBD" -p"$constraseniaBD" -e "$consulta" 