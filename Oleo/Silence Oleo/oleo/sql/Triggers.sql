DELIMITER //

CREATE OR REPLACE TRIGGER RN_2
BEFORE DELETE ON AceitesOliva
FOR EACH ROW
	BEGIN
	
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede borrar una instancia de Aceite de Oliva';
	
	END //

DELIMITER ;