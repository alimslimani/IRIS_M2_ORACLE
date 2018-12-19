HOST cls;
SET LINESIZE 100;
SET PAGESIZE 200;

drop table PARTICIPE;
drop table PROJET;
drop table EMPLOYE;


create table EMPLOYE 
(
numemp number not null,
nom varchar2(30),
numserv number,
numchef number,
salire number,
primary key(numemp)
);


create table PROJET 
(
numproj number not null,
nomproj varchar2(30),
numeroresponsable number,
primary key (numproj)
);

create table PARTICIPE 
(
numemp number not null,
numproj number not null,
quota number,
primary key (numemp,numproj),
foreign key (numemp) references EMPLOYE(numemp),
foreign key (numproj) references PROJET(numproj)
);