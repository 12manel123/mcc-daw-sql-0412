SET SERVEROUTPUT ON;
/*---------------------------------------------------------------------EX 1---------------------------------------------------------------------*/
DROP TYPE Adreça_T;
DROP TYPE Empleat_T;
DROP TYPE Telefons_T;
DROP TABLE TaulaEmpleats;

CREATE OR REPLACE TYPE Adreça_T AS OBJECT (
    carrer varchar2(200),
    numero number(3),
    poblacio varchar2(120),
    codiPostal number(6)
);

CREATE OR REPLACE TYPE Empleat_T AS OBJECT (
    nif varchar2(9),
    nom varchar2(40),
    dataNaixement DATE,
    sou number(6),
    adreça Adreça_T,
    cap REF Empleat_T
);

CREATE TABLE TaulaEmpleats OF Empleat_T (
    PRIMARY KEY (nif)
);


INSERT INTO TaulaEmpleats VALUES(Empleat_T('38234567A', 'Josep Verdú Bargalló', TO_DATE('12/12/1973'), 4500, Adreça_T('Estanislau Figueres', 25, 'Tarragona', 43002), NULL)); 
INSERT INTO TaulaEmpleats VALUES(Empleat_T('39311345X', 'Pere Garcia Llorens', TO_DATE('05/07/1980'), 100, Adreça_T('Blanca dAnjou', 45, 'Tarragona', 43007),(SELECT REF(P) FROM TaulaEmpleats P WHERE P.nif = '38234567A')));
SELECT * FROM TaulaEmpleats;
SELECT TREAT(VALUE(E) AS Empleat_T).nif AS Nif FROM TaulaEmpleats E;
SELECT TREAT(VALUE(E) AS Empleat_T).nif FROM TaulaEmpleats E WHERE TREAT(VALUE(E) AS Empleat_T).nif LIKE '38234567A';
/*---------------------------------------------------------------------EX 2---------------------------------------------------------------------*/
DROP TABLE TaulaEmpleats;

CREATE OR REPLACE TYPE Telefons_T is VARRAY(5) of varchar2(10);

CREATE OR REPLACE TYPE Empleat2_T AS OBJECT (
    nif varchar2(9),
    nom varchar2(40),
    dataNaixement DATE,
    sou number(6),
    adreça Adreça_T,
    cap REF Empleat2_T,
    telefon Telefons_T,
    MEMBER PROCEDURE afegirTelefon(noutelefon varchar2), /*Se tienen que definir después en el TYPE BODY*/
    MEMBER PROCEDURE modificarTelefon(oldtelefon varchar2, noutelefon varchar2)
);

CREATE TABLE TaulaEmpleats OF Empleat2_T (
    PRIMARY KEY (nif)
);

DROP TABLE TaulaEmpleats;
SELECT * FROM TaulaEmpleats;
INSERT INTO TaulaEmpleats VALUES('38234567A', 'Josep Verdú Bargalló', TO_DATE('12/12/1973'), 4500, Adreça_T('Estanislau Figueres', 25, 'Tarragona', 43002), NULL, Telefons_T());
INSERT INTO TaulaEmpleats VALUES(Empleat2_T('39311345X', 'Pere Garcia Llorens', TO_DATE('05/07/1980'), 100, Adreça_T('Blanca dAnjou', 45, 'Tarragona', 43007),(SELECT REF(P) FROM TaulaEmpleats P WHERE P.nif = '38234567A'), Telefons_T()));
/*Enseño de que funciona de ambas manera*/
/*---------------------------------------------------------------------EX 3---------------------------------------------------------------------*/
CREATE OR REPLACE TYPE BODY Empleat2_T AS
MEMBER PROCEDURE afegirTelefon(noutelefon varchar2) AS 
taula_af Telefons_T;
numero number(10);
BEGIN
SELECT telefon INTO taula_af FROM TaulaEmpleats WHERE nif=SELF.nif;
numero:=taula_af.COUNT;
taula_af.EXTEND;
taula_af(numero+1):=noutelefon;
UPDATE TaulaEmpleats SET telefon = taula_af WHERE nif=SELF.nif;
END afegirTelefon;

MEMBER PROCEDURE modificarTelefon(oldtelefon in varchar2, noutelefon in varchar2) as 
taula_af telefons_T;
i number(5);
fi boolean;
BEGIN
  SELECT telefon into taula_af FROM TaulaEmpleats WHERE nif=SELF.nif;
  i:=1;
  fi:=false;
  WHILE (i<=taula_af.COUNT AND NOT fi) 
  LOOP
    IF (taula_af(i) = oldtelefon) THEN
      taula_af(i):=noutelefon;
      fi:=true;
    END IF;
    i:=i+1;
  END LOOP;
  UPDATE TaulaEmpleats SET telefon=taula_af WHERE nif=SELF.nif;
END modificarTelefon;
END;

DECLARE
empleat Empleat2_T;
BEGIN
SELECT VALUE(E) INTO empleat FROM TaulaEmpleats E WHERE E.nif = '39311345X';
empleat.afegirTelefon('659312111');
END;

