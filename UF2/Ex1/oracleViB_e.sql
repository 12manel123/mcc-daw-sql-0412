CREATE TABLE Equip
(
	Codi varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Poblacio varchar2(20),
	Any_Fundacio date
);
CREATE TABLE Jugador
(
	DNI varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Cognoms varchar2(20),
    Posicio varchar2(20),
	Data_naix date,
    Codi varchar2(20) references Equip(Codi)
);

INSERT INTO Equip values ('111','FC Serrallo','Tarragona',to_date('1970','yyyy'));
INSERT INTO Equip values ('222','FC S.Pere i S.Pau','Tarragona',to_date('1984','yyyy'));

INSERT INTO Jugador values ('11111111A','Raul','Rodriguez','Davanter',to_date('05-05-1990','dd-mm-yyyy'),'111');
INSERT INTO Jugador values ('22222222B','Josep','Mas','Defensa',to_date('06-06-1985','dd-mm-yyyy'),'111');
INSERT INTO Jugador values ('33333333C','Carles','Sans','Porter',to_date('07-08-1990','dd-mm-yyyy'),'111');
INSERT INTO Jugador values ('44444444D','Mario','Suarez','Davanter',to_date('08-05-1990','dd-mm-yyyy'),'222');
INSERT INTO Jugador values ('55555555E','Francesc','Grau','Defensa',to_date('05-04-1986','dd-mm-yyyy'),'222');
INSERT INTO Jugador values ('66666666F','Enric','Llopis','Porter',to_date('11-05-1987','dd-mm-yyyy'),'222');

SELECT * FROM Equip;
SELECT * FROM Jugador;