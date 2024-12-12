DELIMITER //
CREATE TRIGGER Rn5
BEFORE INSERT ON AceiteOliva
FOR EACH ROW
BEGIN
    IF (SELECT denominacion FROM DenominacionOrigen 
        JOIN Marca ON Marca.denominacionID = DenominacionOrigen.denominacionID 
        WHERE Marca.marcaID = NEW.marcaID) = 'Baena'
    AND NEW.tipoAceite != 'AOV' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'RN5: Las marcas asociadas a Baena solo pueden comercializar AOV.';
    END IF;
END;
DELIMITER ;