--------------------------PAG1---------------------------
/*
CREATE TABLE Persones(
nif varchar2(9) PRIMARY KEY,
nom varchar2(30),
cognoms varchar2(30),
adreça varchar2(30)
);

CREATE TABLE Departaments(
codi varchar2(5),
nomdep varchar2(40),
PRIMARY KEY (codi)
);

CREATE TABLE Empleats(
nif varchar2(9) REFERENCES Persones PRIMARY KEY,
sou number(6),
tipus_empleat varchar2(20),
departament varchar2(5),
PRIMARY KEY (nif,sou)
);

CREATE TABLE Estudiants(
    nif varchar2(9),
    curs varchar2(10),
    estudis varchar2(50),
    PRIMARY KEY (nif),
    FOREIGN KEY (nif) REFERENCES Persones
);
--------------------------PAG2---------------------------
CREATE TABLE Materies(
    titolacio varchar2(5),
    codimat varchar2(5),
    descripcio varchar2(256),
    credits number(2),
    PRIMARY KEY (titolacio,codimat)
);
--------------------------PAG3---------------------------

insert into Cursos values 
('0101','Bases de dades Ob-Rel',null,Persona_T('39292946A','Joan'));

insert into Cursos values 
('0101','Bases de dades Ob-Rel',null,new Persona_T('39292946A','Joan'));

insert into Cursos values 
('0101','Bases de dades Ob-Rel',null,'39292946A','Joan');

update Cursos C set C.professor.nom='Joan' where C.professor.nif='39292946A';



drop table materies;
drop table estudiants;
drop table empleats;
drop table departaments;
drop table persones;
------------------------FIN ACT1----------------------------------


CREATE TYPE Persona_T as OBJECT(
nif varchar2(9),
nom varchar2(120)
);
CREATE TABLE Cursos(
id_curs varchar2(9),
nom varchar2(120),
descrip varchar2(1024),
professor Persona_T
);


-----------------------------------------------------------------
insert into Cursos values('0101','Bases de dades Objeto-Relacional',null,Persona_T('39555421A','Joan Verdú'));
insert into Cursos values('0101','Bases de dades Objeto-Relacional',null, new Persona_T('39555421A','Joan Verdú'));

insert into Cursos values('0101','Bases de dades Objeto-Relacional',null,'39555421A','Joan Verdú');

update Cursos C set C.professor.nom = 'Juan Verdú' where  C.professor.nif='39555421A';

insert into Cursos values('0007','Programació elemental amb JavaFX','GUI''s elementals',null);

update Cursos set professor = Persona_T('18123759X','Manuel Rivas') where id_curs='0007';

insert into Cursos values('0102','Programació en PL/SQL',null,Persona_T('39555421A','Juan Verdú'));

delete from Cursos C where C.professor.nif like '18%';

CREATE TABLE Persones OF Persona_T;

insert into Persones values('39222277W','Casimiro Miró');
insert into Persones values(Persona_T('25111259R','Ana Mohedano'));
insert into Persones values(Persona_T('39222277W','Pilar Esteve'));

alter table Persones add primary key (nif);

CREATE TABLE Persones of Persona_T
(
primary key (nif)
);
insert into Persones values(Persona_T('39222277W','Pilar Esteve'));

--------------------Taules Objectes herencia i polimorfisme----------------------------

CREATE TYPE Estudiant_T as OBJECT(
    nif varchar2(9),
    estudis varchar2(40),
    curs number(2)
);
CREATE TYPE Professor_T as OBJECT(
    nif varchar2(9),
    titol varchar2(60)
);
CREATE TABLE Estudiants of Estudiant_T(
    primary key(nif),
    foreign key (nif) references Persones
);
CREATE TABLE Professors of Professor_T(
    primary key(nif),
    foreign key (nif) references Persones
);

insert into Estudiants values(Estudiant_T('39672153B','ASIX',2));

insert into Persones values(Persona_T('39672153B','Roger Benaiges'));
insert into Estudiants values(Estudiant_T('39672153B','ASIX',2));

Drop table Estudiants;
Drop table Professors;
Drop type Estudiant_T;
Drop type Professor_T;

alter type Persona_T not final cascade;
--------------------------------ACT01------------------------------

CREATE TYPE Empleat as OBJECT(
    nif varchar2(9),
    nom varchar2(40),
    telefon number(9)
) NOT FINAL;

CREATE TYPE Programador under Empleat(
llista_coneguts varchar2(120)
);
CREATE TYPE Comercial under Empleat(
ciutat varchar2(120),
llista_venuts varchar2(120),
inport number(20)
);

CREATE TABLE Empleats of Empleat(
primary key (nif)
);

insert into Empleats values(Empleat('39222174X','Pepe Tapies','659333123'));
insert into Empleats values(Programador('39111274S','Nuria Verdu','658111222','C,Modula,Java'));
insert into Empleats values(Comercial('32777444A','Pere gavalda','659731123','Tarragona','Rentadora,Microondes',650));
insert into Empleats values(Comercial('34777222L','Meritxell Rovira','659731390','Barcelona','Aiguera',65));
SELECT * from Empleats order by nom;
SELECT nif,nom,TREAT(VALUE(P) AS Programador).llista_coneguts from Empleats P where value(P)is of (ONLY Programador);
SELECT nom,TREAT(VALUE(P) AS Comercial).llista_venuts,TREAT(VALUE(P) AS Comercial).inport from Empleats P where value(P)is of (ONLY Comercial) ORDER BY TREAT(VALUE(P) AS Comercial).inport DESC;
delete from Empleats where TREAT(VALUE(P) AS Comercial).inport <=100;

*/
-------------------------------------------------------------------Ex1-------------------------------------------------------------------

