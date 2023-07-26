--CREAZIONE SCHEMA CON RELATIVO POPOLAMENTO

CREATE SCHEMA "OrtiScolastici";
--DROP SCHEMA IF EXISTS "OrtiScolastici" CASCADE;
SET search_path TO "OrtiScolastici";

CREATE TABLE Scuola(
	codiceMecc CHAR(10) PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	provincia CHAR(2) NOT NULL,
	ciclo VARCHAR(10) NOT NULL CHECK (ciclo IN ('primo','secondo')),
	aux CHAR(50)
);

INSERT INTO Scuola (codiceMecc, nome, provincia, ciclo, aux) VALUES
	('ABCD123456', 'Scuola Media Dante Alighieri', 'RM', 'primo', NULL),
	('EFGH987654', 'Scuola Media Leonardo da Vinci', 'MI', 'primo', NULL),
	('IJKL345678', 'Scuola Media Galileo Galilei', 'IM', 'primo', NULL),
	('MNOP987654', 'Scuola Media Marco Polo', 'FI', 'primo', NULL),
	('QRST123456', 'Scuola Media Guglielmo Marconi', 'TO', 'primo', NULL),
	('UVWX567890', 'Liceo Scientifico Albert Einstein', 'AV', 'secondo', NULL),
	('YZAB234567', 'Liceo Classico Dante Alighieri', 'MI', 'secondo', NULL),
	('CDEF678901', 'Liceo Linguistico Leonardo da Vinci', 'GE', 'secondo', NULL),
	('GHIJ345678', 'Liceo Artistico Michelangelo Buonarroti', 'FI', 'secondo', NULL),
	('LMNO901234', 'Istituto Tecnico ITIS Guglielmo Marconi', 'TO', 'secondo', NULL),
	('PQRS567890', 'Istituto Tecnico Industriale Thomas Edison', 'SV', 'secondo', NULL),
	('TUVW123456', 'Istituto Tecnico Agrario Antonio Vivaldi', 'MI', 'secondo', NULL),
	('XYZA789012', 'Istituto Professionale Enrico Fermi', 'NA', 'secondo', NULL),
	('BCDE234567', 'Istituto Professionale Giovanni Falcone', 'AL', 'secondo', NULL),
	('FGHI901234', 'Istituto Professionale Leonardo da Vinci', 'TO', 'secondo', NULL),
	('JKLM567890', 'Scuola Primaria Maria Montessori', 'RM', 'primo', NULL),
	('NOPQ123456', 'Scuola Primaria Giuseppe Garibaldi', 'GE', 'primo', NULL),
	('RSTU789012', 'Scuola Primaria Alessandro Volta', 'IM', 'primo', NULL),
	('VWXY234567', 'Scuola Primaria Antonio Gramsci', 'FI', 'primo', NULL),
	('DEFG567890', 'Scuola Primaria Giovanni Pascoli', 'VB', 'primo', NULL);


/*-----------------------------------------------------------------------*/
CREATE TABLE Classe(
	classe VARCHAR(5),
	codiceMecc CHAR(10) REFERENCES Scuola ON DELETE CASCADE ON UPDATE CASCADE,
	ordine VARCHAR(50) NOT NULL CHECK (ordine IN ('primaria','secondaria di primo grado','secondaria di secondo grado')),
	tipoScuola VARCHAR(50),
	emailResp VARCHAR(50) NOT NULL,
	PRIMARY KEY (classe, codiceMecc)
);

INSERT INTO Classe (classe, codiceMecc, ordine, tipoScuola, emailResp) VALUES
	('1A', 'ABCD123456', 'secondaria di primo grado', NULL, 'email1@example.com'),
	('2A', 'ABCD123456', 'secondaria di primo grado', NULL, 'email2@example.com'),
	('5F', 'TUVW123456', 'secondaria di secondo grado', 'tecnico agrario', 'email5@example.com'),
	('2B', 'EFGH987654', 'secondaria di primo grado', NULL, 'email8@example.com'),
	('1C', 'BCDE234567', 'secondaria di secondo grado', 'professionale', 'email9@example.com'),
	('4C', 'LMNO901234', 'secondaria di secondo grado', 'ITIS', 'email12@example.com'),
	('1D', 'NOPQ123456', 'primaria', NULL, 'email13@example.com'),
	('1D', 'UVWX567890', 'secondaria di secondo grado', 'liceo scientifico', 'email17@example.com'),
	('4C', 'CDEF678901', 'secondaria di secondo grado', 'liceo linguistico', 'email20@example.com'),
	('2D', 'VWXY234567', 'primaria', NULL, 'email21@example.com');


