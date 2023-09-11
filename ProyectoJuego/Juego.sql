drop database if exists juego;
create database juego;
use juego;

create table usuario(
    ID varchar(36) unique not null primary key default uuid(),
    nombreU varchar(36) unique not null,
    nombreP varchar(30),
    apellidoP varchar(50),
    contraseniaH varchar(250),
    clavePub varchar(100),
    clavePriv varchar(100)
);

create table sesion(
    ID int not null unique auto_increment,
    estado enum("abierta","cerrada") 
    default "abierta",
    fecha timestamp 
    default CURRENT_TIMESTAMP 
);

create table inicia(
    usuario_ID varchar(36) not null,
    sesion_ID int not null unique primary key
);

