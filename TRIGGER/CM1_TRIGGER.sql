create or replace trigger check
before insert or update
on EMP
for each row
begin
  if :new.sal < :new.comm
  then raise_application_error (-20001,'Cannot add emp');
  end if;
end;
/

insert into emp(empno,ename,sal,comm,deptno,mgr)
values(1000,'Richard',1000,3000,2,839);

create or replace trigger check2
before insert or update
on EMP
for each row
begin
  if :new.comm > :new.sal
  then :new.comm := :new.sal/4;
  end if;
end;
/

/*create trigger qui permet d'interdire la suupression d'employer qui a une commision*/

create or replace trigger noDeleteEmp
before delete
on emp
for each row
begin
	if :old.comm is not null or :old.comm > 0
		then raise_application_error (-20001,'Cannot delete this emp');
	end if;
end;

/*Add attributs in table*/
alter table emp add revenuMensuel decimal(10,2);

alter table emp add revenuAnnuel decimal(10,2);

/*update revenuMenuel and revenuAnnuel*/
update emp set revenuMensuel = sal + NVL(comm,0), revenuAnnuel = (sal +nvl(comm,0)) *12;

create or replace trigger updateRevenu
AFTER INSERT or UPDATE
on emp
for each row
begin
	/*TO DO*/
	:new.revenuMensuel := :new.sal + NVL(:new.comm,0);
	:new.revenuAnnuel := :new.revenuMensuel * 12;
end;
/