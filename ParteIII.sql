SET search_path TO "OrtiScolastici";

-- PROGETTO FISICO

-- a) Descrizione e implementazione query

/* QUERY 1
Per ogni scuola di Milano, restituire le specie studiate;

Osservazione: non abbiamo fatto natural join in quanto veniva fatta una join sbagliata, non sull'attributo codiceMecc;*/

SELECT Scuola.codiceMecc, nome, StudiaSpecie.nomeS
FROM Scuola
JOIN StudiaSpecie ON Scuola.codiceMecc = StudiaSpecie.codiceMecc
WHERE Scuola.provincia = 'MI';


/* QUERY 2
Per ogni scuola, restituire gli orti la cui tipo orto è 'campo' e la condizione è 'fitobonifica';

Osservazione: non abbiamo fatto natural join in quanto veniva fatta una join sbagliata, non sull'attributo codiceMecc;*/

SELECT Scuola.codiceMecc, Scuola.nome, Orto.nome, Orto.gps, Orto.tipo, Orto.condizione
FROM Scuola
JOIN Orto ON Orto.codiceMecc=Scuola.codiceMecc
WHERE Orto.tipo = 'campo' AND Orto.condizione = 'fitobonifica';


/* QUERY 3
Per ogni scuola, restituire i gruppi osservati e le relative specie;

Osservazione: non abbiamo fatto natural join in quanto venivano fatte join sbagliate, non sugli attributi codiceMecc e gps;*/

SELECT Scuola.codiceMecc, Scuola.nome, Gruppo.idGruppo, Gruppo.nomeS
FROM Scuola
JOIN Orto ON Scuola.codiceMecc = Orto.codiceMecc
JOIN Gruppo ON Orto.gps = Gruppo.gps;



/*-----------------------------------------------------------------------*/

/* EXPLAIN PRE INDEX*/

/* QUERY 1*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, nome, StudiaSpecie.nomeS
FROM Scuola
JOIN StudiaSpecie ON Scuola.codiceMecc = StudiaSpecie.codiceMecc
WHERE Scuola.provincia = 'MI';


/* QUERY 2*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, Scuola.nome, Orto.nome, Orto.gps, Orto.tipo, Orto.condizione
FROM Scuola
JOIN Orto ON Orto.codiceMecc=Scuola.codiceMecc
WHERE Orto.tipo = 'campo' AND Orto.condizione = 'fitobonifica';


/* QUERY 3*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, Scuola.nome, Gruppo.idGruppo, Gruppo.nomeS
FROM Scuola
JOIN Orto ON Scuola.codiceMecc = Orto.codiceMecc
JOIN Gruppo ON Orto.gps = Gruppo.gps;



/*-----------------------------------------------------------------------*/

/* CREAZIONE INDEX*/

/* INDICI UTILI PER QUERY 1*/

CREATE INDEX codiceMecc_Scuola ON Scuola (codiceMecc);    
CREATE INDEX codiceMecc_StudiaSpecie ON StudiaSpecie (codiceMecc);
CREATE INDEX provincia_Scuola ON Scuola USING hash (provincia);
cluster Scuola USING codiceMecc_Scuola;


/* INDICI UTILI PER QUERY 2*/

CREATE INDEX tipo_Orto ON Orto USING hash (tipo);
CREATE INDEX condizione_Orto ON Orto USING hash (condizione);


/* INDICI UTILI PER QUERY 3*/

CREATE INDEX gps_Gruppo ON Gruppo (gps);
CREATE INDEX gps_Orto ON Orto (gps);



/*-----------------------------------------------------------------------*/

/* EXPLAIN POST INDEX*/

/* QUERY 1*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, nome, StudiaSpecie.nomeS
FROM Scuola
JOIN StudiaSpecie ON Scuola.codiceMecc = StudiaSpecie.codiceMecc
WHERE Scuola.provincia = 'MI';


/* QUERY 2*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, Scuola.nome, Orto.nome, Orto.gps, Orto.tipo, Orto.condizione
FROM Scuola
JOIN Orto ON Orto.codiceMecc=Scuola.codiceMecc
WHERE Orto.tipo = 'campo' AND Orto.condizione = 'fitobonifica';


/* QUERY 3*/

EXPLAIN ANALYZE SELECT Scuola.codiceMecc, Scuola.nome, Gruppo.idGruppo, Gruppo.nomeS
FROM Scuola
JOIN Orto ON Scuola.codiceMecc = Orto.codiceMecc
JOIN Gruppo ON Orto.gps = Gruppo.gps;



/*-----------------------------------------------------------------------*/


-- CONTROLLO DELL'ACCESSO

--Noi abbiamo inteso Scuola come sinonimo di Istituto, pertanto abbiamo solo 4 ruoli, poichè referente di istituto e di scuola sarebbero stati la stessa cosa

--Creazione ruoli:
CREATE ROLE Insegnante; 
CREATE ROLE Gestore_globale_del_progetto;
CREATE ROLE Referente_scuola;
CREATE ROLE Studente;

--Gerarchia:
GRANT Referente_scuola to Gestore_globale_del_progetto; --Gestore >= Referente
GRANT Insegnante to Referente_scuola; --Referente >= Insegnante
GRANT Studente to Insegnante; --Insegnante >= Studente


/*Non abbiamo espressamente specificato tutti i permessi per tutti i ruoli
in quanto, essendo parte di una gerarchia, il soggetto di livello più alto eredita
i permessi dei soggetti di livelli inferiori.*/ 

------STUDENTE
--Studente può fare la select a tutto tranne a finanziamento
GRANT SELECT ON ALL TABLES
IN SCHEMA "OrtiScolastici" TO Studente;
REVOKE SELECT ON TABLE Finanziamento FROM Studente; 

GRANT INSERT, UPDATE, DELETE ON Specie, Gruppo, Controllo, Dispositivo, RespIns, RespOss, Pianta, Osservazione, DatiOss
TO Studente
WITH GRANT OPTION;


------INSEGNANTE
GRANT SELECT ON Finanziamento 
TO Insegnante 
WITH GRANT OPTION;

GRANT INSERT, UPDATE, DELETE ON Partecipante, Classe
TO Insegnante
WITH GRANT OPTION;


-------REFERENTE_SCUOLA
GRANT INSERT, UPDATE, DELETE ON Orto, StudiaSpecie
TO Referente_scuola
WITH GRANT OPTION;


--------GESTORE_GLOBALE_DEL_PROGETTO
GRANT ALL PRIVILEGES ON ALL TABLES
IN SCHEMA "OrtiScolastici" TO Gestore_globale_del_progetto
WITH GRANT OPTION;


--Creazione utenti a cui assegnare i ruoli
CREATE USER Eleonora PASSWORD 'gestore';
CREATE USER Marta PASSWORD 'referente';
CREATE USER Samuele PASSWORD 'insegnante';
CREATE USER Mario PASSWORD 'studente';

--per assegnare ruolo a utente: GRANT ruolo TO utente WITH ADMIN OPTION ->(possibilità di concedere a terzi la possibilità di ricoprire il ruolo)
GRANT Gestore_globale_del_progetto TO Eleonora WITH ADMIN OPTION;
GRANT Referente_scuola TO Marta WITH ADMIN OPTION;
GRANT Insegnante TO Samuele; 
GRANT Studente to Mario; 