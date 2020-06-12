CREATE PROCEDURE "SYN4TDF_EVOLUCAO"."/SYN/P_GERA_DIF_TO"(
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
	
	
	--VARIAVEIS DE PARAMETROS
	DECLARE vRETIFICACAO NVARCHAR(1);
	DECLARE vFINALIDADE NUMBER(1);
	DECLARE vTP_ESCRITURACAO NVARCHAR(1);
	DECLARE vSALDO_INI_CAIXA DECIMAL;
	DECLARE vSALDO_FIN_CAIXA DECIMAL;
	DECLARE vPATRIMONIO_LIQUIDO NUMBER(14);
	DECLARE vMUDANCA_DOMIC_ANTERIOR NVARCHAR(1);
	DECLARE vCOD_MUN_AT_ANT NVARCHAR(1);
	DECLARE vDT_INI_CIDADE_AT_ANT NVARCHAR(8);
	DECLARE vDT_FIN_CIDADE_AT_ANT NVARCHAR(8);

	DECLARE CURSOR cSEGMENTO_A FOR
	    select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"IE",
		"CNAE",
		"CA_TP_ESTABELEC",
		"COD_MUN_ESTABELEC",
		"NOME_CONTAB",
		"CPF_CONTAB",
		"DT_INI",
		"DT_FIN"
		from "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_A"
		where MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;

	DECLARE CURSOR cSEGMENTO_B FOR
	    select 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"IE",
		"DT_INI",
		"DT_FIN"
		from "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_B"
	    WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
	DECLARE CURSOR cSEGMENTO_C FOR
		SELECT 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"COD_MUN_ESTABELEC",
		"CA_VL_ISENTO_OUTROS",
		"VL_ICMS_ST",
		"VL_CONTABIL",
		"VL_BASE_CALCULO",
		"IE",
		"DT_INI",
		"DT_FIN",
		"COD_ENTRADA"
	 	FROM "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_C"
	 	WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
	
	DECLARE CURSOR cSEGMENTO_D FOR
		SELECT 
		"MANDT",
		"EMPRESA",
		"FILIAL",
		"IE",
		"COD_MUN_ESTABELEC",
		"UF",
		"VL_CONTABIL",
		"VL_BASE_CALCULO",
		"VL_ICMS_ST",
		"CA_VL_ISENTO_OUTROS",
		"DT_INI",
		"DT_FIN"
	 	FROM "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_D"
	 	WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
		    
	DECLARE CURSOR cSEGMENTO_E FOR
		SELECT "MANDT", "EMPRESA", "FILIAL", "IE", "COD_ENTRADA", "COD_MUN_ESTABELEC",
			"VL_CONTABIL", "VL_BASE_CALCULO", "CA_OUTRAS_ISENTAS", "VL_ICMS_ST",
			"DT_INI", "DT_FIN"
			 from "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_E"
	 	WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
 

    DECLARE CURSOR cSEGMENTO_F FOR
		SELECT 
		"MANDT",
		"EMPRESA",
		"FILIAL",
    	"COD_MUN_ESTABELEC",
		"IE",
		"CA_VL_ISENTO_OUTROS",
		"UF",
		"CA_VL_CONTAB_CONTRIB",
		"CA_VL_CONTAB_N_CONTRIB",
		"CA_BASE_CALC_CONTRIB",
		"CA_BASE_CALC_N_CONTRIB",
    	"CA_SUBST_TRIB",
    	"CA_ICMS_SUBST_TRIB",
		"DT_INI",
		"DT_FIN"
	 	FROM "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_F"
	 	WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;
		    
	DECLARE CURSOR cSEGMENTO_K FOR
		SELECT 
        "MANDT",
        "EMPRESA",
        "FILIAL",
        "DT_INI",
        "DT_FIN",
        "IE",
        "COD_MUN_ESTABELEC",
        "VL_ICMS_ST",
        "VL_OUTROS",
        "VL_BASE_CALCULO",
        "VL_CONTABIL",
        "TIPO_ENTRADA",
        "CFOP_CODIGO"
        FROM "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_K"
	 	WHERE MANDT = pMandt
		    AND EMPRESA = pEmpresa
		    AND FILIAL = pFilial
		    AND DT_INI = pDtInicio
		    AND DT_FIN = pDtFim;

	DECLARE CURSOR cSEGMENTO_Z FOR
		SELECT 
    	"MANDT",
    	"EMPRESA",
    	"FILIAL",
    	"IE",
    	"DT_INI",
    	"DT_FIN"
 		FROM "SYN4TDF_EVOLUCAO"."/SYN/DIF_TO_SEGMENTO_Z"
 		WHERE MANDT = pMandt
    		AND EMPRESA = pEmpresa
    		AND FILIAL = pFilial
    		AND DT_INI = pDtInicio
    		AND DT_FIN = pDtFim;

    -------------------------------------------------------------------------------------------------------------------------------------
	    -- Tratamento de erros
		-------------------------------------------------------------------------------------------------------------------------------------

	    DECLARE EXIT HANDLER FOR SQL_ERROR_CODE 288
	    BEGIN
	        UPDATE "SYN4TDF_EVOLUCAO"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "SYN4TDF_EVOLUCAO"."/SYN/P_SYS_LOG_ERROR"('SYS', '"SYN4TDF_EVOLUCAO"."/SYN/P_GERA_DIF_TO"', 'SQL ERRO ' || ::SQL_ERROR_CODE || ': ' || ::SQL_ERROR_MESSAGE);
	        RESIGNAL;
	    END;

	    --
	    -- Adiciona tratamento do erro: no data found
	    -- Remove tabela temporaria e adiciona mensagem no log
	    --
	    DECLARE EXIT HANDLER FOR SQL_ERROR_CODE 1299
	    BEGIN
	        UPDATE "SYN4TDF_EVOLUCAO"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "SYN4TDF_EVOLUCAO"."/SYN/P_SYS_LOG_ERROR"('SYS', '"SYN4TDF_EVOLUCAO"."/SYN/P_GERA_DIF_TO"', 'No data found');
	    END;

	    --
	    -- Adiciona tratamento de generico para todos erros
	    -- Remove tabela temporaria, adiciona mensagem no log e relan?a erro para notificar o chamador da proc
	    --
	    DECLARE EXIT HANDLER FOR SQLEXCEPTION
	    BEGIN
	        UPDATE "SYN4TDF_EVOLUCAO"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'FALHA'  where id = pProcessoID;
	        CALL "SYN4TDF_EVOLUCAO"."/SYN/P_SYS_LOG_ERROR"('SYS', '"SYN4TDF_EVOLUCAO"."/SYN/P_GERA_DIF_TO"', 'SQL ERRO ' || ::SQL_ERROR_CODE || ': ' || ::SQL_ERROR_MESSAGE);
	        RESIGNAL;
	    END;

	    UPDATE "SYN4TDF_EVOLUCAO"."/SYN/PROCESS_DECLARATION" SET  STATUS = 'EXECUTANDO'  where id = pProcessoID;

		-------------------------------------------------------------------------------------------------------	
		--BUSCA DE PARAMETROS
		-------------------------------------------------------------------------------------------------------
		vRETIFICACAO = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'DECLARACAO_RETIFICADA'),' ');
		vFINALIDADE = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'FINALIDADE'),0);
		vTP_ESCRITURACAO = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'TP_ESCRITURACAO'),' ');
		vSALDO_INI_CAIXA = ifnull(TO_DECIMAL(REPLACE("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'SALDO_INI_CAIXA'),',','.')),0);
		vSALDO_FIN_CAIXA = ifnull(TO_DECIMAL(REPLACE("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'SALDO_FIN_CAIXA'),',','.')),0);
		vPATRIMONIO_LIQUIDO = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'PATRIMONIO_LIQUIDO'),0);
		vMUDANCA_DOMIC_ANTERIOR = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'MUDANCA_DOMIC_ANTERIOR'),' ');
		vCOD_MUN_AT_ANT = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'COD_MUN_ATUAL_ANTERIOR'),' ');
		vDT_INI_CIDADE_AT_ANT = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'DT_INI_CIDADE_ATUAL_ANTERIOR'),' ');
		vDT_FIN_CIDADE_AT_ANT = ifnull("SYN4TDF_EVOLUCAO"."/SYN/F_BUSCA_PARAMETROS"(pProcessoID,'DT_FIN_CIDADE_ATUAL_ANTERIOR'),' ');


		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_A
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_A AS cSEGMENTO_A DO

			v_conteudo = 'A'; 
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_A.IE, 9, 0); 
			v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_A.DT_INI, 'YYYY'),4,0);
			v_conteudo = v_conteudo || RPAD(vRETIFICACAO, 1, ' ');
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_A.CNAE, 7, 0);
			v_conteudo = v_conteudo || RPAD(dSEGMENTO_A.CA_TP_ESTABELEC, 1, ' ');
			v_conteudo = v_conteudo || LPAD(vFINALIDADE, 1, 0);
			v_conteudo = v_conteudo || RPAD(vTP_ESCRITURACAO, 1, ' ');
			v_conteudo = v_conteudo || '3';
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_A.COD_MUN_ESTABELEC, 7, 0);
			v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_A.DT_INI, 'DDMMYYYY'),8,0);
			v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_A.DT_FIN, 'DDMMYYYY'),8,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_A.CPF_CONTAB, 11, 0);
			v_conteudo = v_conteudo || RPAD(dSEGMENTO_A.NOME_CONTAB, 80, ' ');
			v_conteudo = v_conteudo || LPAD(vSALDO_INI_CAIXA, 14, 0);
			v_conteudo = v_conteudo || LPAD(vSALDO_FIN_CAIXA, 14, 0);
			v_conteudo = v_conteudo || LPAD(vPATRIMONIO_LIQUIDO, 14, 0);
			v_conteudo = v_conteudo || RPAD(vMUDANCA_DOMIC_ANTERIOR, 1, ' ');
			v_conteudo = v_conteudo || '2020.1';
			
		    CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;

	    END FOR;
		
		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_B
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_B AS cSEGMENTO_B DO

			v_conteudo = 'B';
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_B.IE, 9 ,0);
			v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_B.DT_INI, 'YYYY'),4,0);
			v_conteudo = v_conteudo || RPAD(vCOD_MUN_AT_ANT, 7, ' ');
			v_conteudo = v_conteudo || RPAD(vDT_INI_CIDADE_AT_ANT, 8, ' ');
			v_conteudo = v_conteudo || RPAD(vDT_FIN_CIDADE_AT_ANT, 8, ' ');
			if vCOD_MUN_AT_ANT = 'N' then
    			v_conteudo = v_conteudo || 'A';
			elseif vCOD_MUN_AT_ANT = 'S' then
				v_conteudo = v_conteudo || 'E';
			else
				v_conteudo = v_conteudo || ' ';
			end if;

		    CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
	    END FOR;

		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_C
		-------------------------------------------------------------------------------------------------------------------------------------
	    
	    FOR dSEGMENTO_C AS cSEGMENTO_C DO
	    	
	    	v_conteudo = 'C';
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.IE, 9 ,0);
	    	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_C.DT_INI, 'YYYY'),4,0);
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.COD_ENTRADA,2,0);
	    	
	    	if vCOD_MUN_AT_ANT = 'N' then
    			v_conteudo = v_conteudo || 'A';
			elseif vCOD_MUN_AT_ANT = 'S' then
				v_conteudo = v_conteudo || 'E';
			else
				v_conteudo = v_conteudo || ' ';
			end if;
			
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.COD_MUN_ESTABELEC,7,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.VL_CONTABIL,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.VL_BASE_CALCULO,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.VL_CONTABIL,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.CA_VL_ISENTO_OUTROS,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_C.VL_ICMS_ST,14,0);
			
			CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;	
	    	   

		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_D
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_D AS cSEGMENTO_D DO
	    	
	    	v_conteudo = 'D';
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.IE, 9 ,0);
	    	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_D.DT_INI, 'YYYY'),4,0);
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.UF,2,0);
	    	
	    	if vCOD_MUN_AT_ANT = 'N' then
    			v_conteudo = v_conteudo || 'A';
			elseif vCOD_MUN_AT_ANT = 'S' then
				v_conteudo = v_conteudo || 'E';
			else
				v_conteudo = v_conteudo || ' ';
			end if;
			
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.COD_MUN_ESTABELEC,7,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.VL_CONTABIL,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.VL_BASE_CALCULO,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.CA_VL_ISENTO_OUTROS,14,0);
			v_conteudo = v_conteudo || LPAD(0,14,0);
			v_conteudo = v_conteudo || LPAD(0,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_D.VL_ICMS_ST,14,0);
			
			CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;	
		 
	 
		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_E
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_E AS cSEGMENTO_E DO
	    	
	    	v_conteudo = 'E';
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.IE, 9 ,0);
	    	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_E.DT_INI, 'YYYY'),4,0);
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.COD_ENTRADA,2,0);
	    	
	    	if vCOD_MUN_AT_ANT = 'N' then
    			v_conteudo = v_conteudo || 'A';
			elseif vCOD_MUN_AT_ANT = 'S' then
				v_conteudo = v_conteudo || 'E';
			else
				v_conteudo = v_conteudo || ' ';
			end if;
			
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.COD_MUN_ESTABELEC,7,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.VL_CONTABIL,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.VL_BASE_CALCULO,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.CA_OUTRAS_ISENTAS,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_E.VL_ICMS_ST,14,0);
			
			CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;

   		-------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_F
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_F AS cSEGMENTO_F DO
	    	
	    	v_conteudo = 'F';
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.IE, 9 ,0);
	    	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_F.DT_INI, 'YYYY'),4,0);
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.UF,2,0);
	    	
	    	if vCOD_MUN_AT_ANT = 'N' then
    			v_conteudo = v_conteudo || 'A';
	        elseif vCOD_MUN_AT_ANT = 'S' then
	          	v_conteudo = v_conteudo || 'E';
	        else
	          	v_conteudo = v_conteudo || ' ';
	        end if;
				
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.COD_MUN_ESTABELEC,7,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_VL_CONTAB_CONTRIB,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_VL_CONTAB_N_CONTRIB,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_BASE_CALC_CONTRIB,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_BASE_CALC_N_CONTRIB,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_VL_ISENTO_OUTROS,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_SUBST_TRIB,14,0);
	        v_conteudo = v_conteudo || LPAD(dSEGMENTO_F.CA_ICMS_SUBST_TRIB,14,0);
	        
	        CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
	        vCountLinha := vCountLinha +1;
		END FOR;

        -------------------------------------------------------------------------------------------------------------------------------------
		-- SEGMENTO_K
		-------------------------------------------------------------------------------------------------------------------------------------
	    FOR dSEGMENTO_K AS cSEGMENTO_K DO
	    	v_conteudo = 'K';
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.IE, 9 ,0);
	    	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_K.DT_INI, 'YYYY'),4,0);
            v_conteudo = v_conteudo || RPAD(dSEGMENTO_K.TIPO_ENTRADA,1,' ');
	    	v_conteudo = v_conteudo || LPAD(dSEGMENTO_k.CFOP_CODIGO,4,0);
	    	
	    	IF vCOD_MUN_AT_ANT = 'N' THEN
    			v_conteudo = v_conteudo || 'A';
			ELSEIF vCOD_MUN_AT_ANT = 'S' THEN
				v_conteudo = v_conteudo || 'E';
			ELSE
				v_conteudo = v_conteudo || ' ';
			END IF;
			
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.COD_MUN_ESTABELEC,7,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.VL_CONTABIL,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.VL_BASE_CALCULO,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.VL_OUTROS,14,0);
			v_conteudo = v_conteudo || LPAD(dSEGMENTO_K.VL_ICMS_ST,14,0);
			
			CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);
			vCountLinha := vCountLinha +1;
		 END FOR;
		
		-------------------------------------------------------------------------------------------------------------------------------------
    	-- SEGMENTO_Z
    	-------------------------------------------------------------------------------------------------------------------------------------
    	FOR dSEGMENTO_Z AS cSEGMENTO_Z DO

        	v_conteudo = 'Z'; 
        	v_conteudo = v_conteudo || LPAD(dSEGMENTO_Z.IE, 9, 0); 
        	v_conteudo = v_conteudo || LPAD(TO_VARCHAR(dSEGMENTO_Z.DT_INI, 'MMYYYY'),6,0);
        	v_conteudo = v_conteudo || LPAD(vCountLinha,3,0); 
        
        	CALL "SYN4TDF_EVOLUCAO"."/SYN/P_GRAVA_LINHA"(pProcessoID,vCountLinha,v_conteudo);

    	END FOR;
		
		
	    ------------------------------------------------------------------------------------------------------------------------------------
	  	-- Update do Status da geracao
	    -------------------------------------------------------------------------------------------------------------------------------------

    	UPDATE "SYN4TDF_EVOLUCAO"."/SYN/PROCESS_DECLARATION" SET END_DATE = now(), STATUS = 'GERADO'  where id = pProcessoID;

    	COMMIT;
	    

END
