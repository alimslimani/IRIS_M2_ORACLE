-- ============================================================
--   Nom de la base   :  AEROPORT                              
--   Nom de SGBD      :  ORACLE Version 7.x                    
--   Date de cr‚ation :  19/09/97  10:54                       
-- ============================================================

-- ============================================================
--   Table : VOL                                               
-- ============================================================
create table VOL
(
    NOVOL      CHAR(6)                not null,
    VILDEP     CHAR(30)               null    ,
    VILAR      CHAR(30)               null    ,
    DEPH       NUMBER(2)              null    ,
    DEPMN      NUMBER(2)              null    ,
    ARH        NUMBER(2)              null    ,
    ARMN       NUMBER(2)              null    ,
    constraint PK_VOL primary key (NOVOL)
)
/

-- ============================================================
--   Table : PILOTE                                            
-- ============================================================
create table PILOTE
(
    NOPILOT    CHAR(4)                not null,
    NOMPILOT   CHAR(35)               null    ,
    ADRESSE    CHAR(30)               null    ,
    SALPILOT   NUMBER(8,2)            null    ,
    COMM       NUMBER(8,2)            null    ,
    EMBAUCHE   DATE                   null    ,
    constraint PK_PILOTE primary key (NOPILOT)
)
/

-- ============================================================
--   Table : APPAREIL                                          
-- ============================================================
create table APPAREIL
(
    CODETYPE   CHAR(3)                not null,
    NBPLACE    NUMBER(3)              null    ,
    DESIGN     CHAR(50)               null    ,
    constraint PK_APPAREIL primary key (CODETYPE)
)
/

-- ============================================================
--   Table : AVION                                             
-- ============================================================
create table AVION
(
    NUAVION    CHAR(4)                not null,
    CODETYPE   CHAR(3)                not null,
    ANNSERV    NUMBER(4)              null    ,
    NOMAVION   CHAR(50)               null    ,
    NBHVOL     NUMBER(8)              null    ,
    constraint PK_AVION primary key (NUAVION)
)
/

-- ============================================================
--   Index : CIF_FK                                            
-- ============================================================
create index CIF_FK on AVION (CODETYPE asc)
/

-- ============================================================
--   Table : AFFECT                                            
-- ============================================================
create table AFFECT
(
    NOVOL      CHAR(6)                not null,
    DATEVOL    DATE                   not null,
    NOPILOT    CHAR(4)                not null,
    NUAVION    CHAR(4)                not null,
    NBPASS     NUMBER(3)              null    ,
    constraint PK_AFFECT primary key (NOVOL, DATEVOL, NOPILOT, NUAVION)
)
/

-- ============================================================
--   Index : AFFECT_PK                                         
-- ============================================================
create unique index AFFECT_PK on AFFECT (NOPILOT asc, DATEVOL asc, NOVOL asc, NUAVION asc)
/

-- ============================================================
--   Index : LIEN_11_FK                                        
-- ============================================================
create index LIEN_11_FK on AFFECT (NOPILOT asc)
/

-- ============================================================
--   Index : LIEN_12_FK                                        
-- ============================================================
create index LIEN_12_FK on AFFECT (DATEVOL asc)
/

-- ============================================================
--   Index : LIEN_14_FK                                        
-- ============================================================
create index LIEN_14_FK on AFFECT (NOVOL asc)
/

-- ============================================================
--   Index : LIEN_15_FK                                        
-- ============================================================
create index LIEN_15_FK on AFFECT (NUAVION asc)
/

alter table AVION
    add constraint FK_AVION_CIF_APPAREIL foreign key  (CODETYPE)
       references APPAREIL (CODETYPE)
/

alter table AFFECT
    add constraint FK_AFFECT_LIEN_11_PILOTE foreign key  (NOPILOT)
       references PILOTE (NOPILOT)
/

alter table AFFECT
    add constraint FK_AFFECT_LIEN_14_VOL foreign key  (NOVOL)
       references VOL (NOVOL)
/

alter table AFFECT
    add constraint FK_AFFECT_LIEN_15_AVION foreign key  (NUAVION)
       references AVION (NUAVION)
/

