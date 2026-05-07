USE FestivalCinematografico;

-- Cambiamo il delimitatore per poter scrivere blocchi di codice
DELIMITER //

-- ==============================================================================
-- TRIGGER 1: Evitare sovrapposizioni di orario per le proiezioni nella stessa sala
-- ==============================================================================
CREATE TRIGGER TRG_CheckSovrapposizione_Insert
BEFORE INSERT ON Proiezione
FOR EACH ROW
BEGIN
    DECLARE num_sovrapposizioni INT;
    
    -- Conta se esistono già proiezioni nella stessa sala, lo stesso giorno, 
    -- con orari che si intersecano con quelli della nuova proiezione.
    SELECT COUNT(*) INTO num_sovrapposizioni
    FROM Proiezione
    WHERE ID_Sala = NEW.ID_Sala
      AND Data = NEW.Data
      AND (NEW.Ora_Inizio < Ora_Fine AND NEW.Ora_Fine > Ora_Inizio);
      
    -- Se trova almeno una sovrapposizione, blocca l'inserimento
    IF num_sovrapposizioni > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore di Inserimento: La sala selezionata è già occupata in questa fascia oraria!';
    END IF;
END //

-- ==============================================================================
-- TRIGGER 2: Garantire che solo Giuria e Pubblico possano inserire un Voto
-- ==============================================================================
CREATE TRIGGER TRG_CheckDirittoVoto_Insert
BEFORE INSERT ON Voto
FOR EACH ROW
BEGIN
    DECLARE is_pubblico INT;
    DECLARE is_giuria INT;
    
    -- Verifica se il CF di chi sta votando esiste nella tabella Pubblico
    SELECT COUNT(*) INTO is_pubblico 
    FROM Pubblico 
    WHERE CF = NEW.CF_Votante;
    
    -- Verifica se il CF di chi sta votando esiste nella tabella Giuria
    SELECT COUNT(*) INTO is_giuria 
    FROM Giuria 
    WHERE CF = NEW.CF_Votante;
    
    -- Se il CF non è presente in nessuna delle due tabelle, blocca l'inserimento
    IF is_pubblico = 0 AND is_giuria = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Errore di Inserimento: Solo i membri della Giuria o del Pubblico registrato hanno il diritto di votare!';
    END IF;
END //

-- Ripristiniamo il delimitatore standard
DELIMITER ;