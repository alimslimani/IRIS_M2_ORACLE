

CREATE TABLE vol 
	(novol char(6) primary key not NULL,
	vildep varchar2(30),
	vilar varchar2(30),
	dep_h NUMBER(2),
	dep_mn NUMBER(2),
	ar_h NUMBER(2),
	ar_mn NUMBER(2),
	ch_jour NUMBER(1));


CREATE TABLE pilote 
	(nopilote int primary key not NULL,
	nom  varchar2(35),
	adresse	varchar2(30),
	sal NUMBER(8,2),
	comm NUMBER(8,2),
	embauche DATE);


CREATE TABLE appareil (
	codetype char(3) primary key not NULL,
	nb_place NUMBER(3),
	design	varchar2(50)
);

CREATE TABLE avion
	(nuavion int primary key not NULL,
	annserv	NUMBER(4),
	nom varchar2(50),
	nbhvol NUMBER(8),
	type char(3) not null,
        foreign key(type) references appareil(codetype));  


CREATE TABLE affectation
	(vol char(6) not null,
       foreign key(vol) references vol(novol),
	date_vol DATE not null,  
	nbpass NUMBER(3),
	pilote int not null,
       foreign key (pilote)references pilote(nopilote),
	avion int not null,
       foreign key(avion)references avion(nuavion),
        primary key(vol,date_vol,pilote,avion)); 


INSERT INTO appareil VALUES ('74E',150,'BOEING 747-400 COMBI');
INSERT INTO appareil VALUES ('AB3',180,'AIRBUS A300');
INSERT INTO appareil VALUES ('741',100,'BOEING 747-100');
INSERT INTO appareil VALUES ('SSC',80,'CONCORDE');
INSERT INTO appareil VALUES ('734',450,'BOEING 747-400');


INSERT INTO avion VALUES (8832,1988,'Ville de Paris',16000,'734');
INSERT INTO avion VALUES (8567,1988,'Ville de Reims',8000,'734');
INSERT INTO avion VALUES (8467,1995,'Le Sud'        ,600,'734');
INSERT INTO avion VALUES (7693,1988,'PAcifique'     ,34000,'741');
INSERT INTO avion VALUES (8556,1989, null           ,12000,'AB3');
INSERT INTO avion VALUES (8432,1991,'Makte'         ,10600,'AB3');
INSERT INTO avion VALUES (8118,1992, null           ,11800,'74E');

INSERT INTO vol VALUES ('AF8810','PARIS'     ,'DJERBA'   ,09,00,11,45,0);
INSERT INTO vol VALUES ('AF8809','DJERBA'    ,'PARIS'    ,12,45,15,40,0);
INSERT INTO vol VALUES ('IW201' ,'LYON','FORT DE FRANCE' ,09,45,15,25,0);
INSERT INTO vol VALUES ('IW655' ,'LA HAVANCE','PARIS'    ,19,55,12,35,1);
INSERT INTO vol VALUES ('IW433' ,'PARIS'     ,'ST-MARTIN',17,00,08,20,1);
INSERT INTO vol VALUES ('IW924' ,'SYDNEY'    ,'COLOMBO'  ,17,25,22,30,0);
INSERT INTO vol VALUES ('IT319' ,'BORDEAUX'  ,'NICE'     ,10,35,11,45,0);
INSERT INTO vol VALUES ('AF3218','MARSEILLE' ,'FRANCFORT',16,45,19,10,0);
INSERT INTO vol VALUES ('AF3530','LYON'      ,'LONDRES'  ,08,00,08,40,0);
INSERT INTO vol VALUES ('AF3538','LYON'      ,'LONDRES'  ,18,35,19,15,0);
INSERT INTO vol VALUES ('AF3570','MARSEILLE' ,'LONDRES'  ,09,35,10,20,0);

INSERT INTO pilote VALUES (1333,'FEDOI','NANTES',24000.00,0.00,'01-03-92');
INSERT INTO pilote VALUES (6589,'DUVAL','PARIS',18600.00,5580.00,'12-03-92');
INSERT INTO pilote VALUES (7100,'MARTIN','LYON',15600.00,16000,00'01-04-93');
INSERT INTO pilote VALUES (3452,'ANDRE','NICE',22670.00,null,'12-01-92');
INSERT INTO pilote VALUES (3421,'BERGER','REIMS',18700.00,null,'28-01-92');
INSERT INTO pilote VALUES (6548,'BARRE','LYON',22680.00,8600.00,'01-01-92');
INSERT INTO pilote VALUES (1243,'COLLET','PARIS',19000.00,0.00,'01-01-90');
INSERT INTO pilote VALUES (5643,'DELORME','PARIS',21850.00,9850.00,'01-01-92');
INSERT INTO pilote VALUES (6723,'MARTIN','ORSAY',23150.00,null,'01-05-92');
INSERT INTO pilote VALUES (8843,'GAUCHER','CACHAN',17600.00,null,'20-11-92');
INSERT INTO pilote VALUES (3465,'PIC','TOURS',18650.00,null,'15-07-93');

INSERT INTO affectation VALUES('IW201','01-03-94','310','6723','8567');
INSERT INTO affectation VALUES('IW201','02-03-94','265','6723','8832');
INSERT INTO affectation VALUES('AF3218','12-05-94','93','6723','7693');
INSERT INTO affectation VALUES('AF3530','12-11-94','178','6723','8432');
INSERT INTO affectation VALUES('AF3530','13-11-94','156','6723','8432');
INSERT INTO affectation VALUES('AF3538','21-12-94','110','6723','8118');
INSERT INTO affectation VALUES('IW201','03-03-94','356','1333','8567');
INSERT INTO affectation VALUES('IW201','12-03-94','211','6589','8467');
INSERT INTO affectation VALUES('AF8810','02-03-94','160','7100','8556');
INSERT INTO affectation VALUES('IT319','02-03-94','105','3452','8432');
INSERT INTO affectation VALUES('IW433','22-03-94','178','3421','8556');
INSERT INTO affectation VALUES('IW655','23-03-94','118','6548','8118');
INSERT INTO affectation VALUES('IW655','20-12-94','402','1243','8467');
INSERT INTO affectation VALUES('IW655','18-01-94','398','5643','8467');
INSERT INTO affectation VALUES('IW924','30-04-94','412','8843','8832');
INSERT INTO affectation VALUES('IW201','01-05-94','156','6548','8432');
INSERT INTO affectation VALUES('AF8810','02-05-94','88','6589','7693');
INSERT INTO affectation VALUES('AF3218','01-09-94','98','8843','7693');
INSERT INTO affectation VALUES('AF3570','12-09-94','56','1243','7693');