CREATE or replace TYPE Adreça_T as OBJECT(
    carrer varchar2(80),
    numero number(9),
    poblacio varchar2(80),
    postal number(5)
);

CREATE or replace TYPE Empleat_T as OBJECT(
    nif  varchar2(9),
    nom varchar2(80),
    adreça Adreça_T,
    data_naix date,
    sou number(9),
    cap ref Empleat_T
);
CREATE TABLE TaulaEmpleats of Empleat2_T(
    primary key(nif)
);
DROP TABLE TaulaEmpleats;
INSERT INTO TaulaEmpleats values('38234567A','Josep Verdú Bargalló',Adreça_T('Estanislau Figueres',25,'Tarragona',43002),to_date('12/12/1973'),4500,null);
INSERT INTO TaulaEmpleats values('39311345X','Pere Garcia LLorens',Adreça_T('Blanca de Anjou',45,'Tarragona',43007),to_date('05/07/1980'),1000,(select REF(P)from TaulaEmpleats P where nif='38234567A'));
SELECT * FROM TaulaEmpleats;
-----------------------------------------EX2-----------------------------------
CREATE TYPE Telefons_T is VARRAY(5) of number(9);

CREATE OR REPLACE TYPE Empleat2_T  as OBJECT
(
    nif  varchar2(9),
    nom varchar2(80),
    adreça Adreça_T,
    data_naix date,
    sou number(9),
    cap ref Empleat2_T,
    telefons Telefons_T,
    member procedure afegirTelefon(telefon number), 
    member procedure modificarTelefon(telefon number,telefonnou number)
);

DROP TABLE Taulaempleats;

CREATE TABLE TaulaEmpleats of Empleat2_T;

INSERT INTO TaulaEmpleats values('38234567A','Josep Verdú Bargalló',Adreça_T('Estanislau Figueres',25,'Tarragona',43002),to_date('12/12/1973'),4500,null,Telefons_T());
INSERT INTO TaulaEmpleats values('39311345X','Pere Garcia LLorens',Adreça_T('Blanca de Anjou',45,'Tarragona',43007),to_date('05/07/1980'),1000,(select REF(P)from TaulaEmpleats P where nif='38234567A'),Telefons_T());
SELECT * FROM TaulaEmpleats;


--------------------------------------------------------------------------------------EX3--------------------------------------

CREATE OR REPLACE TYPE BODY Empleat2_T as
MEMBER PROCEDURE afegirTelefon(telefon number) as 
    
        taula_af Telefons_T;
        numero number(9);
        
        begin
            select telefons into taula_af from TaulaEmpleats where nif=SELF.nif;
            numero:= taula_af.COUNT;
            taula_af.EXTEND;
            taula_af(numero+1):=telefon;
            update TaulaEmpleats set telefons=taula_af where nif=SELF.nif;  
        end afegirTelefon;
        
    
    MEMBER PROCEDURE modificarTelefon(telefon number,telefonnou number) as 
    
        taula_af Telefons_T;
        i number;
        fi boolean;
        
        begin
            select telefons into taula_af from TaulaEmpleats where nif=SELF.nif;
            i:=1;
            fi:=false;
            while(i<=taula_af.COUNT and not fi) loop 
                if(taula_af(i) = telefon) then
                    taula_af(i):=telefonnou;
                    fi:=true;
                end if;
                i:=i+1;
            end loop;
            update TaulaEmpleats set telefons=taula_af where nif=SELF.nif;  
        end modificarTelefon;   
