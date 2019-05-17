create database elecciones;


create table partido(
    nomPresidente varchar(30),
    nombrePartido varchar(30) primary key
);
    
Create table militante(
    num_militante integer,
    partido varchar(30),
    fecha_alta date,
    nombre varchar(30),
    PRIMARY KEY (num_militante,partido),
    FOREIGN KEY (partido) references partido(nombrePartido)
);
   	
CREATE TABLE campanya(
    partido varchar(30),
    fecha date,
    votos integer,
    porcentage numeric,
    PRIMARY KEY (partido,fecha),
    FOREIGN key (partido) references partido(nombrePartido)
);
delimiter $$
create FUNCTION fc_porcentage (votos int,votosTotales int)
RETURNS float
BEGIN
return 100*votos/votosTotales;
end $$

CREATE TRIGGER tr_setPorcentage_AU AFTER UPDATE on campanya
FOR EACH ROW
begin
declare votosTotales int;
set votosTotales = (SELECT SUM(votos) from campanya);
INSERT into campanya(porcentage)
values (fc_porcentage(new.votos,votosTotales));
END$$

DELIMITER $$

create PROCEDURE pr_muestraresultado()
BEGIN
SELECT * FROM campanya ORDER BY votos DESC;
end $$

delimiter ;




    

