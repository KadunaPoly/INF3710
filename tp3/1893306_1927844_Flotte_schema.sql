SET search_path TO TP3;

DROP SCHEMA IF EXISTS TP3 CASCADE;
CREATE SCHEMA TP3;

CREATE TYPE ConstructeurTypeEnum AS ENUM('Motoriste', 'Avionneur', 'Systemes');

CREATE TABLE Constructeur(
       ConstructeurID   SERIAL	 		     PRIMARY KEY,
       NomCompagnie     VARCHAR(20)          NOT NULL,
       TypeConstructeur ConstructeurTypeEnum NOT NULL,
       Pays             VARCHAR(20)          NOT NULL
);

CREATE TABLE Avion(
       AvionID         SERIAL      PRIMARY KEY,
       Modele          VARCHAR(20) NOT NULL,
       ConstructeurID  INTEGER	   REFERENCES Constructeur(ConstructeurID),
       NbMoteurs       SMALLINT    NOT NULL,
       NbSieges        SMALLINT    NOT NULL
);

CREATE TABLE Moteur(
       MoteurID        SERIAL      PRIMARY KEY,
       Modele          VARCHAR(20) NOT NULL,
       ConstructeurID  INTEGER 	   REFERENCES Constructeur(ConstructeurID),
       Diametre        REAL         NOT NULL,
       Longueur        REAL         NOT NULL,
       Poids           REAL         NOT NULL,
       Poussee         REAL         NOT NULL
);


CREATE TABLE Flotte(
       NoSerieAvion    VARCHAR(20) NOT NULL,
       NoSerieMoteur   VARCHAR(20) NOT NULL,
       MoteurID        INTEGER REFERENCES Moteur,
       AvionID         INTEGER REFERENCES Avion,
       Vitesse         REAL     NOT NULL,
       Autonomie       REAL    NOT NULL,
       DateService     DATE    NOT NULL,
       HeuresVol       REAL    NOT NULL CHECK(HeuresVol > 0),
       DateRetrait     DATE    CHECK(DataRetrait >= DateService),

       PRIMARY KEY(NoSerieAvion, NoSerieMoteur)
);