/*-----------------------------------------------------------------------*/
CREATE TABLE Partecipante(
	email VARCHAR(50) PRIMARY KEY,
	telefono CHAR(12),
	ruolo VARCHAR (30) NOT NULL CHECK (ruolo IN ('alunno','dirigente','docente','animatore digitale')),
	nome VARCHAR (30) NOT NULL,
	cognome VARCHAR (30) NOT NULL,
	referente BOOLEAN NOT NULL DEFAULT FALSE,
	classe VARCHAR(5),
	codiceMecc CHAR (10)  NOT NULL REFERENCES Scuola ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (classe,codiceMecc) REFERENCES Classe ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Partecipante (email, telefono, ruolo, nome, cognome, referente, classe, codiceMecc) VALUES
	('email195@example.com', '391234567890', 'alunno', 'John', 'Doe', FALSE, '1A', 'ABCD123456'),
	('email2@example.com', '391234567822', 'docente', 'Anna', 'Jones', TRUE, '2A', 'ABCD123456'),
	('email26@example.com', '392345678901', 'dirigente', 'Jane', 'Smith', FALSE, NULL, 'ABCD123456'),
	('email1@example.com', '393456789012', 'docente', 'Michael', 'Johnson', TRUE, NULL, 'ABCD123456'),
	('email1649@example.com', '394567890123', 'animatore digitale', 'Emily', 'Brown', FALSE, NULL, 'ABCD123456'),
	('email1167@example.com', '395678901234', 'alunno', 'Daniel', 'Davis', FALSE, '2B', 'EFGH987654'),
	('email8@example.com', '397890123456', 'docente', 'Sophia', 'Moore', TRUE, '2B', 'EFGH987654'),
	('email9891@example.com', '398901234567', 'animatore digitale', 'James', 'Anderson', FALSE, NULL, 'EFGH987654'),
	('email1235@example.com', '399012345678', 'alunno', 'Ethan', 'Thomas', FALSE, '5F', 'TUVW123456'),
	('email134@example.com', '395123456789', 'dirigente', 'Ava', 'Martinez', TRUE, NULL, 'TUVW123456'),
	('email5@example.com', '391234567890', 'docente', 'Isabella', 'Garcia', TRUE, NULL, 'TUVW123456'),
	('email9@example.com', '392345678901', 'docente', 'Noah', 'Lopez', TRUE, '1C', 'BCDE234567'),
	('email12@example.com', '393456789012', 'docente', 'Liam', 'Taylor', TRUE, '4C', 'LMNO901234'),
	('email1244@example.com', '393456789444', 'docente', 'Mia', 'Jones', FALSE, NULL, 'LMNO901234'),
	('email13@example.com', '394567890123', 'docente', 'Mia', 'Hernandez', TRUE, NULL, 'NOPQ123456'),
	('email17@example.com', '395678901234', 'docente', 'Charlotte', 'Clark', TRUE, NULL, 'UVWX567890'),
	('email20@example.com', '396789012345', 'docente', 'Benjamin', 'Lewis', TRUE, NULL, 'CDEF678901'),
	('email21@example.com', '397890123456', 'docente', 'William', 'Walker', TRUE, NULL, 'VWXY234567');

--ALTER TABLE Classe DROP CONSTRAINT classe_emailresp_fkey;
ALTER TABLE Classe ADD FOREIGN KEY (emailResp) REFERENCES Partecipante(email) ON UPDATE CASCADE;


/*-----------------------------------------------------------------------*/
CREATE TABLE Finanziamento (
	tipoFin VARCHAR(50),
	codiceMecc CHAR(10) REFERENCES Scuola ON UPDATE CASCADE,
	emailResp VARCHAR (50) NOT NULL REFERENCES Partecipante(email) ON UPDATE CASCADE,
	PRIMARY KEY (tipoFin, codiceMecc)
);

INSERT INTO Finanziamento (tipoFin, codiceMecc, emailResp) VALUES
	('PON EduGreen', 'ABCD123456', 'email1@example.com'),
	('Fondo scolastico', 'EFGH987654', 'email8@example.com'),
	('Sponsor privato', 'TUVW123456', 'email134@example.com'),
	('PON EduGreen', 'BCDE234567', 'email9@example.com'),
	('Fondo scolastico', 'LMNO901234', 'email12@example.com'),
	('Sponsor privato', 'NOPQ123456', 'email13@example.com'),
	('PON EduGreen', 'UVWX567890', 'email17@example.com'),
	('Fondo scolastico', 'CDEF678901', 'email20@example.com'),
	('Sponsor privato', 'VWXY234567', 'email21@example.com');


/*-----------------------------------------------------------------------*/
CREATE TABLE Orto (
	gps VARCHAR(22) PRIMARY KEY,
	tipo VARCHAR(30) NOT NULL CHECK (tipo IN ('campo','vaso')),
	condizione VARCHAR(30) NOT NULL CHECK (condizione IN ('biomonitoraggio sporco','biomonitoraggio pulito','fitobonifica')),
	nome VARCHAR(30) NOT NULL,
	superficie INT NOT NULL,
	nSensori INT NOT NULL,
	codiceMecc CHAR(10) NOT NULL REFERENCES Scuola ON DELETE CASCADE ON UPDATE CASCADE,
	aux CHAR(50)
);

INSERT INTO Orto (gps, tipo, condizione, nome, superficie, nSensori, codiceMecc, aux) VALUES
	('41.890251, 12.492373', 'vaso', 'biomonitoraggio sporco', 'Orto A', 100, 14, 'ABCD123456', NULL),
	('41.902783, 12.496366', 'campo', 'biomonitoraggio pulito', 'Orto B', 80, 13, 'ABCD123456', NULL),
	('41.903820, 12.496882', 'campo', 'fitobonifica', 'Orto C', 10, 1, 'ABCD123456', NULL),
	('41.875620, 12.551539', 'campo', 'biomonitoraggio sporco', 'Orto D', 120, 15, 'EFGH987654', NULL),
	('41.889159, 12.544033', 'vaso', 'biomonitoraggio pulito', 'Orto E', 90, 14, 'EFGH987654', NULL),
	('41.893528, 12.543184', 'campo', 'fitobonifica', 'Orto F', 15, 2, 'EFGH987654', NULL),
	('41.917547, 12.457347', 'campo', 'biomonitoraggio sporco', 'Orto G', 110, 6, 'BCDE234567', NULL),
	('41.918650, 12.462427', 'vaso', 'biomonitoraggio pulito', 'Orto H', 100, 5, 'BCDE234567', NULL),
	('41.919710, 12.462600', 'campo', 'fitobonifica', 'Orto I', 20, 3, 'BCDE234567', NULL),
	('41.853295, 12.497321', 'vaso', 'biomonitoraggio sporco', 'Orto J', 130, 17, 'LMNO901234', NULL),
	('41.857788, 12.493683', 'campo', 'biomonitoraggio pulito', 'Orto K', 110, 16, 'LMNO901234', NULL),
	('41.859173, 12.493100', 'campo', 'fitobonifica', 'Orto L', 25, 4, 'LMNO901234', NULL),
	('41.869463, 12.478170', 'vaso', 'biomonitoraggio sporco', 'Orto M', 140, 20, 'CDEF678901', NULL),
	('41.871563, 12.472777', 'campo', 'biomonitoraggio pulito', 'Orto N', 120, 7, 'CDEF678901', NULL),
	('41.872840, 12.471980', 'campo', 'fitobonifica', 'Orto O', 30, 5, 'CDEF678901', NULL),
	('41.930298, 12.519671', 'campo', 'biomonitoraggio sporco', 'Orto P', 150, 19, 'UVWX567890', NULL),
	('41.932443, 12.514613', 'vaso', 'biomonitoraggio pulito', 'Orto Q', 130, 18, 'UVWX567890', NULL);


/*-----------------------------------------------------------------------*/
CREATE TABLE Specie (
	nomeS VARCHAR(30) PRIMARY KEY,
	nomeC VARCHAR(30) NOT NULL,
	esposizione VARCHAR(20) NOT NULL CHECK (esposizione IN ('sole','mezzombra','ombra','sole-mezzombra','mezzombra-sole')),
	aux CHAR(100)
);

INSERT INTO Specie (nomeS, nomeC, esposizione, aux) VALUES
	('Rosa canina', 'Rosa canina', 'sole', NULL),
	('Lavandula angustifolia', 'Lavanda', 'sole-mezzombra', NULL),
	('Ocimum basilicum', 'Basilico', 'sole', NULL),
	('Salvia officinalis', 'Salvia', 'sole', NULL),
	('Mentha piperita', 'Menta', 'mezzombra', NULL),
	('Rosmarinus officinalis', 'Rosmarino', 'sole', NULL),
	('Matricaria chamomilla', 'Camomilla', 'sole-mezzombra', NULL),
	('Melissa officinalis', 'Melissa', 'sole-mezzombra', NULL),
	('Tagetes erecta', 'Tagete', 'sole', NULL),
	('Origanum vulgare', 'Origano', 'sole', NULL),
	('Calendula officinalis', 'Calendula', 'sole-mezzombra', NULL),
	('Foeniculum vulgare', 'Finocchio', 'sole', NULL),
	('Helianthus annuus', 'Girasole', 'sole', NULL),
	('Petroselinum crispum', 'Prezzemolo', 'mezzombra', NULL),
	('Lactuca sativa', 'Lattuga', 'ombra', NULL),
	('Cucumis sativus', 'Cetriolo', 'sole', NULL),
	('Cucurbita pepo', 'Zucca', 'sole-mezzombra', NULL),
	('Solanum lycopersicum', 'Pomodoro', 'sole', NULL),
	('Capsicum annuum', 'Peperone', 'sole', NULL),
	('Phaseolus vulgaris', 'Fagiolo', 'sole-mezzombra', NULL);


/*-----------------------------------------------------------------------*/
CREATE TABLE Gruppo (
	idGruppo INT PRIMARY KEY,
	nomeS VARCHAR(30) NOT NULL REFERENCES Specie,
	gps VARCHAR(22) NOT NULL REFERENCES Orto,
	aux CHAR(100)
);

INSERT INTO Gruppo (idGruppo, nomeS, gps, aux) VALUES
	(1, 'Rosa canina', '41.890251, 12.492373', NULL),
	(2, 'Salvia officinalis', '41.902783, 12.496366', NULL),
	(3, 'Ocimum basilicum', '41.903820, 12.496882', NULL),
	(4, 'Salvia officinalis', '41.875620, 12.551539', NULL),
	(5, 'Rosa canina', '41.889159, 12.544033', NULL),
	(6, 'Rosmarinus officinalis', '41.893528, 12.543184', NULL),
	(7, 'Calendula officinalis', '41.917547, 12.457347', NULL),
	(8, 'Melissa officinalis', '41.918650, 12.462427', NULL),
	(9, 'Helianthus annuus', '41.919710, 12.462600', NULL),
	(10, 'Melissa officinalis', '41.853295, 12.497321', NULL),
	(11, 'Calendula officinalis', '41.857788, 12.493683', NULL),
	(12, 'Foeniculum vulgare', '41.859173, 12.493100', NULL),
	(13, 'Helianthus annuus', '41.869463, 12.478170', NULL),
	(14, 'Cucumis sativus', '41.871563, 12.472777', NULL),
	(15, 'Lactuca sativa', '41.872840, 12.471980', NULL),
	(16, 'Cucumis sativus', '41.930298, 12.519671', NULL),
	(17, 'Helianthus annuus', '41.932443, 12.514613', NULL);


/*-----------------------------------------------------------------------*/
CREATE TABLE Controllo (
	idGruppoS INT REFERENCES Gruppo(idGruppo),
	idGruppoP INT REFERENCES Gruppo(idGruppo),
	PRIMARY KEY (idGruppoS,idGruppoP)
);

-- popolata tramite funzione abbinamento

/*-----------------------------------------------------------------------*/
CREATE TABLE Pianta (
	nReplica INT CHECK (nReplica BETWEEN 1 AND 20),
	idGruppo INT REFERENCES Gruppo,
	data TIMESTAMP NOT NULL CHECK (data <= CURRENT_DATE),
	classe VARCHAR(50) NOT NULL,
	codiceMecc CHAR(10) NOT NULL REFERENCES Scuola ON DELETE CASCADE ON UPDATE CASCADE,
	esposizioneP VARCHAR(20) NOT NULL CHECK (esposizioneP IN ('sole','mezzombra','ombra','sole-mezzombra','mezzombra-sole')),
	PRIMARY KEY (nReplica, idGruppo),
	FOREIGN KEY (classe, codiceMecc) REFERENCES Classe ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO Pianta (nReplica, idGruppo, data, classe, codiceMecc, esposizioneP) VALUES
	(1, 1, '2023-06-01', '1A', 'ABCD123456', 'sole'),
	(2, 2, '2023-06-02', '1A', 'ABCD123456', 'sole'),
	(3, 3, '2023-06-03', '1A', 'ABCD123456', 'sole'),
	(4, 4, '2023-06-04', '2B', 'EFGH987654', 'sole'),
	(5, 5, '2023-06-05', '2B', 'EFGH987654', 'sole'),
	(6, 6, '2023-06-06', '2B', 'EFGH987654', 'sole'),
	(7, 7, '2023-06-07', '1C', 'BCDE234567', 'sole-mezzombra'),
	(8, 8, '2023-06-08', '1C', 'BCDE234567', 'sole-mezzombra'),
	(9, 9, '2023-06-09', '1C', 'BCDE234567', 'sole'),
	(10, 10, '2023-06-10', '4C', 'LMNO901234', 'sole-mezzombra'),
	(11, 11, '2023-06-11', '4C', 'LMNO901234', 'sole-mezzombra'),
	(12, 12, '2023-06-12', '4C', 'LMNO901234', 'sole'),
	(13, 13, '2023-06-13', '4C', 'CDEF678901', 'sole'),
	(14, 14, '2023-06-14', '4C', 'CDEF678901', 'sole'),
	(15, 15, '2023-06-15', '4C', 'CDEF678901', 'ombra'),
	(16, 16, '2023-06-16', '1D', 'UVWX567890', 'sole'),
	(17, 17, '2023-06-17', '1D', 'UVWX567890', 'sole');


/*-----------------------------------------------------------------------*/
CREATE TABLE Dispositivo (
	nReplica INT,
	idGruppo INT,
	temperatura DECIMAL(5,2) NOT NULL,
	ph DECIMAL(3,2) NOT NULL CHECK (ph BETWEEN 0 AND 14),
	umidita DECIMAL(5,2) NOT NULL,
	luce DECIMAL(10,2),
	fertilita DECIMAL(8,2),
	pressione DECIMAL(8,2),
	tipoDisp VARCHAR(30) NOT NULL CHECK (tipoDisp IN ('sensore','scheda arduino')),
	gps VARCHAR(22) NOT NULL REFERENCES Orto ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (nReplica, idGruppo),
	FOREIGN KEY (nReplica, idGruppo) REFERENCES Pianta ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Dispositivo (nReplica, idGruppo, temperatura, ph, umidita, luce, fertilita, pressione, tipoDisp, gps) VALUES
	(1, 1, 25.5, 6.8, 70.2, 4500.5, 80.3, NULL, 'sensore', '41.890251, 12.492373'),
	(2, 2, 26.8, 7.2, 68.7, 5000.1, 82.1, NULL, 'sensore', '41.902783, 12.496366'),
	(3, 3, 27.2, 6.9, 71.5, 4800.8, 81.5, NULL, 'sensore', '41.903820, 12.496882'),
	(4, 4, 24.9, 7.1, 69.8, 4600.3, 79.8, NULL, 'sensore', '41.875620, 12.551539'),
	(5, 5, 26.3, 7.0, 72.3, 4900.6, 80.9, NULL, 'sensore', '41.889159, 12.544033'),
	(6, 6, 25.7, 6.8, 70.5, 4700.2, 82.5, NULL, 'sensore', '41.893528, 12.543184'),
	(7, 7, 27.6, 7.2, 69.1, 5200.7, 81.3, NULL, 'sensore', '41.917547, 12.457347'),
	(8, 8, 25.2, 6.9, 72.8, 5000.4, 79.1, NULL, 'sensore', '41.918650, 12.462427'),
	(9, 9, 25.8, 7.1, 68.9, 4800.7, 81.0, NULL, 'sensore', '41.919710, 12.462600'),
	(10, 10, 27.4, 7.0, 71.2, 5100.3, 82.6, NULL, 'sensore', '41.853295, 12.497321'),
	(11, 11, 26.9, 6.8, 69.5, 4900.9, 81.4, NULL, 'sensore', '41.857788, 12.493683'),
	(12, 12, 24.7, 7.2, 72.1, NULL, NULL, 1.4, 'scheda arduino', '41.859173, 12.493100'),
	(13, 13, 25.5, 7.1, 72.5, NULL, NULL, 1.3, 'scheda arduino', '41.869463, 12.478170'),
	(14, 14, 27.0, 6.8, 69.8, NULL, NULL, 1.2, 'scheda arduino', '41.871563, 12.472777'),
	(15, 15, 25.3, 7.2, 71.3, NULL, NULL, 1.4, 'scheda arduino', '41.872840, 12.471980'),
	(16, 16, 24.9, 7.0, 70.5, NULL, NULL, 1.3, 'scheda arduino', '41.930298, 12.519671'),
	(17, 17, 26.5, 6.9, 68.7, NULL, NULL, 1.2, 'scheda arduino', '41.932443, 12.514613');


/*-----------------------------------------------------------------------*/
CREATE TABLE StudiaSpecie (
	codiceMecc CHAR(10) REFERENCES Scuola ON DELETE CASCADE ON UPDATE CASCADE,
	nomeS VARCHAR(30) REFERENCES Specie,
	aux CHAR(100),
	PRIMARY KEY (codiceMecc, nomeS)
);

INSERT INTO StudiaSpecie (codiceMecc, nomeS, aux) VALUES
	('ABCD123456', 'Rosa canina', NULL),
	('ABCD123456', 'Salvia officinalis', NULL),
	('ABCD123456', 'Ocimum basilicum', NULL),
	('TUVW123456', 'Lactuca sativa', NULL),
	('TUVW123456', 'Cucumis sativus', NULL),
	('TUVW123456', 'Cucurbita pepo', NULL),
	('EFGH987654', 'Salvia officinalis', NULL),
	('EFGH987654', 'Rosa canina', NULL),
	('EFGH987654', 'Rosmarinus officinalis', NULL),
	('BCDE234567', 'Calendula officinalis', NULL),
	('BCDE234567', 'Melissa officinalis', NULL),
	('BCDE234567', 'Helianthus annuus', NULL),
	('CDEF678901', 'Helianthus annuus', NULL),
	('CDEF678901', 'Cucumis sativus', NULL),
	('CDEF678901', 'Lactuca sativa', NULL),
	('UVWX567890', 'Cucumis sativus', NULL),
	('UVWX567890', 'Helianthus annuus', NULL),
	('GHIJ345678', 'Helianthus annuus', NULL),
	('NOPQ123456', 'Helianthus annuus', NULL),
	('RSTU789012', 'Helianthus annuus', NULL),
	('YZAB234567', 'Helianthus annuus', NULL),
	('XYZA789012', 'Helianthus annuus', NULL),
	('JKLM567890', 'Helianthus annuus', NULL),
	('PQRS567890', 'Helianthus annuus', NULL),
	('FGHI901234', 'Helianthus annuus', NULL),
	('DEFG567890', 'Helianthus annuus', NULL);


/*-----------------------------------------------------------------------*/
CREATE TABLE Osservazione (
	idOss INT PRIMARY KEY,
	nReplica INT NOT NULL,
	idGruppo INT NOT NULL,
	dataOraRil TIMESTAMP NOT NULL CHECK (dataOraRil <= CURRENT_DATE),
	dataOraIns TIMESTAMP CHECK (dataOraIns >= dataOraRil),
	FOREIGN KEY (nReplica, idGruppo) REFERENCES Pianta ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Osservazione (idOss, nReplica, idGruppo, dataOraRil, dataOraIns) VALUES
	(1, 1, 1, '2023-06-01 10:00:00', NULL),
	(2, 1, 1, '2023-06-01 10:00:00', '2023-06-01 10:10:00'),
	(3, 2, 2, '2023-06-03 09:00:00', '2023-06-03 09:05:00'),
	(4, 2, 2, '2023-06-03 09:00:00', '2023-06-03 09:08:00'),
	(5, 11, 11, '2023-06-05 14:00:00', '2023-06-05 14:05:00'),
	(6, 12, 12, '2023-06-05 14:00:00', NULL),
	(7, 4, 4, '2023-06-07 11:30:00', '2023-06-07 11:35:00'),
	(8, 4, 4, '2023-06-07 11:30:00', '2023-06-07 11:40:00'),
	(9, 5, 5, '2023-06-09 16:45:00', '2023-06-09 16:50:00'),
	(10, 6, 6, '2023-06-11 13:15:00', NULL),
	(11, 7, 7, '2023-06-13 08:30:00', '2023-06-13 08:35:00'),
	(12, 7, 7, '2023-06-13 08:30:00', '2023-06-13 08:40:00'),
	(13, 8, 8, '2023-06-15 17:20:00', NULL),
	(14, 8, 8, '2023-06-15 17:20:00', '2023-06-15 17:30:00'),
	(15, 10, 10, '2023-06-17 12:45:00', '2023-06-17 12:50:00'),
	(16, 10, 10, '2023-06-17 12:45:00', '2023-06-17 12:55:00'),
	(17, 14, 14, '2023-06-18 16:45:00', NULL),
	(18, 15, 15, '2023-06-19 08:45:00', '2023-06-19 10:55:00'),
	(19, 16, 16, '2023-06-20 11:27:00', NULL),
	(20, 10, 10, '2023-06-14 17:20:00', '2023-06-15 10:55:00'),
	(21, 11, 11, '2023-06-17 07:45:00', NULL),
	(22, 12, 12, '2023-06-18 15:35:00', NULL),
	(23, 3, 3, '2023-06-18 15:35:00', NULL), 
	(24, 3, 3, '2023-06-18 15:35:00', NULL); 



/*-----------------------------------------------------------------------*/
CREATE TABLE RespIns (
	idOss INT REFERENCES Osservazione ON DELETE CASCADE ON UPDATE CASCADE,
	email VARCHAR(50) REFERENCES Partecipante ON DELETE CASCADE ON UPDATE CASCADE,
	rapClasse BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY (idOss,email)
);

INSERT INTO RespIns (idOss, email, rapClasse) VALUES
	(2, 'email195@example.com', false),
	(3, 'email1@example.com', false),
	(5, 'email12@example.com', true),
	(7, 'email9891@example.com', false),
	(8, 'email12@example.com', true),
	(12, 'email9@example.com', true),
	(15, 'email12@example.com', true),
	(18, 'email20@example.com', true),
	(20, 'email1244@example.com', false);


/*-----------------------------------------------------------------------*/
CREATE TABLE RespOss (
	idOss INT REFERENCES Osservazione ON DELETE CASCADE ON UPDATE CASCADE,
	email VARCHAR(50) REFERENCES Partecipante ON DELETE CASCADE ON UPDATE CASCADE,
	rapClasse BOOLEAN NOT NULL DEFAULT FALSE,
	PRIMARY KEY (idOss,email)
);

INSERT INTO RespOss (idOss, email, rapClasse) VALUES
	(1, 'email195@example.com', true),
	(2, 'email26@example.com', false),
	(3, 'email195@example.com', false),
	(4, 'email1@example.com', false),
	(5, 'email12@example.com', false),
	(6, 'email12@example.com', true),
	(7, 'email1167@example.com', false),
	(8, 'email9891@example.com', false),
	(9, 'email8@example.com', false),
	(10, 'email8@example.com', true),
	(11, 'email9@example.com', true),
	(12, 'email9@example.com', false),
	(13, 'email9@example.com', true),
	(14, 'email9@example.com', true),
	(15, 'email12@example.com', false),
	(16, 'email12@example.com', true),
	(17, 'email20@example.com', false),
	(18, 'email20@example.com', false),
	(19, 'email17@example.com', false),
	(20, 'email1244@example.com', false),
	(21, 'email1244@example.com', false),
	(22, 'email1244@example.com', false),
	(23, 'email2@example.com', true),
	(24, 'email2@example.com', true);


/*-----------------------------------------------------------------------*/
CREATE TABLE DatiOss (
	idOss INT PRIMARY KEY REFERENCES Osservazione ON DELETE CASCADE ON UPDATE CASCADE,
	nFoglieDann INT,
	supDannFoglia DECIMAL(5, 2) CHECK (supDannFoglia BETWEEN 0.00 AND 100.00),
	larghCF DECIMAL(10, 2),
	lunghCF DECIMAL(10, 2),
	pesoFrescoCF DECIMAL(10, 2),
	pesoSeccoCF DECIMAL(10, 2),
	lunghRadici DECIMAL(10, 2),
	altezzaPianta DECIMAL(10, 2),
	pesoFrescoRadici DECIMAL(10, 2),
	pesoSeccoRadici DECIMAL(10, 2),
	nFiori INT,
	nFrutti INT
);

INSERT INTO DatiOss (idOss, nFoglieDann, supDannFoglia, larghCF, lunghCF, pesoFrescoCF, pesoSeccoCF, lunghRadici, altezzaPianta, pesoFrescoRadici, pesoSeccoRadici, nFiori, nFrutti) VALUES
	(1, 5, 10.5, 8.2, 12.7, 35.2, 29.8, 18.5, 45.3, 64.7, 52.4, 8, 3),
	(2, 3, 6.7, 7.5, 11.1, 32.6, 27.3, 16.9, 42.1, 59.8, 49.2, 6, 2),
	(3, 4, 8.2, 9.8, 13.5, 37.9, 31.4, 20.3, 48.6, 68.9, 56.7, 10, 4),
	(4, 2, 4.6, 6.4, 9.7, 29.8, 24.1, 14.7, 38.2, 54.3, 44.5, 4, 1),
	(5, 6, 12.9, 10.1, 14.8, 41.5, 34.2, 22.1, 51.9, 73.5, 60.8, 12, 5),
	(6, 5, 10.5, 8.2, 12.7, 35.2, 29.8, 18.5, 45.3, 64.7, 52.4, 8, 3),
	(7, 3, 6.7, 7.5, 11.1, 32.6, 27.3, 16.9, 42.1, 59.8, 49.2, 6, 2),
	(8, 4, 8.2, 9.8, 13.5, 37.9, 31.4, 20.3, 48.6, 68.9, 56.7, 10, 4),
	(9, 2, 4.6, 6.4, 9.7, 29.8, 24.1, 14.7, 38.2, 54.3, 44.5, 4, 1),
	(10, 6, 12.9, 10.1, 14.8, 41.5, 34.2, 22.1, 51.9, 73.5, 60.8, 12, 5),
	(11, 5, 10.5, 8.2, 12.7, 35.2, 29.8, 18.5, 45.3, 64.7, 52.4, 8, 3),
	(12, 3, 6.7, 7.5, 11.1, 32.6, 27.3, 16.9, 42.1, 59.8, 49.2, 6, 2),
	(13, 4, 8.2, 9.8, 13.5, 37.9, 31.4, 20.3, 48.6, 68.9, 56.7, 10, 4),
	(14, 2, 4.6, 6.4, 9.7, 29.8, 24.1, 14.7, 38.2, 54.3, 44.5, 4, 1),
	(15, 6, 12.9, 10.1, 14.8, 41.5, 34.2, 22.1, 51.9, 73.5, 60.8, 12, 5),
	(16, 5, 10.5, 8.2, 12.7, 35.2, 29.8, 18.5, 45.3, 64.7, 52.4, 8, 3),
	(17, 3, 6.7, 7.5, 11.1, 32.6, 27.3, 16.9, 42.1, 59.8, 49.2, 6, 2),
	(18, 4, 8.2, 9.8, 13.5, 37.9, 31.4, 20.3, 48.6, 68.9, 56.7, 10, 4);


/*-----------------------------------------------------------------------*/


--CODICE PER IMPLEMENTARE LA VISTA
/*RICHIESTA: La definizione di una vista che fornisca alcune informazioni riassuntive per ogni attività di biomonitoraggio: per
ogni gruppo e per il corrispondente gruppo di controllo mostrare il numero di piante, la specie, l’orto in cui è
posizionato il gruppo e, su base mensile, il valore medio dei parametri ambientali e di crescita delle piante (selezionare almeno tre parametri, quelli che si ritengono più significativi)*/


-- Questa è una funzione ausiliaria che utilizziamo all'interno della vista per contare il numero di repliche
CREATE OR REPLACE FUNCTION numero_repliche (f_idGruppo INT, OUT n_repliche INT)
LANGUAGE plpgsql
AS $$
BEGIN
	SELECT count(*) INTO n_repliche
	FROM Gruppo
	JOIN Pianta ON Gruppo.idGruppo = Pianta.idGruppo
	WHERE Gruppo.idGruppo = f_idGruppo;
END;
$$;


CREATE VIEW InfRiass AS
SELECT Controllo.idGruppoS, numero_repliche(Controllo.idGruppoS) numero_replicheS, Gs.nomeS nomeS, Gs.gps gpsS,
		Controllo.idGruppoP, numero_repliche(Controllo.idGruppoP) numero_replicheP, Gp.nomeS nomeP, Gp.gps gpsP,
		AVG(DosS.larghCF) avg_larghCFs,AVG(DosS.lunghCF) avg_lunghCFs,AVG(DosS.lunghRadici) avg_lunghRadicis,
		AVG(DosP.larghCF) avg_larghCFp,AVG(DosP.lunghCF) avg_lunghCFp,AVG(DosP.lunghRadici) avg_lunghRadicip,
		AVG(DispS.ph) avg_phs, AVG(DispP.ph) avg_php
FROM Controllo
JOIN Gruppo as Gs On Gs.idGruppo = Controllo.idGruppoS
JOIN Gruppo as Gp On Gp.idGruppo = Controllo.idGruppoP
LEFT OUTER JOIN Osservazione as OsS On OsS.idGruppo = Gs.idGruppo AND OsS.dataoraRil BETWEEN CURRENT_DATE - INTERVAL '11 month' AND CURRENT_DATE
LEFT OUTER JOIN Osservazione as OsP On OsP.idGruppo = Gp.idGruppo AND OsP.dataoraRil BETWEEN CURRENT_DATE - INTERVAL '11 month' AND CURRENT_DATE
LEFT OUTER JOIN DatiOss as DosS ON OsS.idOss = DosS.idOss
LEFT OUTER JOIN DatiOss as DosP ON OsP.idOss = DosP.idOss
LEFT OUTER JOIN Dispositivo as DispS on DispS.idGruppo = Controllo.idGruppoS
LEFT OUTER JOIN Dispositivo as DispP on DispP.idGruppo = Controllo.idGruppoP
GROUP BY (Controllo.idGruppoS,Gs.nomeS, Gs.gps,Controllo.idGruppoP,  Gp.nomeS, Gp.gps);


/*-----------------------------------------------------------------------*/


-- CODICE PER IMPLEMENTARE LE INTERROGAZIONI

/* QUERY 1
Determinare le scuole che, pur avendo un finanziamento per il progetto,
non hanno inserito rilevazioni in questo anno scolastico;

voglio restituire tutte le scuole meno quelle con osservazioni:
poichè non è detto che il respIns sia presente nella relazione poichè viene salvato
solo se diverso dal respOss, guardiamo le ossevazioni per cui è stato effettuato
l'inserimento dei dati, ma di queste poi non guardiamo il respIns perchè non è detto esserci
ma il respOss e la scuola cui appartiene (che comunque deve essere la stessa),
infine restituiamo le scuole meno quelle trovate, queste saranno quelle senza inserimenti*/

SELECT codiceMecc
FROM Scuola
EXCEPT
SELECT DISTINCT codiceMecc
FROM Partecipante
NATURAL JOIN RespOss
JOIN Osservazione ON RespOss.idOss = Osservazione.idOss
WHERE Osservazione.dataOraIns IS NOT NULL;

/* QUERY 2
Determinare le specie utilizzate in tutte le province in cui ci sono scuole aderenti al progetto;

voglio trovare le specie che tutte le province hanno in osservazione in comune:
conto il numero di province distinte in cui compare una specie e cerco quelle che hanno
conteggio pari al numero di province in cui ci sono scuole aderenti al progetto*/

SELECT nomeS
FROM StudiaSpecie
NATURAL JOIN Scuola
GROUP BY nomeS
HAVING COUNT (DISTINCT Scuola.provincia) = (SELECT COUNT (DISTINCT provincia)
											FROM Scuola);


/*La query 3 abbiamo deciso di implementarla in due modi diversi: 
1: Determiniamo l'individuo che ha effettuato più rilevazioni
2: Determiniamo la scuola che ha effettuato più rilevazioni*/

/* QUERY 3.1
Determinare per ogni scuola l’individuo della scuola che ha effettuato più rilevazioni;
in caso di più individui con lo stesso numero di osservazioni per la stessa scuola, vengono restituiti tutti*/

SELECT S.codiceMecc, Partecipante.email, COUNT(*)
FROM Scuola AS S
JOIN Partecipante ON S.codiceMecc = Partecipante.codiceMecc
JOIN RespOss ON Partecipante.email = RespOss.email AND RespOss.rapClasse=false
GROUP BY S.codiceMecc, Partecipante.email
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
						FROM Scuola
						JOIN Partecipante ON Scuola.codiceMecc = Partecipante.codiceMecc
						JOIN RespOss ON Partecipante.email = RespOss.email AND RespOss.rapClasse=false
						WHERE Scuola.codiceMecc = S.codiceMecc
						GROUP BY Scuola.codiceMecc, Partecipante.email)
ORDER BY S.codiceMecc;


/* QUERY 3.2
Determinare per ogni scuola la classe della scuola che ha effettuato più rilevazioni;
in caso di più classi con lo stesso numero di osservazioni per la stessa scuola, vengono restituite tutte*/

SELECT Cl.CodiceMecc, Cl.classe, COUNT(*)
FROM RespOss
NATURAL JOIN Partecipante
JOIN Classe AS Cl ON (Partecipante.codiceMecc, Partecipante.classe) = (Cl.codiceMecc, Cl.classe)
WHERE RespOss.rapClasse = true
GROUP BY Cl.CodiceMecc, Cl.classe
HAVING COUNT (*) >= ALL (SELECT COUNT(*)
						FROM RespOss
						NATURAL JOIN Partecipante
						JOIN Classe ON (Partecipante.codiceMecc, Partecipante.classe) = (Classe.codiceMecc, Classe.classe)
						WHERE RespOss.rapClasse = true AND Classe.codiceMecc = Cl.codiceMecc
						GROUP BY Classe.CodiceMecc, Classe.classe)
ORDER BY Cl.codiceMecc, Cl.classe;


/*-----------------------------------------------------------------------*/


-- CODICE PER IMPLEMENTARE LE FUNZIONI
/*FUNZIONE 1
Funzione che realizza l’abbinamento tra gruppo e gruppo di controllo nel caso di operazioni
di biomonitoraggio;*/

CREATE OR REPLACE FUNCTION abbinamento(IN gruppo_s INT, IN gruppo_p INT)
RETURNS VOID
LANGUAGE plpgsql
AS $$
DECLARE
	gruppo_sporco VARCHAR(30);
	specie_sporco VARCHAR(30);
	gruppo_pulito VARCHAR(30);
	specie_pulito VARCHAR(30);
BEGIN
	SELECT Orto.condizione, Gruppo.nomeS INTO gruppo_sporco, specie_sporco
	FROM Gruppo
	NATURAL JOIN Orto
	WHERE Gruppo.idGruppo = gruppo_s;

	SELECT Orto.condizione, Gruppo.nomeS INTO gruppo_pulito, specie_pulito
	FROM Gruppo
	NATURAL JOIN Orto
	WHERE Gruppo.idGruppo = gruppo_p;

	IF (gruppo_sporco != 'biomonitoraggio sporco' OR
	    gruppo_pulito != 'biomonitoraggio pulito') THEN
		RAISE EXCEPTION 'operazione valida solo su gruppi di biomonitoraggio (di cui uno sporco e uno pulito)';
	ELSIF (specie_pulito != specie_sporco) THEN
		RAISE EXCEPTION 'i gruppi non sono della stessa specie';
	ELSE
		INSERT INTO Controllo (idGruppoP, idGruppoS)
		VALUES (gruppo_p, gruppo_s);
	END IF;
END;
$$;

-- Chiamate funzione abbinamento
SELECT abbinamento(1,5);
SELECT abbinamento(4,2);
SELECT abbinamento(10,8);
SELECT abbinamento(7,11);
SELECT abbinamento(13,17);
SELECT abbinamento(16,14);

/* FUNZIONE 2
Funzione che data una replica con finalità di fitobonifica e due date,
determina i valori medi dei parametri rilevati per tale replica nel periodo compreso tra le due date;*/

CREATE OR REPLACE FUNCTION valori_medi(f_date_from TIMESTAMP, f_date_to TIMESTAMP, f_nReplica INT, f_idGruppo INT,
					OUT f_nFoglieDann INT, OUT f_supDannFoglia DECIMAL(5,2), OUT f_larghCF DECIMAL(10,2),
					OUT f_lunghCF DECIMAL(10,2), OUT f_pesoFrescoCF DECIMAL(10,2), OUT f_pesoSeccoCF DECIMAL(10,2),
					OUT f_lunghRadici DECIMAL(10,2), OUT f_altezzaPianta DECIMAL(10,2), OUT f_pesoFrescoRadici DECIMAL(10,2),
					OUT f_pesoSeccoRadici DECIMAL(10,2), OUT f_nFiori INT, OUT f_nFrutti INT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF (f_date_to > CURRENT_DATE OR f_date_from > CURRENT_DATE OR f_date_from > f_date_to) THEN
		RAISE EXCEPTION 'date non valide';
	END IF;

	SELECT AVG(DatiOss.nFoglieDann), AVG(DatiOss.supDannFoglia), AVG(DatiOss.larghCF), AVG(DatiOss.lunghCF),
			AVG(DatiOss.pesoFrescoCF), AVG(DatiOss.pesoSeccoCF), AVG(DatiOss.lunghRadici), AVG(DatiOss.altezzaPianta),
			AVG(DatiOss.pesoFrescoRadici), AVG(DatiOss.pesoSeccoRadici), AVG(DatiOss.nFiori), AVG(DatiOss.nFrutti)
	INTO f_nFoglieDann, f_supDannFoglia, f_larghCF, f_lunghCF, f_pesoFrescoCF, f_pesoSeccoCF,
		 f_lunghRadici, f_altezzaPianta, f_pesoFrescoRadici, f_pesoSeccoRadici, f_nFiori, f_nFrutti
	FROM Osservazione
	NATURAL JOIN Pianta
	NATURAL JOIN DatiOss
	WHERE Pianta.nReplica = f_nReplica AND Pianta.idGruppo = f_idGruppo
			AND Osservazione.dataOraRil BETWEEN f_date_from AND f_date_to;
END;
$$;

-- Chiamata funzione valori_medi
SELECT * FROM valori_medi('2023-06-01 9:00:00','2023-06-01 11:00:00',1,1);


/*-----------------------------------------------------------------------*/


-- CODICE PER IMPLEMENTARE I TRIGGER

/*TRIGGER 1
Verifica del vincolo che ogni scuola dovrebbe concentrarsi su tre specie e ogni gruppo dovrebbe
contenere 20 repliche;*/

CREATE OR REPLACE FUNCTION non_tre()
RETURNS trigger
LANGUAGE plpgsql
AS $non_tre$
BEGIN
	IF (SELECT COUNT(*) FROM StudiaSpecie
	WHERE codiceMecc = NEW.codiceMecc) >= 3 THEN
		RAISE EXCEPTION '% , questa scuola si concentra già su tre specie', NEW.codiceMecc; -- non viene effettuato return new, la tupla non è inserita/modificata, equivalente a RETURN NULL
	ELSE
		RETURN NEW; -- si restituisce NEW: la tupla NEW viene inserita o usata per modifica
	END IF;
END;
$non_tre$;


CREATE OR REPLACE TRIGGER non_tre
BEFORE INSERT OR UPDATE OF codiceMecc ON StudiaSpecie
FOR EACH ROW
EXECUTE FUNCTION non_tre();

------------

CREATE OR REPLACE FUNCTION non_venti()
RETURNS trigger
LANGUAGE plpgsql
AS $non_venti$
BEGIN
	IF (SELECT COUNT(*) FROM Pianta
	WHERE idGruppo = NEW.idGruppo) >= 20 THEN
		RAISE EXCEPTION '% , questo gruppo ha gia 20 piante', NEW.idGruppo; -- non viene effettuato return new, la tupla non è inserita/modificata, equivalente a RETURN NULL
	ELSE
		RETURN NEW; -- si restituisce NEW: la tupla NEW viene inserita o usata per modifica
	END IF;
END;
$non_venti$;


CREATE TRIGGER non_venti
BEFORE INSERT OR UPDATE ON Pianta
FOR EACH ROW
EXECUTE FUNCTION non_venti();

/*TRIGGER 2
Generazione di un messaggio (o inserimento di una informazione di warning in qualche tabella)
quando viene rilevato un valore decrescente per un parametro di biomassa.*/

CREATE OR REPLACE FUNCTION check_biomassa()
RETURNS trigger
LANGUAGE plpgsql
AS $check_biomassa$
DECLARE
	f_nReplica INT;
	f_idGruppo INT;
BEGIN
	SELECT Osservazione.nReplica, Osservazione.idGruppo INTO f_nReplica, f_idGruppo
	FROM DatiOss
	NATURAL JOIN Osservazione
	WHERE Osservazione.idOss = NEW.idOss;

	IF (NEW.larghCF <= ALL (SELECT larghCF
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: larghezza chioma/foglie' ;
	ELSIF (NEW.lunghCF <= ALL (SELECT larghCF
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: lunghezza chioma/foglie';
	ELSIF (NEW.pesoFrescoCF <= ALL (SELECT pesoFrescoCF
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: peso fresco chioma/foglie';
	ELSIF (NEW.pesoSeccoCF <= ALL (SELECT pesoSeccoCF
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: peso secco chioma/foglie';
	ELSIF (NEW.lunghRadici <= ALL (SELECT lunghRadici
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: lunghezza radici';
	ELSIF (NEW.altezzaPianta <= ALL (SELECT altezzaPianta
							FROM DatiOss
							NATURAL JOIN Osservazione
							WHERE (Osservazione.nReplica, Osservazione.idGruppo) = (f_nReplica, f_idGruppo))) THEN
		RAISE WARNING ' è stato rilevato un valore decrescente per un parametro di biomassa: altezza pianta';
	END IF;
END;
$check_biomassa$;


CREATE TRIGGER check_biomassa
AFTER INSERT OR UPDATE ON DatiOss
FOR EACH ROW
EXECUTE FUNCTION check_biomassa();