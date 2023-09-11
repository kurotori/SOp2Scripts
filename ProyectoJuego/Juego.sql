drop database if exists juego;
create database juego;
use juego;

create table usuario(
<<<<<<< HEAD
    ID varchar(36) unique not null primary key default uuid(),
=======
    ID varchar(36) unique not null 
    primary key default (uuid()),

>>>>>>> 6ed068e624ce53b593200aa2972534d5469f6095
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

