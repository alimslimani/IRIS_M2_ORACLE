HOST cls
SET LINESIZE 100
SET PAGESIZE 200

SELECT * FROM CAT;

DROP TABLE EMP;
DROP TABLE DEPT;


CREATE TABLE DEPT (
 DEPTNO              NUMBER(2) PRIMARY KEY,
 DNAME               CHAR(14),
 LOC                 CHAR(13)
);

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE EMP (
 EMPNO               NUMBER(4) PRIMARY KEY,
 ENAME               CHAR(10) NOT NULL,
 JOB                 CHAR(9),
 MGR                 NUMBER(4), FOREIGN KEY(MGR) REFERENCES EMP (EMPNO),
 HIREDATE            DATE NOT NULL,
 SAL                 NUMBER(7,2) NOT NULL CHECK(sal > 0),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) NOT NULL, FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO)
 );

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,to_date(concat('17-11-',extract(year from current_date)-3),'DD-MM-YY'),5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,to_date(concat('1-05-',extract(year from current_date)-2),'DD-MM-YY'),2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,to_date(concat('9-06-',extract(year from current_date)-2),'DD-MM-YY'),2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,to_date(concat('2-04-',extract(year from current_date)-2),'DD-MM-YY'),2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,to_date(concat('28-09-',extract(year from current_date)-2),'DD-MM-YY'),1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,to_date(concat('20-02-',extract(year from current_date)-2),'DD-MM-YY'),1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,to_date(concat('8-09-',extract(year from current_date)-2),'DD-MM-YY'),1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,to_date(concat('3-12-',extract(year from current_date)-2),'DD-MM-YY'),950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,to_date(concat('22-02-',extract(year from current_date)-2),'DD-MM-YY'),1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,to_date(concat('3-12-',extract(year from current_date)-2),'DD-MM-YY'),3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,to_date(concat('17-12-',extract(year from current_date)-3),'DD-MM-YY'),800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,to_date(concat('09-12-',extract(year from current_date)-1),'DD-MM-YY'),3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,to_date(concat('12-01-',extract(year from current_date)),'DD-MM-YY'),1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,to_date(concat('23-01-',extract(year from current_date)-1),'DD-MM-YY'),1300,NULL,10);

select * from cat;
desc emp;
select * from emp;
desc dept;
select * from dept;
