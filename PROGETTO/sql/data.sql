USE FestivalCinematografico;

INSERT INTO Sezione (ID_Sezione, Nome, Descrizione) VALUES
	(1, 'Concorso', 'Selezione ufficiale dei film in gara per i premi principali.'),
	(2, 'Fuori Concorso', 'Proiezioni speciali di film non in competizione.');

INSERT INTO Sala (ID_Sala, Nome_Sala, Capienza) VALUES
	(1, 'Sala Grande', 800),
	(2, 'Sala Darsena', 400),
	(3, 'Sala Pasinetti', 150),
	(4, 'Sala Volpi', 200),
	(5, 'Arena Esterna', 1000);

INSERT INTO Persona (CF, Nome, Cognome, DataNascita) VALUES
	('MRRRSS80A01H501A', 'Mario', 'Rossi', '1980-05-15'),
	('LGGVRD90B02H501B', 'Luigi', 'Verdi', '1990-08-22'),
	('GNBNCH75C03H501C', 'Giovanna', 'Bianchi', '1975-03-10'),
	('PLNREE65D04H501D', 'Paolo', 'Neri', '1965-11-30'),
	('NDRGLL88E05H501E', 'Andrea', 'Gialli', '1988-07-07'),
	('LSSRSO92F06H501F', 'Alessia', 'Russo', '1992-01-14'),
	('QNTTRN63G07H501G', 'Quentin', 'Tarantino', '1963-03-27'),
	('LNDDCP74H08H501H', 'Leonardo', 'DiCaprio', '1974-11-11'),
	('MRGTTB90I09H501I', 'Margot', 'Robbie', '1990-07-02');

INSERT INTO Pubblico (CF) VALUES
	('MRRRSS80A01H501A'),
	('LGGVRD90B02H501B');

INSERT INTO Giuria (CF, Qualifica) VALUES
	('GNBNCH75C03H501C', 'Critico Cinematografico'),
	('PLNREE65D04H501D', 'Presidente di Giuria');

INSERT INTO Richiedente (CF, StatoRichiesta, TipoAccredito) VALUES
	('NDRGLL88E05H501E', 'Approvato', 'Stampa'),
	('LSSRSO92F06H501F', 'In attesa', 'Industry');

INSERT INTO Ospite (CF, Ruolo) VALUES
	('QNTTRN63G07H501G', 'Regista'),
	('LNDDCP74H08H501H', 'Attore Protagonista'),
	('MRGTTB90I09H501I', 'Attrice Protagonista');

INSERT INTO Logistica (ID_Logistica, Hotel, Trasporto, Periodo_di_Permanenza, CF_Ospite) VALUES
	(1, 'Hotel Excelsior', 'Auto Blu', 'Dal 01-09 al 10-09', 'QNTTRN63G07H501G'),
	(2, 'Palace Hotel', 'Motoscafo VIP', 'Dal 03-09 al 08-09', 'LNDDCP74H08H501H'),
	(3, 'Palace Hotel', 'Motoscafo VIP', 'Dal 03-09 al 08-09', 'MRGTTB90I09H501I');

INSERT INTO Film (ID_Film, Titolo, Durata, Sinossi, Nazionalita, AnnoProduzione, ID_Sezione) VALUES
	(1, 'C''era una volta a... Hollywood', 161, 'La storia di un attore...', 'USA', 2019, 1),
	(2, 'La Grande Bellezza', 142, 'Un giornalista riflette...', 'Italia', 2013, 1),
	(3, 'Dune: Parte Due', 166, 'Il viaggio mitico di Paul Atreides...', 'USA', 2024, 2);

INSERT INTO Partecipazione (CF_Ospite, ID_Film) VALUES
	('QNTTRN63G07H501G', 1),
	('LNDDCP74H08H501H', 1),
	('MRGTTB90I09H501I', 1);

INSERT INTO Premio (ID_Premio, Nome_Premio, ID_Film) VALUES
	(1, 'Leone d''Oro Miglior Film', 1),
	(2, 'Coppa Volpi Miglior Attore', 1);

INSERT INTO Proiezione (ID_Proiezione, Data, Ora_Inizio, Ora_Fine, ID_Film, ID_Sala) VALUES
	(1, '2024-09-02', '20:00:00', '22:45:00', 1, 1),
	(2, '2024-09-03', '18:30:00', '21:00:00', 2, 2),
	(3, '2024-09-04', '21:00:00', '23:50:00', 3, 5);

INSERT INTO Voto (ID_Voto, Valutazione, CF_Votante, ID_Film) VALUES
	(1, 9, 'GNBNCH75C03H501C', 1),
	(2, 8, 'PLNREE65D04H501D', 1),
	(3, 10, 'MRRRSS80A01H501A', 1),
	(4, 7, 'LGGVRD90B02H501B', 2),
	(5, 9, 'MRRRSS80A01H501A', 3);