end;
    
    
    
    
    ------------------------------------------------------------------
    declare
    empleat Empleat2_T;
    begin
        select value(E) into empleat from TaulaEmpleats E where E.nif='38234567A';
        empleat.afegirTelefon('659312111');
    end;

-------------------------------
    declare
    empleat Empleat2_T;
    begin
        select value(E) into empleat from TaulaEmpleats E where E.nif='38234567A';
        empleat.modificarTelefon('659312111','669312111');
    end;

SELECT * FROM TaulaEmpleats;

------------------------------------------------------------------EX4----------------------------------------------


CREATE or replace TYPE Adreces_T as OBJECT(
    carrer varchar2(80),
    numero number(9),
    poblacio varchar2(80),
    postal number(5)
);


CREATE or replace TYPE Empleat3_T as OBJECT(
    nif  varchar2(9),
    nom varchar2(80),
    adreces Adreces_T,
    data_naix date,
    sou number(9),
    cap ref Empleat3_T,
    constructor function Empleat3_T(nif varchar2, nom varchar2, data_naix date) return SELF as RESULT,
    constructor function Empleat3_T(nif varchar2, nom varchar2, data_naix date, sou number) return SELF as RESULT,
    MEMBER PROCEDURE afegirTelefon(noutelefon varchar2),
    MEMBER PROCEDURE modificarTelefon(oldtelefon varchar2, noutelefon varchar2),
    MAP MEMBER FUNCTION toCompare RETURN number,
    STATIC PROCEDURE inserir(empleat Empleat3_T),
    MEMBER PROCEDURE visualitzaEmpleat
);




CREATE TABLE TaulaEmpleats of Empleat3_T;




--------------------------------------------
CREATE OR REPLACE TYPE body Empleat3_T as
constructor function Empleat3_T(nif varchar2, nom varchar2, data_naix date) return SELF as RESULT is
begin
SELF.nif:=nif;
SELF.nom:=nom;
SELF.data_naix :=data_naix;
SELF.sou:=0;
return;
end Empleat3_T;
constructor function Empleat3_T(nif varchar2, nom varchar2, data_naix date, sou number) return SELF as RESULT is
begin
SELF.nif:=nif;
SELF.nom:=nom;
SELF.data_naix :=data_naix;
SELF.sou:=sou;
return;
end Empleat3_T;


--------------------

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
    DBMS_OUTPUT.PUT_LINE('Cap: ' || elCap);
    END IF;
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

/*SERVER OUTPUT ON*/


INSERT INTO TaulaEmpleats VALUES('38234567A', 'Josep Verdú Bargalló', TO_DATE('12/12/1973'), 4500, NULL, NULL, Telefons_T());
INSERT INTO TaulaEmpleats VALUES(Empleat3_T('39311345X', 'Pere Garcia Llorens', TO_DATE('05/07/1980'), 100, NULL,(SELECT REF(P) FROM TaulaEmpleats P WHERE P.nif = '38234567A'), Telefons_T()));

DECLARE
empleat Empleat3_T;
BEGIN
    SELECT VALUE(E) INTO empleat FROM TaulaEmpleats E WHERE E.nif = '39311345X';
    empleat.visualitzaEmpleat();
END;


DECLARE
emp Empleat3_T;
emp2 Empleat3_T;
BEGIN
    SELECT VALUE(E) INTO emp FROM TaulaEmpleats E WHERE E.nif = '38234567A';
    SELECT VALUE(E) INTO emp2 FROM TaulaEmpleats E WHERE E.nif = '39311345X';
    IF (emp > emp2) THEN
        DBMS_OUTPUT.PUT_LINE('Emp es més gran');
    ELSIF (emp2 > emp) THEN
        DBMS_OUTPUT.PUT_LINE('Emp2 es més gran');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Emp3 es més gran');
    END IF;
END;


