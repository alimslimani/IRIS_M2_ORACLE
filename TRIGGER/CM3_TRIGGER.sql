CREATE OR REPLACE TRIGGER checkQTE
BEFORE INSERT OR UPDATE
ON VIN
FOR EACH ROW
declare test integer;
BEGIN
	SELECT count(*) into test
	FROM VIN 
	WHERE cru = :new.cru
	AND millesime = :new.millesime;
	IF test >1 
		THEN
			raise_application_error(-20555, 'Impossible to Insert, row already exist in DataBase');
	END IF;
END;
/

ALTER TABLE VIN
ADD CONSTRAINT UN unique (cru,millesime);

Insert into VIN(idvin,cru,millesime,regionproduction)
Values (1,'Boredeau','1898','Boredeau');
Insert into VIN(idvin,cru,millesime,regionproduction)
Values (2,'Boredeau','1898','Paris');


CREATE OR REPLACE TRIGGER checkAbus
BEFORE INSERT OR UPDATE
ON ABUS
FOR EACH ROW
declare categorie integer;
BEGIN
	SELECT catsocprof into categorie
	FROM GOUTEUR 
	WHERE numero = :new.numerogouteur
	AND categorie = 13
	AND :new.quantite > 10;
	IF categorie >1 
		THEN
			raise_application_error(-20688, 'Impossible de boire plus de verres');
	END IF;
END;
/


/*Q3-Q4*/
CREATE OR REPLACE TRIGGER checkGouteur
BEFORE INSERT OR UPDATE
ON GOUTEUR
FOR EACH ROW
BEGIN
	IF :new.age > 18 or :new.catsocprof is null
	THEN raise_application_error (-20001, 'Trop jeune');
	END IF;
END;
/


/*Q5-Q6*/
CREATE OR REPLACE TRIGGER checkExist1
BEFORE INSERT OR UPDATE
ON ABUS
FOR EACH ROW
declare id integer;
BEGIN
	SELECT count(*) into id
	FROM VIN 
	WHERE idvin = :new.idvin;
	IF id = 0 OR :new.quantite < 0
		THEN raise_application_error(-20585,'Erruer');
	END IF;
END;
/ 

/*Q7*/
CREATE OR REPLACE TRIGGER verifCat
BEFORE INSERT OR UPDATE
ON GOUTEUR
FOR EACH ROW
BEGIN
	IF :new.catsocprof NOT BETWEEN 1 and 20
		THEN raise_application_error(-25845,'Erreur de saisie');
	END IF;

END;
/


/*Exercice deux*/
/*Q1*/

CREATE OR REPLACE TRIGGER checkResponsable
BEFORE INSERT OR UPDATE 
ON PROJET
FOR EACH ROW
declare id integer;
BEGIN
	SELECT count(*) into id
	FROM PARTICIPE
	WHERE numemp = :new.numeroresponsable;
	IF id = 0
		THEN raise_application_error(-20154,'erreur : impossible ...');
	END IF;
END;
/


/*Q2*/
CREATE OR REPLACE TRIGGER checkResponsable2
BEFORE INSERT OR UPDATE 
ON PROJET
FOR EACH ROW
declare id integer;
BEGIN
	SELECT count(*) into id
	FROM PARTICIPE
	WHERE numemp = :new.numeroresponsable
	AND numproj = :new.numproj;
	IF id = 0
		THEN insert into PARTICIPE(numemp,numproj)
		values (:new.numeroresponsable,:new.numproj);
	END IF;
END;
/

/*Q3*/
CREATE OR REPLACE TRIGGER checkQuota
BEFORE INSERT OR UPDATE 
ON PARTICIPE
FOR EACH ROW
declare id integer;
BEGIN
	SELECT SUM(quota) into id
	FROM PARTICIPE
	WHERE numemp = :new.numemp;
	IF id + :new.quota>100
		THEN raise_application_error(-20002,'quota depasse');
	END IF;
END;
/