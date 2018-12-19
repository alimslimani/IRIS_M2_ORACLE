HOST cls;
SET LINESIZE 100;
SET PAGESIZE 200;

drop table ABUS;
drop table GOUTEUR;
drop table VIN;


create table GOUTEUR 
(
numero number not null,
nom varchar2(30),
age number,
catsocprof number,
region varchar2(20),
primary key(numero)
);


create table VIN 
(
idvin number not null,
cru varchar2(30),
millesime number,
regionproduction varchar2(40),
primary key (idvin),
unique(cru,millesime)
);

create table ABUS 
(
id_vin number not null,
numerogouteur number not null,
quantite number,
primary key (id_vin,numerogouteur),
foreign key (numerogouteur) references GOUTEUR(numero),
foreign key (id_vin) references VIN(idvin)
);