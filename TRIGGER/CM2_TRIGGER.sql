-- creaer un trigger qui permet à chaque insertion ou modification d'un Pilote, on vérifie les saisies suivantes:
-- si le salaire < à la commission alors la commission doit etre egal à la moitié du salire
-- si la commission est NULL or egal à ZERO, elle doit etre egal à la moitié du salaire
CREATE OR REPLACE TRIGGER checkSal
BEFORE INSERT OR UPDATE
ON Pilote
FOR EACH ROW
BEGIN
	IF :new.sal < :new.comm
	THEN :new.comm := :new.sal/2;
	ELSIF :new.comm is NULL
		OR :new.comm =0
	THEN :new.comm := :new.sal/4;
	END IF;
END;
/

Insert into Piote(noPilote,nom,adresse,sal,comm,embauche)
Values (1000,'Thibault','Paris',2000,3000,sysdate);


-----------
------ 2 ----------
---Traitement dynamique des attributs calcules
--Example d'application
 
-- 1 Ajouter le champ nbVol sur la table Pilote

Alter table Pilote add nbVol integer default 0;

-- 2 Mettez à jour les nombres de Vol pour chaque Pilote

UPDATE Pilote pil set pil.nbVol = (select count(aff.vol) from affectation aff where pil.noPilote = aff.Pilote);

-- 3 Réaliser deux triggers
		--  un trigger d'incrémentation du nombre de Vol
		--  un trigger de décrémentation du nombre de bol

CREATE OR REPLACE TRIGGER incNbVol
AFTER INSERT ON AFFECTATION 
FOR EACH ROW
BEGIN
	UPDATE Pilote pi
		set pi.nbVol = pi.nbVol + 1
	where pi.noPilote = :New.Pilote;
END;
/

INSERT into affectation(vol,date_vol,nbpass,pilote,avion)
values ('IW201',sysdate,12,6723,8567);

CREATE OR REPLACE TRIGGER decNbVol
AFTER DELETE ON AFFECTATION 
FOR EACH ROW
BEGIN
	UPDATE Pilote
		set nbVol = nbVol - 1
	where noPilote = :Old.Pilote;
END;
/

DELETE FROM AFFECTATION where vol = 'IW201' and nbpass=12;

-- EXO

-- 1 Ajouter nbEmp sur la table DEPT

ALTER TABLE DEPT add nbEmp integer default 0;
-- 2 Mettez à jour les champs nbEmp

update dept d set nbEmp = (select count(empno) from emp e where e.deptno=d.deptno);
-- 3 Realiser deux trigger : 
	-- Incrementer nbEmp
	-- decrementer nbEmp

CREATE OR REPLACE TRIGGER incNbEmp
AFTER INSERT ON EMP 
FOR EACH ROW
BEGIN
	UPDATE DEPT
		set nbEmp = nbEmp + 1
	where deptno = :New.deptno;
END;
/

insert into EMP (empno,ename,job,mgr,hiredate,sal,comm,deptno)
values (6666,'ALIM','PO',7839,sysdate,4500,3000,10);

CREATE OR REPLACE TRIGGER decNbEmp
AFTER DELETE ON EMP
FOR EACH ROW
BEGIN
	UPDATE DEPT
		set nbEmp = nbEmp - 1
	where deptno = :Old.deptno;
END;
/

delete from emp where empno = 6666;


-- 3 Securité et Audit
-- Sysdate et user sont des fonctions interne SQL
-- Select sysdat from dual;
-- Show user;

-- Réaliser un trigger qui permet d'interdire à tous les users dont le nom
-- commande par le la lettre A, d'ajouter, de modifier et de supprimer
-- dans la table avion.

CREATE OR REPLACE TRIGGER SecuAvion
BEFORE INSERT OR UPDATE OR DELETE ON avion
FOR EACH ROW
BEGIN
	IF (select user from dual) Revoke 'A%'
		THEN raise_application_error(-20001,'Interdit')	;
	END IF;
END;
/



-- Surveiller les actions sur les tables
-- Les prédicats : 
-- un prédicat permet de présenter l'action que va entreprendre un user
-- sur une table. Cette action est une action LMDF

-- Créer la table AUDIT
CREATE TABLE AUDITVOL( WA integer, Evnt varchar(20),
DateMaj DATE, Vuser varchar(20));

CREATE OR REPLACE TRIGGER secuVol
AFTER INSERT OR UPDATE OR DELETE 
ON Vol
FOR EACH ROW
DECLARE numa integer;
BEGIN
	select MAX(WA) into numa
	from AUDITVOL;
	if numa is NULL
		then numa :=0;
	else numa := numa+1;
	end if;
	IF INSERTING
	then insert into AUDITVOL
		values(numa,'ADD',sysdate,user);
		DBMS_OUTPUT.PUT_LINE(
			'L''utilisateur : ' || user 
			|| 'A ajouter le : ' ||sysdate);
	ELSIF UPDATING
	then Insert into AUDITVOL values(
			numa,'UPDATE',sysdate,user);
		DBMS_OUTPUT.PUT_LINE('L''utilisateur: ' ||user 
			|| ' A modifier le' ||sysdate);
	else 
		Insert into AUDITVOL values(
			numa,'DELETE',sysdate,user);
		DBMS_OUTPUT.PUT_LINE('L''utilisateur : ' ||user 
			|| 'A supprimer le : ' ||sysdate);
	END IF;
END;
/

-- table de restauration

CREATE TABLE HISTOVOL AS select noVol,VILDEP,VILAR,DEP_H,
DEP_MN,AR_H,AR_MN,CH_JOUR,sysdate dateHisto,
user userHisto from VOL where 2=0;

CREATE OR REPLACE TRIGGER HISTO
BEFORE INSERT OR UPDATE ON VOL
FOR EACH ROW
BEGIN
	IF INSERTING
	then insert into HISTOVOL
		values(new.noVol,new.VILDEP,new.VILAR,new.DEP_H,
new.DEP_MN,new.AR_H,new.AR_MN,new.CH_JOUR,sysdate,user);
	ELSIF UPDATING
	then Insert into HISTOVOL values(
			old.noVol,old.VILDEP,old.VILAR,old.DEP_H,
old.DEP_MN,old.AR_H,old.AR_MN,old.CH_JOUR,sysdate,user);
	END IF;
END;
/