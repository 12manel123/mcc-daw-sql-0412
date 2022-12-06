CREATE TABLE Director
(
    Codi number(9) PRIMARY KEY,
    Nom varchar2(20),
    Cognom1 varchar(20),
    Cognom2 varchar(20),
    Any_naixement date,
    Nacionalitat varchar(20)
);
CREATE TABLE Tema
(
    Codi number(9) PRIMARY KEY,
    Nom varchar2(20)
);
CREATE TABLE Pelicules
(
    Codi number(9) PRIMARY KEY,
    Titol varchar2(20),
    Pressupost number(20),
    Any_ varchar(20),
    codiT number(9) references Tema(Codi),
    codiD number(9) references Director(Codi)
);
CREATE TABLE Actor
(
    Codi number(9) PRIMARY KEY,
    Nom varchar2(20),
    Cognom1 varchar(20),
    Cognom2 varchar(20)
);
CREATE TABLE Interpretar
(
    codiP number(9) references Pelicules(Codi),
    codiA number(9) references Actor(Codi),
    rol varchar2(20)
);
CREATE TABLE Especialista
(
    codiA number(9) references Actor(Codi),
    codiT number(9) references Tema(Codi),
    Grau number(9)
);
CREATE TABLE Ser_substitut
(
    codiA1 number(9) references Actor(Codi),
    codiA2 number(9) references Actor(Codi),
    Grau varchar2(20)
);


INSERT INTO Director values ('1', 'Alejandro', 'Amenánar', 'Cantos',to_date('1972','yyyy'),'Chile');
INSERT INTO Director values ('2', 'Jaume', 'Balagueró', 'Bernat',to_date('1968','yyyy'),'España');

INSERT INTO Tema values ('1','Terror');
INSERT INTO Tema values ('2','Historica');
INSERT INTO Tema values ('3','Drama');
INSERT INTO Tema values ('4','Comedia');
INSERT INTO Tema values ('5','Ciència Ficcio');

INSERT INTO Pelicules values ('1', 'REC', null,to_date('2007','yyyy'),'1','2');
INSERT INTO Pelicules values ('2', 'REC2', null,to_date('2009','yyyy'),'1','2');
INSERT INTO Pelicules values ('3', 'Fragiles', null,to_date('2005','yyyy'),'1','2');
INSERT INTO Pelicules values ('4', 'Los sin nombre', null,to_date('1999','yyyy'),'1','2');
INSERT INTO Pelicules values ('5', 'Abre los ojos', null,to_date('1997','yyyy'),'5','1');
INSERT INTO Pelicules values ('6', 'Mar Adentro', null,to_date('2004','yyyy'),'3','1');
INSERT INTO Pelicules values ('7', 'Agora', null,to_date('2009','yyyy'),'2','1');
INSERT INTO Pelicules values ('8', 'Los otros', null,to_date('2001','yyyy'),'5','1');
INSERT INTO Pelicules values ('9', 'Tesis', null,to_date('1996','yyyy'),'1','1');

INSERT INTO Actor values ('1', 'Eduardo','Noriega','Gómez');
INSERT INTO Actor values ('2', 'Fele','Martinez',null);
INSERT INTO Actor values ('3', 'Nikole','Kidman',null);
INSERT INTO Actor values ('4', 'Alakina','Mann',null);
INSERT INTO Actor values ('5', 'Javier','Bardem',null);
INSERT INTO Actor values ('6', 'Belén','Rueda',null);

INSERT INTO Interpretar values ('5','1','Protagonista');
INSERT INTO Interpretar values ('9','1','Protagonista');
INSERT INTO Interpretar values ('5','2','Actor_secundari');
INSERT INTO Interpretar values ('9','2','Actor_secundari');
INSERT INTO Interpretar values ('6','5','Actor_principal');
INSERT INTO Interpretar values ('6','6','Actor_principal');
INSERT INTO Interpretar values ('8','3','Actor_principal');
INSERT INTO Interpretar values ('8','4','Actor_secundari');
INSERT INTO Interpretar values ('1','1','Actor');
INSERT INTO Interpretar values ('1','2','Actor');

INSERT INTO Especialista values (1,1,10);
INSERT INTO Especialista values (1,3,8);
INSERT INTO Especialista values (1,4,6);

INSERT INTO Ser_substitut values (1,2,9);



UPDATE Pelicules SET Pressupost='1700000' WHERE codi=1;
UPDATE Pelicules SET Any_=to_date('2008','yyyy') WHERE codi=1;
UPDATE Especialista SET Grau=9 WHERE codiT=3;
UPDATE Especialista SET Grau = Grau - 1 WHERE codiA=1;
Delete from Pelicules where codi = 2;

UPDATE Pelicules SET codiT=null WHERE codiT=1;
UPDATE Especialista SET codiT=null WHERE codiT=1;
Delete from Tema where codi = 1;

UPDATE Pelicules SET codiD=null WHERE codiD=1;
Delete from Director where codi = 1;

UPDATE Interpretar SET codiP=null WHERE codiP=1;
UPDATE Interpretar SET codiP=null WHERE codiP=2;
UPDATE Interpretar SET codiP=null WHERE codiP=3;
UPDATE Interpretar SET codiP=null WHERE codiP=9;
Delete from Pelicules where codiT is null;
SELECT * FROM Pelicules;