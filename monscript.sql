BEGIN
	DBMS_OUTPUT.PUT_LINE('Bonjour');
END;
DECLARE
   SUBTYPE name IS char(20);
   SUBTYPE message IS varchar2(100);
	salutation name;
	greetings message;
BEGIN
 	salutation := 'Reader';
	greetings:= 'Welcome to the World of PL/SQL';
	dbms_output.put_line('Hello'||salutation||greetings);
END;



DECLARE 
     a INTEGER := 10;  --declaration et initialisation
     b INTEGER := 20;
     c INTEGER;
     f REAL;

BEGIN 
	C := a+b;
	dbms_output.put_line('Value of c:'||c);
	f:= 70.0/3.0;
	dbms_output.put_line('Value of f :'||f);
END;



DECLARE 
PROCEDURE compare(value varchar2, pattern varchar2) is
BEGIN
	IF value LIKE pattern THEN
		dbms_output.put_line('True');
	ELSE
		dbms_output.put_line('False');
	END IF;
END;
BEGIN
	compare('Zara Ali','Z%A_i');
	compare('Nuha Ali','Z%A_i');
END;



DECLARE 
	i NUMBER(1);
	j NUMBER(1);
BEGIN
	<<outer_loop>> -- Labelisation de boucle
	FOR i IN 1..3 LOOP
   	 <<inner_loop>> -- Labelisation de boucle
   	 FOR j IN 1..3 LOOP
	dbms_output.put_line('i is:'||i||'and j is:'||j);
	END loop inner_loop;
END loop outer_loop;
END;


DECLARE 
    type namesarray is VARRAY(5) OF VARCHAR2(10);
    type grades is VARRAY(5) OF INTEGER;
    names namesarray;
    marks grades;
    total integer;
BEGIN
    names:= namesarray('Kavita','Pritam','Ayan','Rishav','Aziz');
    marks := grades(98,97,78,87,92);
    total:= names.count;
    dbms_output.put_line('Total'||total||'Students');
    FOR I in 1.. total LOOP
		dbms_output.put_line('Student:'||names(i)||'Marks:'||
marks(i));
END LOOP;
END;


-- Creation de procedure
CREATE OR REPLACE PROCEDURE ditbonjour AS
BEGIN
 	dbms_output.put_line('Bonjour !');
END;

EXEC ditbonjour; --Exécution de la procedure 

EXECUTE ditbonjour; --Exécution de la procedure 

--Exécution de la procedure 
BEGIN
	ditbonjour;
END;


DECLARE
    a number;
    b number;
    c number;
PROCEDURE findMin(x IN number, y IN number, z OUT number) IS
BEGIN
    IF x < y THEN
    z:=x;
ELSE
	z:=y;	
END IF;
END;
BEGIN
	a:=23;
	b:=45;
	findMin(a,b,c);
	dbms_output.put_line('Minimum de (23, 45):'||c);
END;


CREATE TABLE customers
( 
    ID INT,
    NAME VARCHAR(50),
    AGE INT,
    ADDRESS VARCHAR(100),
  	SALARY DECIMAL(10, 2)
);

