SET search_path TO TP3;

INSERT INTO Constructeur(NomCompagnie, TypeConstructeur, Pays) VALUES
('Boeing Co', 'Avionneur', 'USA'),
('Bombardier Aero', 'Avionneur','Canada'),
('Airbus Industries', 'Avionneur', 'France'),
('General Electric', 'Motoriste', 'USA'),
('Pratt & Whitney', 'Motoriste', 'USA'),
('Rolls Royce', 'Motoriste', 'Angleterre')
;

INSERT INTO Avion(Modele, ConstructeurID, NbMoteurs, NbSieges) VALUES
('B747-400', 1, 4, 420),
('B757-200', 1, 2, 243),
('B727'    , 1, 2, 160),
('A340-600', 3, 2, 380),
('A340-500', 3, 2, 313),
('A330-300', 3, 2, 362),
('A330-200', 3, 2, 363),
('A310-300', 3, 2, 259)
;

INSERT INTO Moteur(Modele, ConstructeurID, Diametre, Longueur, Poids, Poussee) VALUES
('CF34-10D',    4, 57,  90,   3800, 18500),
('CF34-3A',     4, 49,  103,  1625, 9220),
('CF34-8C1',    4, 52,  128,  2350, 13790),
('CF6-50C1',    4, 105, 183,  8966, 52500),
('CF6-80E1A4',  4, 106, 168,  9790, 68100),
('RB211-524G',  6, 110, 150,  9100, 58000),
('RB211-535E4', 6, 110, 150,  9100, 40100),
('TRENT556',    6, 97,  145,  8900, 56000),
('TRENT553',    6, 97,  145,  8900, 53000),
('PW400-100',   5, 100, 163,  9200, 64500),
('JT9D',        5, 93,  132,  8900, 56000)
;

INSERT INTO Flotte(NoSerieAvion, NoSerieMoteur, MoteurID, AvionID,
                   Vitesse, Autonomie, DateService, HeuresVol, DateRetrait) VALUES
('1358D', 'S L120-8', 1, 2, 890, 34.5, '1982-12-04', 2300, '2006-10-17'),
('2945F', 'pw340-A',  2, 5, 850, 43.1, '1994-04-12', 4500, NULL)
;
