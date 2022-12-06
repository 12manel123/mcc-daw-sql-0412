CREATE TABLE Empleat
(
	DNI varchar2(9) PRIMARY KEY,
	Nom varchar2(20),
	Cognoms varchar2(20),
	AnyNaixement date
);
CREATE TABLE ser_fill
(
	DNI1 varchar2(9) references Empleat(DNI),
    DNI2 varchar2(9) references Empleat(DNI)
);
SELECT * FROM Empleat;
SELECT * FROM ser_fill;

INSERT INTO Empleat values ('11111111A','Ester','Pou Grau',to_date('01-01-1965','dd-mm-yyyy'));
INSERT INTO Empleat values ('22222222B','Josep','Dalmau Sarral',to_date('01-01-1960','dd-mm-yyyy'));
INSERT INTO Empleat values ('33333333C','Robert','Dalmau Pou',to_date('02-02-1990','dd-mm-yyyy'));
INSERT INTO Empleat values ('44444444D','Maria','Dalmau Pou',to_date('03-03-1992','dd-mm-yyyy'));

INSERT INTO ser_fill values ('11111111A','33333333C');
INSERT INTO ser_fill values ('11111111A','44444444D');
INSERT INTO ser_fill values ('22222222B','33333333C');
INSERT INTO ser_fill values ('22222222B','44444444D');