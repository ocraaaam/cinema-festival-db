CREATE DATABASE IF NOT EXISTS FestivalCinematografico;
USE FestivalCinematografico;

-- 1. Creazione Super-Entità
CREATE TABLE IF NOT EXISTS Persona (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    DataNascita DATE NOT NULL
);

-- 2. Creazione Sotto-Entità
CREATE TABLE IF NOT EXISTS Richiedente (
    CF VARCHAR(16) PRIMARY KEY,
    StatoRichiesta VARCHAR(20) NOT NULL,
    TipoAccredito VARCHAR(20) NOT NULL,
    FOREIGN KEY (CF) REFERENCES Persona(CF),
    CHECK (StatoRichiesta IN ('In attesa', 'Approvato', 'Rifiutato')),
    CHECK (TipoAccredito IN ('Stampa', 'Industry'))
);

CREATE TABLE IF NOT EXISTS Giuria (
    CF VARCHAR(16) PRIMARY KEY,
    Qualifica VARCHAR(100) NOT NULL,
    FOREIGN KEY (CF) REFERENCES Persona(CF)
);

CREATE TABLE IF NOT EXISTS Pubblico (
    CF VARCHAR(16) PRIMARY KEY,
    FOREIGN KEY (CF) REFERENCES Persona(CF)
);

CREATE TABLE IF NOT EXISTS Ospite (
    CF VARCHAR(16) PRIMARY KEY,
    Ruolo VARCHAR(50) NOT NULL,
    FOREIGN KEY (CF) REFERENCES Persona(CF)
);

-- 3. Creazione Entità Indipendenti
CREATE TABLE IF NOT EXISTS Sezione (
    ID_Sezione INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL,
    Descrizione TEXT
);

CREATE TABLE IF NOT EXISTS Sala (
    ID_Sala INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Sala VARCHAR(50) NOT NULL,
    Capienza INT NOT NULL,
    CHECK (Capienza > 0)
);

-- 4. Creazione Entità dipendenti da altre tabelle
CREATE TABLE IF NOT EXISTS Logistica (
    ID_Logistica INT AUTO_INCREMENT PRIMARY KEY,
    Hotel VARCHAR(100) NOT NULL,
    Trasporto VARCHAR(100) NOT NULL,
    Periodo_di_Permanenza VARCHAR(50) NOT NULL,
    CF_Ospite VARCHAR(16) NOT NULL UNIQUE, -- UNIQUE perché è una relazione 1:1
    FOREIGN KEY (CF_Ospite) REFERENCES Ospite(CF)
);

CREATE TABLE IF NOT EXISTS Film (
    ID_Film INT AUTO_INCREMENT PRIMARY KEY,
    Titolo VARCHAR(255) NOT NULL,
    Durata INT NOT NULL,
    Sinossi TEXT,
    Nazionalita VARCHAR(50),
    AnnoProduzione INT,
    ID_Sezione INT NOT NULL,
    FOREIGN KEY (ID_Sezione) REFERENCES Sezione(ID_Sezione),
    CHECK (Durata > 0)
);

CREATE TABLE IF NOT EXISTS Premio (
    ID_Premio INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Premio VARCHAR(100) NOT NULL,
    ID_Film INT NOT NULL,
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film)
);

CREATE TABLE IF NOT EXISTS Proiezione (
    ID_Proiezione INT AUTO_INCREMENT PRIMARY KEY,
    Data DATE NOT NULL,
    Ora_Inizio TIME NOT NULL,
    Ora_Fine TIME NOT NULL,
    ID_Film INT NOT NULL,
    ID_Sala INT NOT NULL,
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film),
    FOREIGN KEY (ID_Sala) REFERENCES Sala(ID_Sala),
    CHECK (Ora_Inizio < Ora_Fine) -- Vincolo logico sugli orari
);

CREATE TABLE IF NOT EXISTS Voto (
    ID_Voto INT AUTO_INCREMENT PRIMARY KEY,
    Valutazione INT NOT NULL,
    CF_Votante VARCHAR(16) NOT NULL,
    ID_Film INT NOT NULL,
    FOREIGN KEY (CF_Votante) REFERENCES Persona(CF),
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film),
    CHECK (Valutazione BETWEEN 1 AND 10) -- Vincolo sul range dei voti
);

-- 5. Creazione Tabelle Ponte (Relazioni N:M)
CREATE TABLE IF NOT EXISTS Partecipazione (
    CF_Ospite VARCHAR(16) NOT NULL,
    ID_Film INT NOT NULL,
    PRIMARY KEY (CF_Ospite, ID_Film),
    FOREIGN KEY (CF_Ospite) REFERENCES Ospite(CF),
    FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film)
);