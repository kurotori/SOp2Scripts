drop schema if exists usuariosSOP2;
create schema usuariosSOP2;

use usuariosSOP2;

create table usuario(
    id int not null unique auto_increment primary key,
    nombre varchar(20) not null,
    estado enum("conectado","desconectado") not null default "desconectado"
);

INSERT INTO usuario
(nombre)
values
("fulano"),
("mengano")
;
