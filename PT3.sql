--------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------PRACTICA 3------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/*Testers y demas para el inicio*/
SET SERVEROUTPUT ON;
DROP TYPE Institut_T;
DROP TYPE Nota_T;
DROP TYPE Notes_NT;
DROP TYPE Aficio_T;
DROP TYPE AficioEsport_T;
DROP TYPE AficioMusical_T;
DROP TYPE Estudiant_T;
DROP TABLE TaulaEstudiants;
DROP TABLE TaulaInstituts;
SELECT * FROM TaulaEstudiants;
SELECT * FROM TaulaInstituts;
/*---------------------------Ex1-------------------------------*/


CREATE or replace TYPE Institut_T as OBJECT(
    codi number(3),
    nom varchar(80)
);

CREATE or replace TYPE Nota_T as OBJECT(
    nota number(2),
    asignatura varchar(80)
);

CREATE or replace TYPE Notes_NT as TABLE of Nota_T;

CREATE or replace TYPE Aficio_T as OBJECT(
    descripcio varchar(80),
    horesSetmana number(10)
)NOT FINAL;

CREATE or replace TYPE AficioEsport_T UNDER Aficio_T(
    caloriesPerSetmana number(9)
);
CREATE or replace TYPE AficioMusical_T UNDER Aficio_T(
    instrument varchar(80)
);
DROP TABLE ESTUDIANTS;
CREATE or replace TYPE Estudiant_T as OBJECT(
    nif varchar(9),
    nom varchar(80),
    notes Notes_NT,
    institut ref Institut_T,
    aficioPreferida Aficio_T,
    MAP MEMBER FUNCTION notaMitjana RETURN number,
    MEMBER FUNCTION obtenirInstitut RETURN varchar2
);


/*-----------------------EX2-------------------------*/


CREATE TABLE TaulaInstituts of Institut_T(primary key(codi));

CREATE TABLE TaulaEstudiants OF Estudiant_T (
    PRIMARY KEY(nif)
) NESTED TABLE notes STORE AS notes;


/*------------------------EX3--------------------------*/
CREATE OR REPLACE TYPE body Estudiant_T as
MAP MEMBER function notaMitjana Return number AS
estudiant Estudiant_T;
notes Notes_NT;
i number(2);
taulaNotes Notes_NT;
NotaF number(2);
begin
    taulaNotes:=SELF.notes;
    i:=1;
    notaF:=0;
    if(SELF.notes is NULL) then
        return -1;
    else
        while(i<=taulaNotes.COUNT) loop
            notaF:=notaF+taulaNotes(i).nota;
            i:=i+1;
        end loop;
        return (notaF/taulaNotes.COUNT);
    end if;
end notaMitjana;

MEMBER FUNCTION obtenirInstitut return varchar2 AS
insnom Institut_T;
BEGIN
SELECT DEREF(institut) INTO insnom FROM TaulaEstudiants WHERE nif = SELF.nif;
IF (insnom.nom IS NOT NULL) THEN 
RETURN insnom.nom;
ELSE
RETURN 'No hi ha';
END IF;
END obtenirInstitut;
END;


SELECT E.notaMitjana() FROM TaulaEstudiants E WHERE E.nif = '39333111X';
SELECT E.notaMitjana() FROM TaulaEstudiants E WHERE E.nif = '39111222S';
SELECT E.notaMitjana() FROM TaulaEstudiants E WHERE E.nif = '21121144D';
SELECT E.obtenirInstitut() FROM TaulaEstudiants E WHERE E.nif = '39333111X';
SELECT E.obtenirInstitut() FROM TaulaEstudiants E WHERE E.nif = '39111222S';
SELECT E.obtenirInstitut() FROM TaulaEstudiants E WHERE E.nif = '21121144D';


/*----------------------------------EX4----------------------------------*/

INSERT INTO TaulaInstituts VALUES (Institut_T(123, 'IES La Comina'));
INSERT INTO TaulaInstituts VALUES (Institut_T(222, 'IES Estany Llong'));

INSERT INTO TaulaEstudiants values (Estudiant_T('39333111X','Manel Carrasco',NULL,(SELECT REF(P) FROM TaulaInstituts P WHERE P.codi = 123),AficioEsport_T('Tenis', 10, 3500)));
INSERT INTO TaulaEstudiants values (Estudiant_T('39111222S','Laia Caparrós',Notes_NT(Nota_T(7.5,'Matematiques'),Nota_T(8,'Fisica')),(SELECT REF(P) FROM TaulaInstituts P WHERE P.codi = 123),AficioMusical_T('Tocar piano',15,'Piano')));
INSERT INTO TaulaEstudiants values (Estudiant_T('21121144D','Eugeni Torrent',Notes_NT(Nota_T(3,'Tecnologia'),Nota_T(2,'Educacio Fisica')),(SELECT REF(P) FROM TaulaInstituts P WHERE P.codi = 222),Aficio_T('Pintar',40)));--Al ser una aficio normal no limplemetno si es musical o deport--

/*----------------------------------EX5------------------------------*/


/*5.1*/
SELECT nif, nom, E.obtenirInstitut() AS Institut FROM TaulaEstudiants E WHERE E.aficioPreferida.horesSetmana > 12;

/*5.2*/
SELECT E.nif, E.nom, E.aficioPreferida.descripcio AS descripcio, E.aficioPreferida.horesSetmana AS horesSetmana, TREAT(E.aficioPreferida AS AficioEsport_T).caloriesPerSetmana AS caloriesPerSetmana FROM TaulaEstudiants E WHERE E.aficioPreferida IS OF (ONLY AficioEsport_T);

/*5.3*/
DECLARE
i number(3);
taulaNotes Notes_NT;
BEGIN
i:= 1;
SELECT notes INTO taulaNotes FROM TaulaEstudiants WHERE nom = 'Eugeni Torrent';
WHILE (i <= taulaNotes.COUNT) LOOP
    DBMS_OUTPUT.PUT_LINE('Asignatura: ' || taulaNotes(i).asignatura);
    DBMS_OUTPUT.PUT_LINE('Nota: ' || taulaNotes(i).nota);
    i:=i+1;
END LOOP;
END;


/*5.4*/
SELECT E.nif, E.nom, E.notaMitjana() AS NotaMitjana FROM TaulaEstudiants E ORDER BY E.notaMitjana() DESC;

/*5.5*/
DECLARE
taulaNotes Notes_NT;
BEGIN
SELECT NOTES INTO taulaNotes FROM taulaestudiants WHERE nom = 'Laia Caparrós'; 
taulaNotes.EXTEND();
taulaNotes(taulaNotes.COUNT()):=Nota_T(9, 'Química');
UPDATE TaulaEstudiants SET notes = taulaNotes WHERE nom = 'Laia Caparrós'; 
END;

/*5.6*/
UPDATE TABLE(SELECT notes FROM TaulaEstudiants WHERE nom = 'Eugeni Torrent') E SET E.nota = 5.0 WHERE E.asignatura = 'Tecnologia';

/*5.7*/
UPDATE TaulaEstudiants SET institut = (SELECT REF(P) FROM TaulaInstituts P WHERE P.codi = 222) WHERE NIF = '39333111X';
UPDATE TaulaEstudiants SET notes = NULL WHERE NIF = '39333111X';

/*5.8*/
UPDATE TaulaEstudiants SET AficioPreferida = AficioMusical_T('Ha deixat la pintura per saxofon', 8, 'saxofon') WHERE NIF = '21121144D'; 

