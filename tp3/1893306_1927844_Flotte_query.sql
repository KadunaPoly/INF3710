SET search_path to tp3;


-- Retourne le nombre d'appareils produits par pays =>"(France,5)", "(USA,3)"
SELECT   (C.Pays, COUNT(A.ConstructeurID))
FROM     (Constructeur AS C JOIN Avion AS A ON A.ConstructeurID = C.ConstructeurID)
GROUP BY (C.Pays)
ORDER BY C.Pays ASC;

-- Retourne le nombre d'appareils produits par pays, dont le nombre de
-- siege est superieur a 200 => "(France,5)", "(USA,2)"
SELECT   (C.Pays, COUNT(A.ConstructeurID))
FROM     (Constructeur AS C NATURAL JOIN Avion AS A)
WHERE    (A.NbSieges > 200)
GROUP BY (C.Pays)
ORDER BY C.Pays ASC;

-- Retourne le modele, le nombre de sieges, le nombre d'heures
-- accumulees et la vitesse de chaque flotte



-- Retourner le modele, le nombre de siege et le nombre d'heures de
-- vole des avions encore en service  =>
-- "(A340-500,313,4500)"
SELECT (Modele, NbSieges, HeuresVol)
FROM   (Avion AS A JOIN Flotte AS F ON (A.AvionID = F.AvionID))
WHERE DateRetrait IS NULL;

-- Retourne le modele et le nom de la compagnie de tous les avions
-- qui ont plus de 300 sieges =>
-- "(B747-400,"Boeing Co")"
-- "(A340-600,"Airbus Industries")"
-- "(A340-500,"Airbus Industries")"
-- "(A330-300,"Airbus Industries")"
-- "(A330-200,"Airbus Industries")"
SELECT (A.Modele, C.NomCompagnie)
FROM   (Avion as A JOIN Constructeur as C ON (A.ConstructeurID = C.ConstructeurID) )
WHERE  (A.NbSieges > 300);

-- Retourne le nombre d'avion dont le nombre de siege est superieur a
-- la moyenne des sieges de tous les avions.  => 5
SELECT COUNT(*)
FROM   Avion
WHERE  NbSieges > (SELECT AVG(A.NbSieges)
                   FROM    Avion AS A);

-- Retourne la différence => 61
SELECT MAX(Diametre) - MIN(Diametre)
FROM   Moteur;
										
/*
DROP VIEW IF EXISTS Avion_Bombardier_Vue;
CREATE OR REPLACE VIEW Avion_Bombardier_Vue AS
SELECT C.NomCompagnie, COUNT(*)
FROM  Avion AS A NATURAL JOIN Constructeur AS C
WHERE C.NomCompagnie = 'Bombardier Aero'
GROUP BY M.Modele, C.NomCompagnie;
										
SELECT * FROM Avion_Bombardier_Vue;										
*/
								
-- Q11 =>
--1	"B747-400"	1	4	420--
--2	"B757-200"	1	2	243
--3	"B727"	1	2	160
--4	"B727"	1	2	160
DROP VIEW IF EXISTS Avion_Bombardier_Update_Check;									
CREATE VIEW Avion_Bombardier_Update_Check AS
SELECT *
FROM Avion
WHERE ConstructeurID = 1;		
SELECT * FROM Avion_Bombardier_Update_Check;										
										
-- Q12 => La table est vide
DROP VIEW IF EXISTS Avion_Bombardier_Update_Check;									
CREATE VIEW Avion_Bombardier_Update_Check AS
SELECT *
FROM Avion
WHERE ConstructeurID = 1;											
UPDATE Avion_Bombardier_Update_Check
SET	ConstructeurID = 2;
SELECT * FROM Avion_Bombardier_Update_Check;																				
										
										
-- Q13
-- ERROR:  new row violates check option for view "avion_bombardier_update_check"
-- DETAIL:  Failing row contains (1, B747-400, 2, 4, 420).
-- SQL state: 44000										
DROP VIEW IF EXISTS Avion_Bombardier_Update_Check;									
CREATE VIEW Avion_Bombardier_Update_Check AS
SELECT *
FROM Avion
WHERE ConstructeurID = 1
WITH CHECK OPTION;
UPDATE Avion_Bombardier_Update_Check
SET	ConstructeurID = 2;
SELECT * FROM Avion_Bombardier_Update_Check;											
										