--Intertion des données
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (1, 'THIERRY', 26, 'Some Address', 2000.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (2, 'Marie', 30, '123 Main St', 2500.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (3, 'Jean', 35, '456 Oak St', 3000.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (4, 'Sophie', 28, '789 Pine St', 2800.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (5, 'Pierre', 32, '101 Elm St', 3200.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (6, 'Isabelle', 27, '202 Birch St', 2700.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (7, 'Luc', 40, '303 Maple St', 3500.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (8, 'Céline', 33, '404 Cedar St', 3100.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (9, 'François', 29, '505 Walnut St', 2600.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (10, 'Aurélie', 31, '606 Pine St', 3300.00);
INSERT INTO customers (ID, NAME, AGE, ADDRESS, SALARY) VALUES (11, 'Michel', 36, '707 Oak St', 2900.00);


CREATE OR REPLACE FUNCTION totalCustomers
RETURN number IS
	total number(2):=0;
BEGIN
	SELECT count(*) into total
	FROM customers;
RETURN total;
END;

DECLARE
	c number(2);
BEGIN
    c := totalCustomers();
    dbms_output.put_line('Total no. of Customers: ' || c);
END;


-- Create the AdresseType table
CREATE TABLE AdresseType (
    ID INT,
    Rue VARCHAR2(255),
    Ville VARCHAR2(255),
    CodePostal VARCHAR2(10),
    Pays VARCHAR2(255)
);

-- Insert data into the AdresseType table
INSERT INTO AdresseType (ID, Rue, Ville, CodePostal, Pays)
VALUES (1, 'Avenue des Champs-Élysées', 'Paris', '75008', 'France');

-- Create or replace the AfficherAdresse function
CREATE OR REPLACE FUNCTION AfficherAdresse
RETURN VARCHAR2 IS
    v_address VARCHAR2(4000);
BEGIN
    SELECT 'Adresse : ' || Rue || CHR(13) ||
           'Ville : ' || Ville || CHR(13) ||
           'Code Postal : ' || CodePostal || CHR(13) ||
           'Pays : ' || Pays
    INTO v_address
    FROM AdresseType
    WHERE ID = 1; -- Assuming you want to display the address for a specific ID

    RETURN v_address;
END;

-- Utilisation de la fonction 
DECLARE
    c VARCHAR2(4000);
BEGIN
    c := AfficherAdresse();
    dbms_output.put_line('Adresse: ' || c);
END;



CREATE OR REPLACE TYPE AdresseType AS OBJECT (
   Rue VARCHAR2(50),
   Ville VARCHAR2(100),
   CodePostal VARCHAR2(20),
   Pays VARCHAR2(30),
   -- Méthode Afficher Adresse
   MEMBER FUNCTION AfficherAdresse RETURN VARCHAR2
);


CREATE OR REPLACE TYPE BODY AdresseType AS
   MEMBER FUNCTION AfficherAdresse RETURN VARCHAR2 IS
   BEGIN
      RETURN Rue || ' ' || Ville || ', ' || CodePostal || ', ' || Pays;
   END AfficherAdresse;
END;


-- Création de la table Personne
CREATE TABLE Personne (
   ID NUMBER,
   Nom VARCHAR2(50),
   Prenom VARCHAR2(50),
   DateNaissance DATE,
   Adresse AdresseType
);
-- Exemple d'insertion d'enregistrements dans la table Personne en utilisant le type AdresseType
INSERT INTO Personne VALUES (1, 'Dupont', 'Sophie', TO_DATE('1995/08/18', 'YYYY-MM-DD'), 
    AdresseType('15', 'Avenue des Acacias', '69002', 'Lyon'));
INSERT INTO Personne VALUES (2, 'Martin', 'Pierre', TO_DATE('1980/06/30', 'YYYY-MM-DD'), 
    AdresseType('28', 'Boulevard Saint-Michel', '13006', 'Marseille'));
INSERT INTO Personne VALUES (3, 'Lefevre', 'Julie', TO_DATE('1992/03/15', 'YYYY-MM-DD'), 
    AdresseType('8', 'Rue des Lilas', '31000', 'Toulouse'));
INSERT INTO Personne VALUES (4, 'Garcia', 'Antoine', TO_DATE('1985/11/22', 'YYYY-MM-DD'), 
    AdresseType('72', 'Avenue de la Libération', '33000', 'Bordeaux'));
INSERT INTO Personne VALUES (5, 'Leroux', 'Catherine', TO_DATE('1977/09/07', 'YYYY-MM-DD'), 
    AdresseType('19', 'Chemin des Oliviers', '06000', 'Nice'));
INSERT INTO Personne VALUES (6, 'Moulin', 'Thomas', TO_DATE('1998/01/12', 'YYYY-MM-DD'), 
    AdresseType('3', 'Rue Victor Hugo', '54000', 'Nancy'));
INSERT INTO Personne VALUES (7, 'Leclerc', 'Marie', TO_DATE('1990/07/05', 'YYYY-MM-DD'), 
    AdresseType('42', 'Avenue des Roses', '21000', 'Dijon'));
INSERT INTO Personne VALUES (8, 'Marchand', 'Luc', TO_DATE('1982/04/28', 'YYYY-MM-DD'), 
    AdresseType('55', 'Rue de la Paix', '59000', 'Lille'));
INSERT INTO Personne VALUES (9, 'Bertrand', 'Elise', TO_DATE('1993/12/10', 'YYYY-MM-DD'), 
    AdresseType('10', 'Place de la République', '67000', 'Strasbourg'));


-- Affichage du résultat
DECLARE
    -- Déclaration d'une variable de type AdresseType
    v_adresse AdresseType;
BEGIN
    -- Sélection de l'adresse insérée dans la variable v_adresse
    SELECT Adresse INTO v_adresse FROM Personne WHERE ID = 5;

    -- Affichage du résultat
    DBMS_OUTPUT.PUT_LINE('Adresse insérée : ' || v_adresse.Rue || ', 
    ' || v_adresse.Ville || ', ' || v_adresse.CodePostal || ', ' || v_adresse.Pays);
END;






SET SERVEROUTPUT ON;

DECLARE
    v_number INT;
BEGIN
    dbms_output.put_line('Les 10 premiers nombres sont :');
    
    FOR i IN 1..5 LOOP
        -- Calculate the even number
        v_number := i * 2;

        -- Display the even number
        dbms_output.put_line(v_number);
    END LOOP;
    
    -- Check if 10 is even or odd separately
    IF MOD(10, 2) = 0 THEN
        dbms_output.put_line('Le numéro 10 est pair');
    ELSE
        dbms_output.put_line('Le numéro 10 est impair');
    END IF;
END;




SET SERVEROUTPUT ON;

-- Étape 1: Création du type objet cercle
CREATE TYPE CircleType AS OBJECT (
    centre_x NUMBER,
    centre_y NUMBER,
    rayon NUMBER,

    -- Méthode pour afficher les attributs du cercle
    MEMBER PROCEDURE afficher,
    
    -- Méthode pour agrandir le cercle
    MEMBER PROCEDURE agrandir(p_valeur NUMBER),

    -- Méthode pour comparer les tailles des cercles
    MEMBER FUNCTION estPlusGrandQue(cercle_autre CircleType) RETURN BOOLEAN
);


-- Étape 2: Implémentation des méthodes
CREATE TYPE BODY CircleType AS
    -- Méthode pour afficher les attributs du cercle
    MEMBER PROCEDURE afficher IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Centre: (' || centre_x || ', ' || centre_y || '), Rayon: ' || rayon);
    END afficher;

    -- Méthode pour agrandir le cercle
    MEMBER PROCEDURE agrandir(p_valeur NUMBER) IS
    BEGIN
        rayon := rayon + p_valeur;
    END agrandir;

    -- Méthode pour comparer les tailles des cercles
    MEMBER FUNCTION estPlusGrandQue(cercle_autre CircleType) RETURN BOOLEAN IS
    BEGIN
        RETURN rayon > cercle_autre.rayon;
    END estPlusGrandQue;
END;

-- Étape 3: Création d'instances de cercle
DECLARE
    -- Créer deux instances de cercle
    cercle1 CircleType := CircleType(0, 0, 5);
    cercle2 CircleType := CircleType(0, 0, 2);
BEGIN
    -- Étape 4: Manipulation des instances
   
    cercle1.afficher;
    cercle2.afficher;

    -- Agrandir le rayon du premier cercle
    cercle1.agrandir(3);
    cercle1.afficher;
    cercle2.afficher;

    -- Étape 5: Bonus - Comparaison des cercles
    -- Comparer les tailles des cercles
    IF cercle1.estPlusGrandQue(cercle2) THEN
        DBMS_OUTPUT.PUT_LINE('Le cercle 1 est plus grand que le cercle 2.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Le cercle 2 est plus grand que le cercle 1.');
    END IF;
END;



-- DROP TABLE AdresseType;
-- DROP TABLE Personne;


