CREATE TABLE Ingredients
(
	Codi varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Tipus varchar2(20),
	Preu varchar2(20)
);
CREATE TABLE Receptes
(
	Codi varchar2(20) PRIMARY KEY,
	Nom varchar2(20),
	Num_persones number(20),
    Descripcio varchar2(40)
);

CREATE TABLE Te
(
    CodiR varchar2(20) references Receptes(Codi),
    CodiI varchar2(20) references Ingredients(Codi),
    quantitat varchar2(20)
);

INSERT INTO Ingredients values ('1','Macarrons','Pasta','1,10');
INSERT INTO Ingredients values ('2','Salsa tomaquet','Salsa','0,75');
INSERT INTO Ingredients values ('3','Carn vedella','Carn','1,30');
INSERT INTO Ingredients values ('4','Patata','Verdura','0,50');
INSERT INTO Ingredients values ('5','Ou gallina','Ou','0,25');
INSERT INTO Ingredients values ('6','Oli oliva','Oli','3,78');
INSERT INTO Ingredients values ('7','Sal',null,'0,05');

INSERT INTO Receptes values ('1','Macarrons bolonyesa','4','Macarrons amb carn trixada');
INSERT INTO Receptes values ('2','Truita','4','Truita tipica espanyola');

INSERT INTO Te values ('1','1','100');
INSERT INTO Te values ('1','2','50');
INSERT INTO Te values ('1','3','200');
INSERT INTO Te values ('1','7','2');
INSERT INTO Te values ('2','4','20');
INSERT INTO Te values ('2','5','30');
INSERT INTO Te values ('2','6','10');
INSERT INTO Te values ('2','7','3');


SELECT * FROM Ingredients;
SELECT * FROM Receptes;
SELECT * FROM Te;
