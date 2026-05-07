USE FestivalCinematografico;

DELIMITER //

-- =========================================
-- PROCEDURA 1: Registra Ospite Completo
-- =========================================
CREATE PROCEDURE RegistraOspiteCompleto(
    IN p_CF VARCHAR(16), 
    IN p_Nome VARCHAR(50), 
    IN p_Cognome VARCHAR(50), 
    IN p_DataNascita DATE,
    IN p_Ruolo VARCHAR(50),
    IN p_Hotel VARCHAR(100), 
    IN p_Trasporto VARCHAR(100), 
    IN p_Periodo VARCHAR(50),
    IN p_ID_Film INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    INSERT INTO Persona (CF, Nome, Cognome, DataNascita) 
    VALUES (p_CF, p_Nome, p_Cognome, p_DataNascita);
    
    INSERT INTO Ospite (CF, Ruolo) 
    VALUES (p_CF, p_Ruolo);
    
    INSERT INTO Logistica (Hotel, Trasporto, Periodo_di_Permanenza, CF_Ospite) 
    VALUES (p_Hotel, p_Trasporto, p_Periodo, p_CF);
    
    INSERT INTO Partecipazione (CF_Ospite, ID_Film) 
    VALUES (p_CF, p_ID_Film);

    COMMIT;
END //

-- =========================================
-- PROCEDURA 2: Valuta Accredito
-- =========================================
CREATE PROCEDURE ValutaAccredito(
    IN p_CF_Richiedente VARCHAR(16),
    IN p_NuovoStato VARCHAR(20)
)
BEGIN
    DECLARE richiedente_esiste INT;

    SELECT COUNT(*) INTO richiedente_esiste
    FROM Richiedente
    WHERE CF = p_CF_Richiedente;

    IF richiedente_esiste = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Richiedente non trovato!';
    END IF;

    IF p_NuovoStato NOT IN ('In attesa', 'Approvato', 'Rifiutato') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stato non valido!';
    END IF;

    UPDATE Richiedente
    SET StatoRichiesta = p_NuovoStato
    WHERE CF = p_CF_Richiedente;

END //

-- =========================================
-- PROCEDURA 3: Pianifica Proiezione
-- =========================================
CREATE PROCEDURE PianificaProiezione(
    IN p_Data DATE,
    IN p_OraInizio TIME,
    IN p_OraFine TIME,
    IN p_ID_Film INT,
    IN p_ID_Sala INT
)
BEGIN
    INSERT INTO Proiezione (Data, Ora_Inizio, Ora_Fine, ID_Film, ID_Sala)
    VALUES (p_Data, p_OraInizio, p_OraFine, p_ID_Film, p_ID_Sala);
END //

DELIMITER ;