DECLARE
empleat Empleat2_T;
BEGIN
SELECT VALUE(E) INTO empleat FROM TaulaEmpleats E WHERE E.nif = '39311345X';
empleat.modificarTelefon('659312111', '659312117');
END;
/*---------------------------------------------------------------------EX 4---------------------------------------------------------------------*/
/*CREATE OR REPLACE TYPE Adreces_T AS TABLE OF Adreça_T;*/
DROP TABLE TaulaEmpleats;
DROP TYPE Adreces_T;
DROP TYPE Empleat3_T;
SELECT * FROM TaulaEmpleats;
CREATE OR REPLACE TYPE Adreces_T AS OBJECT (
    carrer varchar2(200),
    numero number(3),
    poblacio varchar2(120),
    codiPostal number(6)
);
CREATE OR REPLACE TYPE Empleat3_T AS OBJECT (
    nif varchar2(9),
    nom varchar2(40),
    dataNaixement DATE,
    sou number(6),
    adreces Adreces_T,
    cap REF Empleat3_T,
    telefon Telefons_T,
    constructor function Empleat3_T(nif varchar2, nom varchar2, dataNaixement date) return SELF as RESULT,
    constructor function Empleat3_T(nif varchar2, nom varchar2, dataNaixement date, sou number) return SELF as RESULT,
    MEMBER PROCEDURE afegirTelefon(noutelefon varchar2), /*Se tienen que definir después en el TYPE BODY*/
    MEMBER PROCEDURE modificarTelefon(oldtelefon varchar2, noutelefon varchar2),
    MAP MEMBER FUNCTION toCompare RETURN number,
    STATIC PROCEDURE inserir(empleat Empleat3_T),
    MEMBER PROCEDURE visualitzaEmpleat
);

CREATE TABLE TaulaEmpleats of Empleat3_T (
    PRIMARY KEY(nif)
);

CREATE OR REPLACE TYPE BODY Empleat3_T AS
/*                                  ---constructores---                                     */
constructor function Empleat3_T(nif varchar2, nom varchar2, dataNaixement date) return SELF as RESULT is
begin
SELF.nif:=nif;
SELF.nom:=nom;
SELF.dataNaixement:=dataNaixement;
SELF.sou:=0;
return;
end Empleat3_T;
constructor function Empleat3_T(nif varchar2, nom varchar2, dataNaixement date, sou number) return SELF as RESULT is
begin
SELF.nif:=nif;
SELF.nom:=nom;
SELF.dataNaixement:=dataNaixement;
SELF.sou:=sou;
return;
end Empleat3_T;
/*                                  ---funciones/procedimientos---                                     */
MAP MEMBER FUNCTION toCompare RETURN number AS
BEGIN
    RETURN (SYSDATE-SELF.dataNaixement)/365;
END toCompare;
STATIC PROCEDURE inserir(empleat Empleat3_T) AS
BEGIN
    INSERT INTO TaulaEmpleats VALUES(empleat);
END inserir;
MEMBER PROCEDURE visualitzaEmpleat AS
elCap varchar2(40);
BEGIN
    DBMS_OUTPUT.PUT_LINE('NIF: ' || SELF.nif);
    DBMS_OUTPUT.PUT_LINE('Nom: ' || SELF.nom);
    IF (cap IS NOT NULL) THEN
    SELECT b.nom INTO elCap FROM TaulaEmpleats a INNER JOIN TaulaEmpleats b ON b.nif = a.cap.nif WHERE a.nif = '39311345X';
    DBMS_OUTPUT.PUT_LINE('Cap: ' || elCap); /*no se puede buscar las variables de una referencia, pero por alguna razón me deja hacer esto, asi que bueno..*/
    END IF;
    /*adreçes*/
END visualitzaEmpleat;
MEMBER PROCEDURE afegirTelefon(noutelefon varchar2) AS 
taula_af Telefons_T;
numero number(10);
BEGIN
SELECT telefon INTO taula_af FROM TaulaEmpleats WHERE nif=SELF.nif;
numero:=taula_af.COUNT;
taula_af.EXTEND;
taula_af(numero+1):=noutelefon;
UPDATE TaulaEmpleats SET telefon = taula_af WHERE nif=SELF.nif;
END afegirTelefon;

MEMBER PROCEDURE modificarTelefon(oldtelefon in varchar2, noutelefon in varchar2) as 
taula_af telefons_T;
i number(5);
fi boolean;
BEGIN
  SELECT telefon into taula_af FROM TaulaEmpleats WHERE nif=SELF.nif;
  i:=1;
  fi:=false;
  WHILE (i<=taula_af.COUNT AND NOT fi) 
  LOOP
    IF (taula_af(i) = oldtelefon) THEN
      taula_af(i):=noutelefon;
      fi:=true;
    END IF;
    i:=i+1;
  END LOOP;
  UPDATE TaulaEmpleats SET telefon=taula_af WHERE nif=SELF.nif;
END modificarTelefon;
END;

INSERT INTO TaulaEmpleats VALUES('38234567A', 'Josep Verdú Bargalló', TO_DATE('12/12/1973'), 4500, NULL, NULL, Telefons_T());
INSERT INTO TaulaEmpleats VALUES(Empleat3_T('39311345X', 'Pere Garcia Llorens', TO_DATE('05/07/1980'), 100, NULL,(SELECT REF(P) FROM TaulaEmpleats P WHERE P.nif = '38234567A'), Telefons_T()));

DECLARE
empleat Empleat3_T;
BEGIN
    SELECT VALUE(E) INTO empleat FROM TaulaEmpleats E WHERE E.nif = '39311345X';
    empleat.visualitzaEmpleat();
END;

/*una prueba*/
DECLARE
emp1 Empleat3_T;
emp2 Empleat3_T;
BEGIN
    SELECT VALUE(E) INTO emp1 FROM TaulaEmpleats E WHERE E.nif = '38234567A';
    SELECT VALUE(E) INTO emp2 FROM TaulaEmpleats E WHERE E.nif = '39311345X';
    IF (emp1 > emp2) THEN
        DBMS_OUTPUT.PUT_LINE('Emp1 es més gran');
    ELSIF (emp2 > emp1) THEN
        DBMS_OUTPUT.PUT_LINE('Emp2 es més gran');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Emp3 es més gran');
    END IF;
END;







