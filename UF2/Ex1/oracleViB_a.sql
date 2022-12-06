CREATE TABLE Alcaldes
(
	DNI varchar2(9) PRIMARY KEY,
	Nom varchar2(20),
	Cognoms varchar2(20),
	Adreca varchar2(20),
	AnyNaixement date
);
CREATE TABLE Poblacions
(
	Codi varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	NumHabitants number(20),
	Comarca varchar2(20),
	DNI varchar2(9) references Alcaldes(DNI)
);
SELECT * FROM Alcaldes;
SELECT * FROM Poblacions;
INSERT INTO Alcaldes values ('11111111A','Pere','Garcia Gras','Major, 10',to_date('01-01-1980','dd-mm-yyyy'));
INSERT INTO Alcaldes values ('22222222B','Maria','Silvent Oms','Major, 20',to_date('02-02-1967','dd-mm-yyyy'));
INSERT INTO Alcaldes values ('33333333C','Santi','Pinares','Gran via, 2',to_date('03-03-1978','dd-mm-yyyy'));

INSERT INTO Poblacions values ('001','Tarragona','150000','Tarragones','11111111A');
INSERT INTO Poblacions values ('002','Reus','120000','Tarragones','22222222B');
INSERT INTO Poblacions values ('003','Valls','75000','Tarragones','33333333C');