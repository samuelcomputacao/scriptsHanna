CREATE  PROCEDURE "${synchro.schema}"."/SYN/P_GERA_DIEF_PI"(
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
	DECLARE vContTipo10						INTEGER DEFAULT 0;
	DECLARE vContTipo11						INTEGER DEFAULT 0;
	DECLARE vContTipo50						INTEGER DEFAULT 0;
	DECLARE vContTipo51						INTEGER DEFAULT 0;
	DECLARE vContTipo53						INTEGER DEFAULT 0;
	DECLARE vContTipo54						INTEGER DEFAULT 0;
	DECLARE vContTipo70						INTEGER DEFAULT 0;
	DECLARE vContTipo74						INTEGER DEFAULT 0;
	DECLARE vContTipo75						INTEGER DEFAULT 0;
	DECLARE vContTipo90						INTEGER DEFAULT 0;
	DECLARE vContTamanho90					INTEGER DEFAULT 126;
	DECLARE vConteudo90						NVARCHAR(1000);
	DECLARE vRestTipo90						INTEGER DEFAULT 0;
	DECLARE vTotalTipo90					INTEGER DEFAULT 0;
	DECLARE vIndexTipo90					INTEGER DEFAULT 0;
	DECLARE vContAux						INTEGER DEFAULT 0;
	
	--VARIAVEIS DE PARAMETROS
	DECLARE vTIPO_DECLARACAO NVARCHAR(1);
	
	

	--CURSOR
	DECLARE CURSOR cREGISTRO_TIPO_10 FOR
	    select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"CNPJ",
		"IE",
		"NOME_ESTABELEC",
		"DESC_MUNICIPIO",
		"UF",
		"FONE",
		"DT_INI",
		"DT_FIN"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_10"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		
	DECLARE CURSOR cREGISTRO_TIPO_11 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"ENDERECO",
		"NUMERO",
		"COMPLEMENTO",
		"BAIRRO",
		"CEP",
		"NOME_CONTAB",
		"FONE_CONTAB",
		"DT_INI",
		"DT_FIN"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_11"
		WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
	
	DECLARE CURSOR cREGISTRO_TIPO_50 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"CNPJ_CPF",
		"IE",
		"DT_E_S",
		"UF",
		"COD_MOD",
		"SER",
		"NUM_DOC",
		"CFOP",
		"IND_EMIT",
		"VL_TOTAL_DOCUMENTO",
		"VL_BC_ICMS",
		"VL_ICMS",
		"VL_BC_EXC_ICMS",
		"VL_BC_OUTRAS_ICMS",
		"ALIQ_ICMS",
		"COD_SIT",
		"DT_INI",
		"DT_FIN"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_50"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_51 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"DT_INI",
		"DT_FIN",
		"CNPJ_CPF",
		"IE",
		"DT_E_S",
		"UF",
		"SER",
		"NUM_DOC",
		"CFOP",
		"VL_TOTAL_DOCUMENTO",
		"VL_IPI",
		"VL_BC_EXC_IPI",
		"VL_BC_OUTRAS_IPI",
		"COD_SIT"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_51"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
	DECLARE CURSOR cREGISTRO_TIPO_53 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"DT_INI",
		"DT_FIN",
		"CNPJ_CPF",
		"IE",
		"DT_E_S",
		"UF",
		"COD_MOD",
		"SER",
		"NUM_DOC",
		"CFOP",
		"IND_EMIT",
		"VL_BC_ICMSST",
		"VL_ICMSST",
		"VL_OUT_DA",
		"COD_SIT"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_53"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_54 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"DT_INI",
		"DT_FIN",
		"CNPJ_CPF",
		"COD_MOD",
		"SER",
		"NUM_DOC",
		"CFOP",
		"CST_ICMS",
		"NUM_ITEM",
		"COD_ITEM",
		"QTD",
		"VL_ITEM",
		"VL_DA",
		"VL_BC_ICMS",
		"VL_BC_ICMSST",
		"VL_IPI",
		"ALIQ_ICMS"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_54"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    
		    
	DECLARE CURSOR cREGISTRO_TIPO_70 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"CNPJ",
		"IE",
		"DT_DOC",
		"UF",
		"COD_MOD",
		"SER",
		"SUB",
		"NUM_DOC",
		"CFOP",
		"VL_DOC",
		"VL_BC_ICMS",
		"VL_ICMS",
		"VL_NT",
		"VL_OUT",
		"IND_FRT",
		"COD_SIT",
		"DT_INI",
		"DT_FIN"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_70"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    

	DECLARE CURSOR cREGISTRO_TIPO_74 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"DT_INI",
		"DT_FIN",
		"DT_INV",
		"COD_ITEM",
		"QTD",
		"VL_UNIT",
		"IND_PROP",
		"CNPJ",
		"IE",
		"UF"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_74"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;

	DECLARE CURSOR cREGISTRO_TIPO_75 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"DT_INI",
		"DT_FIN",
		"COD_ITEM",
		"NCM",
		"DESCR_COMPL",
		"UNID",
		"CST_ICMS",
		"ALIQ_IPI",
		"ALIQ_ICMS",
		"VL_BC_ICMSST"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_75"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;		    

	DECLARE CURSOR cREGISTRO_TIPO_90 FOR
		select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"CNPJ",
		"IE",
		"DT_INI",
		"DT_FIN"
		from "${synchro.schema}"."/SYN/DIEF_PI_REGISTRO_TIPO_90"
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
	    -- Remove tabela temporaria, adiciona mensagem no log e relan?a erro para notIFicar o chamador da proc
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
		vTIPO_DECLARACAO = IFnull("${synchro.schema}"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'TIPO_DECLARACAO'),'1');

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_10
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_10 AS cREGISTRO_TIPO_10 DO

			v_conteudo = '10'; 
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_10.CNPJ,14,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_10.CNPJ,14,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_10.NOME_ESTABELEC,35,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_10.DESC_MUNICIPIO,30,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_10.UF,2,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_10.FONE,10,0);
			v_conteudo = v_conteudo || RPAD(TO_VARCHAR(dREGISTRO_TIPO_10.DT_INI, 'YYYYMMDD'),8,' ');
			v_conteudo = v_conteudo || RPAD(TO_VARCHAR(dREGISTRO_TIPO_10.DT_FIN, 'YYYYMMDD'),8,' ');
			v_conteudo = v_conteudo || '33';
			v_conteudo = v_conteudo || LPAD(vTIPO_DECLARACAO,1,0);
			
			
		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1 ;
			vContTipo10 := vContTipo10 + 1;

	    END FOR;
		
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_11
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_11 AS cREGISTRO_TIPO_11 DO

			v_conteudo = '11'; 
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_11.ENDERECO,34,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_11.NUMERO,5,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_11.COMPLEMENTO,22,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_11.BAIRRO,15,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_11.CEP,8,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_11.NOME_CONTAB,28,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_11.FONE_CONTAB,12,0);

		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo11 := vContTipo11 + 1;
			
	    END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_50
		-------------------------------------------------------------------------------------------------------------------------------------
	    
	    FOR dREGISTRO_TIPO_50 AS cREGISTRO_TIPO_50 DO
	    	
			v_conteudo = '50'; 
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.CNPJ_CPF,14,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.IE,14,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.DT_E_S,8,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.UF,2,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.COD_MOD,2,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.SER,3,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.NUM_DOC,6,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.CFOP,4,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.IND_EMIT,1,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.VL_TOTAL_DOCUMENTO,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.VL_BC_ICMS,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.VL_ICMS,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.VL_BC_EXC_ICMS,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.VL_BC_OUTRAS_ICMS,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_50.ALIQ_ICMS,4,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_50.COD_SIT,1,' ');

		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo50 := vContTipo50 + 1;
			
		 END FOR;	
	    	   

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_51
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_51 AS cREGISTRO_TIPO_51 DO
	    	IF dREGISTRO_TIPO_51.VL_IPI <> 0 THEN
	    		v_conteudo = '51';
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.CNPJ_CPF, 14 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.IE, 14 ,' ');
	    		v_conteudo = v_conteudo || RPAD(TO_VARCHAR(dREGISTRO_TIPO_51.DT_E_S,'YYYYMMDD'), 8 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.UF, 2 ,' ');	    		
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.SER, 3 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.NUM_DOC, 6 ,' ');	    		
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.CFOP, 4 ,' ');
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_51.VL_TOTAL_DOCUMENTO, 13 ,0);
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_51.VL_IPI, 13 ,0);
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_51.VL_BC_EXC_IPI, 13 ,0);
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_51.VL_BC_OUTRAS_IPI, 13 ,0);
	    		v_conteudo = v_conteudo || RPAD(' ', 20 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_51.COD_SIT, 1 ,' ');
	    		    					
				CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
				vCountLinha := vCountLinha +1;
				vContTipo51 := vContTipo51 + 1;
			END IF;
		 END FOR;	
		 
	 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_53
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_53 AS cREGISTRO_TIPO_53 DO	
	    	IF dREGISTRO_TIPO_53.VL_ICMSST <> 0 THEN
	    		v_conteudo = '53';
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.CNPJ_CPF, 14 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.IE, 14 ,' ');
	    		v_conteudo = v_conteudo || RPAD(TO_VARCHAR(dREGISTRO_TIPO_53.DT_E_S,'YYYYMMDD'), 8 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.UF, 2 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.COD_MOD, 2 ,' ');	    			    		
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.SER, 3 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.NUM_DOC, 6 ,' ');	    		
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.CFOP, 4 ,' ');
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.IND_EMIT, 1 ,' ');
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_53.VL_BC_ICMSST, 13 ,0);
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_53.VL_ICMSST, 13 ,0);
	    		v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_53.VL_OUT_DA, 13 ,0);
	    		v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_53.COD_SIT, 1 ,' ');
	    		--FALTA O COD_ANTECIPACAO DA TELA DE PARÂMETROS	    		
	    		v_conteudo = v_conteudo || RPAD(' ', 29 ,' ');	    		    					
				CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
				vCountLinha := vCountLinha +1;
				vContTipo53 := vContTipo53 + 1;
			END IF;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_54
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_54 AS cREGISTRO_TIPO_54 DO
	    	
	    	v_conteudo = '54';
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.CNPJ_CPF, 14 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.COD_MOD, 2 ,0);	    			    		
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_54.SER, 3 ,' ');
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.NUM_DOC, 6 ,0);	    		
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.CST_ICMS, 3 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.NUM_ITEM, 3 ,0);
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_54.COD_ITEM, 14 ,' ');
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.QTD, 11 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.VL_ITEM, 12 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.VL_DA, 12,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.VL_BC_ICMS, 13 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.VL_BC_ICMSST, 13 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.VL_IPI, 13 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_54.ALIQ_ICMS, 13 ,0);
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo54 := vContTipo54 + 1;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_70
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_70 AS cREGISTRO_TIPO_70 DO
	    	  	
			v_conteudo = '70'; 
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.CNPJ,14,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.IE,14,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.DT_DOC,8,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.UF,2,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.COD_MOD,2,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.SER,3,' ');
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.SUB,2,' ');
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.NUM_DOC,6,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.CFOP,4,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.VL_DOC,13,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.VL_BC_ICMS,14,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.VL_ICMS,14,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.VL_NT,14,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.VL_OUT,14,0);
			v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_70.IND_FRT,1,0);
			v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_70.COD_SIT,1,' ');

		    CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo70 := vContTipo70 + 1;
			
		 END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_74
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_74 AS cREGISTRO_TIPO_74 DO
	    	
			v_conteudo = '74';
	    	v_conteudo = v_conteudo || RPAD(TO_VARCHAR(dREGISTRO_TIPO_74.DT_INV,'YYYYMMDD'), 8 ,' ');
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_74.COD_ITEM,14 ,' ');	    		
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_74.QTD, 13 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_74.VL_UNIT, 13 ,0);	    	
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_74.IND_PROP, 1 ,' ');
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_74.CNPJ, 14 ,0);	    	
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_74.IE, 14 ,' ');
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_74.UF, 2 ,' ');
	    	v_conteudo = v_conteudo || RPAD(' ', 45 ,' ');	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo74 := vContTipo74 + 1;
		 END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- REGISTRO_TIPO_75
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dREGISTRO_TIPO_75 AS cREGISTRO_TIPO_75 DO
	    	
			v_conteudo = '75';
	    	--BUSCA DE PARÂMETROS
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_75.COD_ITEM,14 ,' ');	    		
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_75.NCM, 8 ,' ');
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_75.DESCR_COMPL, 53 ,' ');	    	
	    	v_conteudo = v_conteudo || RPAD(dREGISTRO_TIPO_75.UNID, 6 ,' ');
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_75.CST_ICMS, 3 ,0);	    	
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_75.ALIQ_IPI, 4 ,0);
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_75.ALIQ_ICMS, 4 ,0);
	    	--BUSCA DE PARâMETROS
	    	v_conteudo = v_conteudo || LPAD(dREGISTRO_TIPO_75.VL_BC_ICMSST, 13 ,0);
	    	
			
			CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
			vContTipo75 := vContTipo75 + 1;
		 END FOR;
		 
		-------------------------------------------------------------------------------------------------------------------------------------
    	-- REGISTRO_TIPO_90
    	-------------------------------------------------------------------------------------------------------------------------------------
    	FOR dREGISTRO_TIPO_90 AS cREGISTRO_TIPO_90 DO
			vContTamanho90 := 126;
			
        	vConteudo90 = '90'; 
        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
        	
        	vContTamanho90 := vContTamanho90 - 30;
        	
        	IF vContTipo50 > 0 THEN
        		IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
   
        		vConteudo90 = vConteudo90 || '50' || LPAD(vContTipo50,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo51 > 0 THEN
        		IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        		vConteudo90 = vConteudo90 || '51' || LPAD(vContTipo51,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo53 > 0 THEN
        	    IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        	
        		vConteudo90 = vConteudo90 || '53' || LPAD(vContTipo53,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo54 > 0 THEN
        	    IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        	
        		vConteudo90 = vConteudo90 || '54' || LPAD(vContTipo54,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo70 > 0 THEN
        	     IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        	
        		vConteudo90 = vConteudo90 || '70' || LPAD(vContTipo70,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo74 > 0 THEN
        	     IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        	
        		vConteudo90 = vConteudo90 || '74' || LPAD(vContTipo74,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	IF vContTipo75 > 0 THEN
        	    IF vContTamanho90 - 11 < 0 THEN
        			vRestTipo90 :=  126 - vContTamanho90;
        			
        			vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        			vContTamanho90 := 126;
        			vContTipo90 := vContTipo90 + 1;
        			vConteudo90 = vConteudo90 || '90'; 
		        	vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        	vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        	vContTamanho90 := vContTamanho90 - 30;
	
		        END IF;
        	
        		vConteudo90 = vConteudo90 || '75' || LPAD(vContTipo75,8,0);
        		vContTamanho90 := vContTamanho90 - 10;
        	END IF;
        	
        	IF vContTamanho90 - 11 < 0 THEN
        		vRestTipo90 :=  126 - vContTamanho90;
        			
        		vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        			
        		vContTamanho90 := 126;
        		vContTipo90 := vContTipo90 + 1;
        		vConteudo90 = vConteudo90 || '90'; 
		        vConteudo90 = vConteudo90 || LPAD(dREGISTRO_TIPO_90.CNPJ,14,0);
		        vConteudo90 = vConteudo90 || RPAD(dREGISTRO_TIPO_90.IE,14,' ');
		        vContTamanho90 := vContTamanho90 - 30;
		    END IF;
		    
        	vTotalTipo90 := vContTipo10 + vContTipo11 + vContTipo50 + vContTipo51 + vContTipo53 + vContTipo54 + vContTipo70 + vContTipo74 + vContTipo75;
        	vConteudo90 = vConteudo90 || '99' || LPAD(vTotalTipo90,8,0);
        	vRestTipo90 :=  126 - vContTamanho90;
        	vConteudo90 = vConteudo90 || RPAD(' ',vRestTipo90,' ');
        
	       	vIndexTipo90 := 1;
			vContAux     := 0;
			v_conteudo = '';
	        WHILE (vContTipo90 - vContAux) >= 0 DO
	        	v_conteudo = v_conteudo || RPAD(SUBSTRING(vConteudo90,vIndexTipo90,125),125,' ') || LPAD(vContTipo90,1,0);
	        	vIndexTipo90 := vIndexTipo90 + 127;
	        	vContAux := vContAux + 1;
	        END WHILE;
        
        	CALL "${synchro.schema}"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
        	vCountLinha := vCountLinha +1;
			
    	END FOR;
		
		
	    ------------------------------------------------------------------------------------------------------------------------------------
	  	-- Update do Status da geracao
	    -------------------------------------------------------------------------------------------------------------------------------------

    	UPDATE "${synchro.schema}"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'GERADO'  where id = pProcessoID;

    	COMMIT;
   
END