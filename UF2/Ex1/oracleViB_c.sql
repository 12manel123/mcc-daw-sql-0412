CREATE TABLE Llibres
(
	ISBN varchar2(20) PRIMARY KEY,
	Titol varchar2(20),
	Editorial varchar2(20),
	Any_publicacio date,
    Idioma varchar2(20),
    Tema varchar2(20)
);
CREATE TABLE Autors
(
	Codi varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Cognoms varchar2(20),
	Data_naix date,
    Lloc_naix varchar2(20)
);
CREATE TABLE ha_escrit
(
	ISBN varchar2(9) references Llibres(ISBN),
    Codi varchar2(9) references Autors(Codi)
);

SELECT * FROM Llibres;
SELECT * FROM Autors;
SELECT * FROM ha_escrit;

INSERT INTO Llibres values ('1111','Oracle facil','Anaya',to_date('2001','yyyy'),'Catala','Base dades');
INSERT INTO Llibres values ('2222','Programacio web','Prentice Hall',to_date('2010','yyyy'),'Catala','programacio');
INSERT INTO Llibres values ('3333','MySql','Prentice Hall',to_date('2005','yyyy'),'Castella','Base dades');

INSERT INTO Autors values ('1','Ramon','Casals Ponts',to_date('01-02-1990','dd-mm-yyyy'),'Tarragona');
INSERT INTO Autors values ('2','Victor','Subirats Canals',to_date('02-03-1980','dd-mm-yyyy'),'Barcelona');
INSERT INTO Autors values ('3','Francesc','Dalmau Sants',to_date('03-04-1974','dd-mm-yyyy'),'Tarragona');

INSERT INTO ha_escrit values ('1111','1');
INSERT INTO ha_escrit values ('1111','2');
INSERT INTO ha_escrit values ('2222','3');
INSERT INTO ha_escrit values ('3333','2');
INSERT INTO ha_escrit values ('3333','3');