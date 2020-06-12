CREATE PROCEDURE "${synchro.schema}"."/SYN/P_GERA_DIEF_PI"(
    pMandt VARCHAR(3),
    pFilial VARCHAR(30),
    pEmpresa VARCHAR(100),
    pDtInicio DATE,
    pDtFim DATE,
    pProcessoID integer)
AS
BEGIN

    DECLARE v_conteudo       				VARCHAR(4000);
	DECLARE vCountLinha      		 		INTEGER DEFAULT 1;
/*	
	
	--VARIAVEIS DE PARAMETROS
	

	--CURSOR
	DECLARE CURSOR cREGISTRO_TIPO_10 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		
	DECLARE CURSOR cREGISTRO_TIPO_11 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
	
	DECLARE CURSOR cREGISTRO_TIPO_50 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_51 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
	DECLARE CURSOR cREGISTRO_TIPO_53 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_54 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_70 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    

	DECLARE CURSOR cREGISTRO_TIPO_74 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;

	DECLARE CURSOR cREGISTRO_TIPO_75 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    

	DECLARE CURSOR cREGISTRO_TIPO_90 FOR
	    select 
	
		from "${synchro.schema}"."/SYN/"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;



    -------------------------------------------------------------------------------------------------------------------------------------
	    -- Tratamento de erros
		-------------------------------------------------------------------------------------------------------------------------------------

	    DECLARE EXIT HANDLER FOR SQL_ERROR_CODE 288
	    BEGIN
	        UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "${synchro.schema}"."/SYN/P_SYS_LOG_ERROR"('SYS', '"${synchro.schema}"."/SYN/P_GERA_DIF_TO"', 'SQL ERRO ' || ::SQL_ERROR_CODE || ': ' || ::SQL_ERROR_MESSAGE);
	        RESIGNAL;
	    END;

	    --
	    -- Adiciona tratamento do erro: no data found
	    -- Remove tabela temporaria e adiciona mensagem no log
	    --
	    DECLARE EXIT HANDLER FOR SQL_ERROR_CODE 1299
	    BEGIN
	        UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "${synchro.schema}"."/SYN/P_SYS_LOG_ERROR"('SYS', '"${synchro.schema}"."/SYN/P_GERA_DIF_TO"', 'No data found');
	    END;

	    --
	    -- Adiciona tratamento de generico para todos erros
	    -- Remove tabela temporaria, adiciona mensagem no log e relan?a erro para notificar o chamador da proc
	    --
	    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	    BEGIN
	        UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "${synchro.schema}"."/SYN/P_SYS_LOG_ERROR"('SYS', '"${synchro.schema}"."/SYN/P_GERA_DIF_TO"', 'SQL ERRO ' || ::SQL_ERROR_CODE || ': ' || ::SQL_ERROR_MESSAGE);
	        RESIGNAL;
	    END;

	    UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET  STATUS = 'EXECUTANDO'  where id = pProcessoID;

		-------------------------------------------------------------------------------------------------------	
		--BUSCA DE PARAMETROS
		-------------------------------------------------------------------------------------------------------
		

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_10
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_10 AS cREGISTRO_TIPO_10 DO

			v_conteudo = ''; 
			
			
		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;

	    END FOR;
		
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_11
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_11 AS cREGISTRO_TIPO_11 DO

			v_conteudo = ' ';
			

		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
	    END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_50
		-------------------------------------------------------------------------------------------------------------------------------------
	    
	    FOR dREGISTRO_TIPO_50 AS cREGISTRO_TIPO_50 DO
	    	
	    	v_conteudo = ' ';
	    	
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;	
	    	   

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_51
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_51 AS cREGISTRO_TIPO_51 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;	
		 
	 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_52
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_52 AS cREGISTRO_TIPO_52 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;

   		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_53
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_53 AS cREGISTRO_TIPO_53 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_54
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_54 AS cREGISTRO_TIPO_54 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_70
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_70 AS cREGISTRO_TIPO_70 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_74
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_74 AS cREGISTRO_TIPO_74 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_75
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_75 AS cREGISTRO_TIPO_75 DO
	    	
	    	v_conteudo = ' ';
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
    	-- REGISTRO_TIPO_90
    	-------------------------------------------------------------------------------------------------------------------------------------
    	FOR dREGISTRO_TIPO_90 AS cREGISTRO_TIPO_90 DO

        	v_conteudo = ' '; 
        	
        
        	CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);

    	END FOR;
		
		
	    ------------------------------------------------------------------------------------------------------------------------------------
	  	-- Update do Status da geracao
	    -------------------------------------------------------------------------------------------------------------------------------------

    	UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'GERADO'  where id = pProcessoID;

    	COMMIT;
*/	    

END