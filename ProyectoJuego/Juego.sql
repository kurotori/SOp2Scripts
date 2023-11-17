drop database if exists juego;
create database juego;
use juego;

create table usuario(
    ID varchar(36) unique not null 
    primary key default (uuid()),

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

alter table inicia
add constraint fk_usuario_inicia
foreign key (usuario_ID)
references usuario(ID)
on update cascade
on delete cascade,
add constraint fk_inicia_sesion
foreign key (sesion_ID)
references sesion(ID)
on update cascade
on delete cascade
;

delimiter //

drop procedure if exists datosDeUsuario;
create procedure datosDeUsuario(
    IN nombre varchar(36)
)
BEGIN
    /* 4 - Al comienzo del procedimiento declaro cualquier variable
     inicial que precise para la ejecución del mismo*/
    declare IDusuario varchar(36);
    declare nomUsuario varchar(36);
    declare nombrePUsuario varchar(30);
    declare apellidoPUsuario varchar(50);
    declare sesiones_iniciadas int;
    declare estado enum('online','offline');

    SELECT 
    ID,nombreU,nombreP,apellidoP
    INTO
    IDusuario, nomUsuario, nombrePUsuario, apellidoPUsuario
    from juego.usuario
    where nombreU=nombre;

    SELECT
    count(ID)
    INTO sesiones_iniciadas
    from sesion
    where ID in
    (SELECT sesion_ID from inicia WHERE
    usuario_ID=IDusuario);

    SELECT if(sesiones_iniciadas>1,"online","offline") into estado;

    SELECT concat_ws(":",IDusuario,nomUsuario,nombrePUsuario,apellidoPUsuario,estado)
    as "DatosDeUsuario";
END//

/* 8 - Tras la declaración del procedimiento, restauro el delimitador */
delimiter ;

SELECT
    count(ID)
    into @v1
    from sesion
    where ID in
    (SELECT sesion_ID from inicia WHERE
    usuario_ID="5261fd94-47ff-11ee-9a6a-f8b291c11216");