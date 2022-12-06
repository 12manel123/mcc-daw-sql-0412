CREATE TABLE Pisos
(
	Codi varchar2(20) PRIMARY KEY,
	M2 varchar2(20),
	Preu varchar2(20),
	Any_Construccio date,
    Adreca varchar2(20)
);
CREATE TABLE Persones
(
	DNI varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Cognoms varchar2(20),
	Data_naix date,
    Codi varchar2(20) references Pisos(Codi)
);
CREATE TABLE Propietari
(
	Codi varchar2(9) references Pisos(Codi),
    DNI varchar2(9) references Persones(DNI)
);

INSERT INTO Pisos values ('1','80','100.000,00€',to_date('1980','yyyy'),'Major 1');
INSERT INTO Pisos values ('2','85','200.000,00€',to_date('1985','yyyy'),'Major 2');
INSERT INTO Pisos values ('3','125','150.000,00€',to_date('1999','yyyy'),'Lluis Companys 30');

INSERT INTO Persones values ('11111111A','Ramon','Casals Ponts',to_date('01-02-1976','dd-mm-yyyy'),'1');
INSERT INTO Persones values ('22222222B','Victor','Subirats Canals',to_date('02-03-1978','dd-mm-yyyy'),'2');
INSERT INTO Persones values ('33333333C','Francesc','Dalmau Sants',to_date('03-04-1960','dd-mm-yyyy'),'3');
INSERT INTO Persones values ('44444444D','Maria','Subirats Tortosa',to_date('09-05-1979','dd-mm-yyyy'),'1');
INSERT INTO Persones values ('55555555E','Lluisa','Lopez Garcia',to_date('12-12-1974','dd-mm-yyyy'),'2');

INSERT INTO propietari values ('1','11111111A');
INSERT INTO propietari values ('1','44444444D');
INSERT INTO Propietari values ('2','55555555E');
INSERT INTO Propietari values ('3','11111111A');

SELECT * FROM Pisos;
SELECT * FROM Persones;
SELECT * FROM Propietari;