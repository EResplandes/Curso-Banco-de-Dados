DELIMITER //
CREATE PROCEDURE sp_update_departamento (nome_depart VARCHAR(35), novo_nome_depart VARCHAR(35), OUT resultado VARCHAR(50))
BEGIN
	
	-- Declarando Variáveis 
	DECLARE valida_departamento VARCHAR(50);
    DECLARE msg_erro_departamento VARCHAR (50);
    DECLARE msg_sucesso VARCHAR(50);
	DECLARE msg_row VARCHAR(50);
    DECLARE msg_nulo VARCHAR(50);
    DECLARE msg_branco VARCHAR(50);
    DECLARE qtd_row INT(11);

    
    -- Setando Variáveis
    SET valida_departamento = (SELECT nome_departamento FROM departamento WHERE nome_departamento = nome_depart);
	SET qtd_row = (count_row(valida_departamento));
    SET msg_erro_departamento = ('O departamento não foi encontado!');
    SET msg_sucesso = ('O nome do departamento foi alterado com sucesso!');
    SET msg_row = ('Foram encontrados mais de 1 departamento, seja mais especifico!');
    SET msg_nulo = ('O nome do departamento não pode ser nulo');
    SET msg_branco = ('O nome do departamento não pode ser em branco');
   
	START TRANSACTION;
    
    -- Valida a quantidade de resultados obitidos
    IF (qtd_row > 1) THEN
		ROLLBACK; # desfaz a transação
		SET resultado = msg_row;
		SELECT msg_row;
	END IF;
    
    -- Validações do nome
    IF (valida_departamento != nome_depart) THEN
		ROLLBACK; # desfaz a transação
        SET resultado = msg_erro_departamento;
        SELECT resultado;
	ELSEIF (nome_depart IS NULL) THEN
		ROLLBACK; # desfaz a transação
        SET resultado = msg_nulo;
        SELECT resultado;
	ELSEIF (nome_depart = '') THEN
		ROLLBACK; # desfaz a transação
        SET resultado = msg_branco;
        SELECT resultado;
	ELSE 
		UPDATE departamento SET nome_departamento = FN_primeira_maiuscula(novo_nome_depart) WHERE nome_departamento = nome_depart;
		COMMIT;
        SET resultado = msg_sucesso;
        SELECT msg_sucesso;
    END IF;
    
END //
DELIMITER ;


CALL sp_update_departamento ('', 'Artes', @resultado);
DROP PROCEDURE sp_update_departamento;
SELECT * FROM departamento;