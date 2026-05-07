USE FestivalCinematografico;

-- Op. 1: Inserimento di un nuovo film e assegnazione alla sezione
INSERT INTO Film (Titolo, Durata, Sinossi, Nazionalita, AnnoProduzione, ID_Sezione) 
VALUES ('Joker: Folie a Deux', 138, 'Arthur Fleck incontra Harley Quinn...', 'USA', 2024, 1);

-- Op. 2: Inserimento di un nuovo ospite, associazione ai film e creazione scheda logistica
CALL RegistraOspiteCompleto(
    'JPQXWN85M28H501J', 'Joaquin', 'Phoenix', '1974-10-28', 
    'Attore Protagonista', 'Hotel Danieli', 'Motoscafo Privato', 
    'Dal 02-09 al 06-09', 4
);

-- Op. 3: Registrazione e valutazione (approvazione) di una richiesta di accredito
CALL ValutaAccredito('LSSRSO92F06H501F', 'Approvato');

-- Op. 4: Inserimento di una proiezione in una sala
CALL PianificaProiezione('2024-09-05', '21:00:00', '23:30:00', 4, 1);

-- Op. 5: Inserimento di un voto da parte di un membro della giuria o del pubblico
INSERT INTO Voto (Valutazione, CF_Votante, ID_Film) 
VALUES (8, 'MRRRSS80A01H501A', 4);

-- Op. 6: Individuare le proiezioni programmate in una specifica data
SELECT p.Ora_Inizio, p.Ora_Fine, f.Titolo, s.Nome_Sala
FROM Proiezione p
JOIN Film f ON p.ID_Film = f.ID_Film
JOIN Sala s ON p.ID_Sala = s.ID_Sala
WHERE p.Data = '2024-09-03'
ORDER BY p.Ora_Inizio ASC;

-- Op. 7: Elencare i film appartenenti a una determinata sezione
SELECT f.Titolo, f.Durata, f.Nazionalita, f.AnnoProduzione
FROM Film f
JOIN Sezione s ON f.ID_Sezione = s.ID_Sezione
WHERE LOWER(s.Nome) LIKE '%concorso%'
ORDER BY f.Titolo ASC;

-- Op. 8: Calcolo del totale dei voti e della media per un determinato film
SELECT f.Titolo, COUNT(v.ID_Voto) AS Totale_Voti_Ricevuti, ROUND(AVG(v.Valutazione), 2) AS Media_Valutazione
FROM Film f
LEFT JOIN Voto v ON f.ID_Film = v.ID_Film
WHERE f.ID_Film = 1
GROUP BY f.ID_Film, f.Titolo;

-- Op. 9: Assegnazione formale del Premio al film vincitore di una sezione
INSERT INTO Premio (Nome_Premio, ID_Film)
VALUES ('Leone d''Oro Miglior Film', 1);
