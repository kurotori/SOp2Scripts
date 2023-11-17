INSERT INTO inicia
(usuario_ID,sesion_ID)
values
(
    (select ID from usuario 
    where nombreU = "luisS"), 
    22
    );

INSERT INTO libro
(titulo, ISBN, genero, fecha_pub)
values
("El gran Fulano",1122334455,"Comedia","2023-01-01");

INSERT INTO autor
(nombre, apellido, nacionalidad, DOC, fecha_nac)
values
("Carlota","Buenavista","Panamá","1234567-8","1972-03-15");

select DOC from autor where apellido="Buenavista";
select ISBN from libro where titulo="El gran fulano";

INSERT INTO escribe
(autor_doc, libro_isbn)
values
(
    (select DOC from autor where apellido="Buenavista"),
    (select ISBN from libro where titulo="El gran fulano")
);

select 
autor_doc, libro_isbn,

(select concat_ws(",",apellido,nombre) from autor
WHERE autor.DOC = autor_doc) as Autor,

(select concat_ws(",",titulo,genero) from libro
WHERE libro.ISBN = libro_isbn) as Libro

from escribe 
where libro_isbn=1122334455;

/* Vincular sesión con nombre de usuario */

INSERT INTO inicia
(usuario_ID, sesion_ID)
values
(select ID from usuario where nombreU=?nombre de usuario?),
?ID de sesión?;






select titulo from libro where titulo like "% "
;select * from autor; %";


