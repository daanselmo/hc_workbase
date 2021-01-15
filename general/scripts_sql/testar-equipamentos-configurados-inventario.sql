SELECT Z.NOM_ABREVIADO_PESQUISA tipo_equipamento, Z.QTD
  FROM (SELECT X.NOM_ABREVIADO_PESQUISA, COUNT(*) QTD
          FROM (SELECT OTE.NOM_ABREVIADO_PESQUISA
                  FROM BEM_PATRIMONIAL BP,
                       CENTRO_CUSTO_BEM_PATRIMONIAL CP,
                       NUMERO_PATRIMONIO NP,
                       LOCALIZACAO LC,
                       TIPO_PATRIMONIO TP,
                       (SELECT BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                               BPTE.NUM_BEM,
                               A.SEQ_CODIGO_SISTEMA_ORIGEM
                          FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE
                          JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO A
                            ON A.SEQ_TIPO_IMAGEM_EQUIPAMENTO =
                               BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                         GROUP BY BPTE.NUM_BEM,
                                  BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                                  A.SEQ_CODIGO_SISTEMA_ORIGEM) BPTI,
                       GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE,
                       GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OTE
                 WHERE 1 = 1
                   AND CP.COD_CENCUSTO = 'CACK00104'
                   AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO
                   AND NP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                   AND BP.NUM_BEM = CP.NUM_BEM
                   AND BP.NUM_BEM = NP.NUM_BEM
                   AND BPTI.NUM_BEM = BP.NUM_BEM
                   AND TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = BPTI.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                   AND OTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO =  BPTI.SEQ_CODIGO_SISTEMA_ORIGEM
                   AND CP.DTA_FIM IS NULL
                      
                   AND EXISTS
                 (    
                  SELECT W.DTA_HOR_EMPRESTIMO, W.NUM_PATRIMONIO, W.COD_TIPO_PATRIMONIO, W.DSC_TIPO_PATRIMONIO, W.NUM_BEM, 
       W.NOM_BEM, W.LOCALIZACAO, W.EMPRESTADO, W.NUM_EMPRESTIMO, W.NUM_USER_EMPRESTIMO, W.DSC_TIPO_EMPRESTIMO, 
       W.COD_UNIDADE_EXECUTANTE, W.DTA_HOR_DEVOLUCAO, W.DTA_DEVOLUCAO_PREVISTA, W.NOM_SOLICITANTE, 
       W.COD_LOCALIZACAO, W.COD_LOCALIZACAO_ANTERIOR, W.DSC_OBSERVACAO, W.NUM_ORDEM, W.NUM_USER_DEVOLUCAO, 
       W.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO, W.COD_PACIENTE, W.COD_CENCUSTO, W.STATUS, W.NUM_OS, W.USUARIO, 
       W.CCUSTO, W.DSC_SITUACAO_OS, W.NOM_UNIDADE_EXECUTANTE, W.IDF_EMPRESTIMO 
FROM ( 
SELECT Z.DTA_HOR_EMPRESTIMO, Z.NUM_PATRIMONIO, Z.COD_TIPO_PATRIMONIO, Z.DSC_TIPO_PATRIMONIO, Z.NUM_BEM, Z.NOM_BEM, Z.LOCALIZACAO, 
       DECODE(Z.IDF_EMPRESTIMO,0,'N�O VINCULADO',1,'PACIENTE',2,'SE��O') DSC_TIPO_EMPRESTIMO, Z.IDF_EMPRESTIMO, 
       EE.DTA_DEVOLUCAO_PREVISTA EMPRESTADO, EE.NUM_EMPRESTIMO, EE.NUM_USER_EMPRESTIMO, 
       EE.COD_UNIDADE_EXECUTANTE, EE.DTA_HOR_DEVOLUCAO, EE.DTA_DEVOLUCAO_PREVISTA, EE.NOM_SOLICITANTE, 
       EE.COD_LOCALIZACAO, EE.COD_LOCALIZACAO_ANTERIOR, EE.DSC_OBSERVACAO, EE.NUM_ORDEM, EE.NUM_USER_DEVOLUCAO, 
       EE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO, EE.COD_PACIENTE, EE.COD_CENCUSTO, 
       CASE WHEN EE.DTA_HOR_DEVOLUCAO = TO_DATE('01/01/1800','DD/MM/YYYY') THEN 'EMPRESTADO' 
            ELSE 'DISPONIVEL' 
       END AS STATUS, 
       (SELECT XC.NUM_ORDEM_SERVICO||'/'||XC.ANO_ORDEM_SERVICO 
        FROM ORDEM_SERVICO XC 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM ) NUM_OS, 
       (SELECT XU.NOM_USUARIO||' - '||XU.SBN_USUARIO 
        FROM ORDEM_SERVICO XC, USUARIO XU 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.NUM_USER_BANCO = XU.NUM_USER_BANCO ) USUARIO, 
       (SELECT XE.COD_CENCUSTO||' - '||XE.NOM_CENCUSTO 
        FROM ORDEM_SERVICO XC, CENTRO_CUSTO XE 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.COD_CENCUSTO = XE.COD_CENCUSTO ) CCUSTO, 
       (SELECT XG.DSC_SITUACAO_OS 
        FROM ORDEM_SERVICO XC, TIPO_SITUACAO_OS XG 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.COD_SITUACAO_OS = XG.COD_SITUACAO_OS) DSC_SITUACAO_OS, 
       (SELECT XF.NOM_UNIDADE_EXECUTANTE 
        FROM UNIDADE_EXECUTANTE XF 
        WHERE XF.COD_UNIDADE_EXECUTANTE = EE.COD_UNIDADE_EXECUTANTE) NOM_UNIDADE_EXECUTANTE 
FROM ( 
SELECT MAX(EE.DTA_HOR_EMPRESTIMO) DTA_HOR_EMPRESTIMO, BP.NUM_PATRIMONIO, BP.COD_TIPO_PATRIMONIO, TP.DSC_TIPO_PATRIMONIO, BP.NUM_BEM, 
       BP.IDF_EMPRESTIMO, SUBSTR(FC_NOM_BEM_PATRIMONIAL(BP.NUM_BEM) ,1,100) NOM_BEM, 
       DECODE(LC.IDF_UNIDADE_LOCALIZACAO,1,'CAMPUS',2,'U.EMERGENCIA',1,'CAMPUS',4,'U.EMERGENCIA') LOCALIZACAO 
FROM BEM_PATRIMONIAL BP, CENTRO_CUSTO_BEM_PATRIMONIAL CP, TIPO_PATRIMONIO TP, 
     LOCALIZACAO LC, EMPRESTIMO_EQUIPAMENTO EE 
WHERE CP.COD_CENCUSTO = 'CACK00104'
  AND CP.NUM_BEM = BP.NUM_BEM 
  AND BP.NUM_BEM = EE.NUM_BEM(+) 
  AND CP.DTA_FIM IS NULL  
  AND BP.DSC_COMPLEMENTAR LIKE '%BOMBA%'  
  AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO 
  AND BP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
   AND bp.idf_emprestimo IN (1, 2) 
GROUP BY BP.NUM_PATRIMONIO, BP.COD_TIPO_PATRIMONIO, TP.DSC_TIPO_PATRIMONIO, BP.NUM_BEM, 
       BP.IDF_EMPRESTIMO, SUBSTR(FC_NOM_BEM_PATRIMONIAL(BP.NUM_BEM) ,1,100), 
       DECODE(LC.IDF_UNIDADE_LOCALIZACAO,1,'CAMPUS',2,'U.EMERGENCIA',1,'CAMPUS',4,'U.EMERGENCIA') 
) Z, EMPRESTIMO_EQUIPAMENTO EE 
WHERE Z.NUM_BEM = EE.NUM_BEM(+) 
  AND Z.DTA_HOR_EMPRESTIMO = EE.DTA_HOR_EMPRESTIMO(+) 
) W 
WHERE W.STATUS IN ('DISPONIVEL') 
                         
                  AND W.NUM_BEM = BP.NUM_BEM )                
                  ) X
         GROUP BY X.NOM_ABREVIADO_PESQUISA        
        ) Z
 ORDER BY Z.NOM_ABREVIADO_PESQUISA;
 -----------------------------------------------------------------------------------------------------------
--TRIM(XMLAGG(XMLELEMENT(E,  X.num_bem, ',' || CHR(13)).EXTRACT('//text()') ORDER BY X.num_bem).GETCLOBVAL(),  ',') NUM_BEM
       SELECT W.DTA_HOR_EMPRESTIMO, W.NUM_PATRIMONIO, W.COD_TIPO_PATRIMONIO, W.DSC_TIPO_PATRIMONIO, W.NUM_BEM, 
       W.NOM_BEM, W.LOCALIZACAO, W.EMPRESTADO, W.NUM_EMPRESTIMO, W.NUM_USER_EMPRESTIMO, W.DSC_TIPO_EMPRESTIMO, 
       W.COD_UNIDADE_EXECUTANTE, W.DTA_HOR_DEVOLUCAO, W.DTA_DEVOLUCAO_PREVISTA, W.NOM_SOLICITANTE, 
       W.COD_LOCALIZACAO, W.COD_LOCALIZACAO_ANTERIOR, W.DSC_OBSERVACAO, W.NUM_ORDEM, W.NUM_USER_DEVOLUCAO, 
       W.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO, W.COD_PACIENTE, W.COD_CENCUSTO, W.STATUS, W.NUM_OS, W.USUARIO, 
       W.CCUSTO, W.DSC_SITUACAO_OS, W.NOM_UNIDADE_EXECUTANTE, W.IDF_EMPRESTIMO 
FROM ( 
SELECT Z.DTA_HOR_EMPRESTIMO, Z.NUM_PATRIMONIO, Z.COD_TIPO_PATRIMONIO, Z.DSC_TIPO_PATRIMONIO, Z.NUM_BEM, Z.NOM_BEM, Z.LOCALIZACAO, 
       DECODE(Z.IDF_EMPRESTIMO,0,'N�O VINCULADO',1,'PACIENTE',2,'SE��O') DSC_TIPO_EMPRESTIMO, Z.IDF_EMPRESTIMO, 
       EE.DTA_DEVOLUCAO_PREVISTA EMPRESTADO, EE.NUM_EMPRESTIMO, EE.NUM_USER_EMPRESTIMO, 
       EE.COD_UNIDADE_EXECUTANTE, EE.DTA_HOR_DEVOLUCAO, EE.DTA_DEVOLUCAO_PREVISTA, EE.NOM_SOLICITANTE, 
       EE.COD_LOCALIZACAO, EE.COD_LOCALIZACAO_ANTERIOR, EE.DSC_OBSERVACAO, EE.NUM_ORDEM, EE.NUM_USER_DEVOLUCAO, 
       EE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO, EE.COD_PACIENTE, EE.COD_CENCUSTO, 
       CASE WHEN EE.DTA_HOR_DEVOLUCAO = TO_DATE('01/01/1800','DD/MM/YYYY') THEN 'EMPRESTADO' 
            ELSE 'DISPONIVEL' 
       END AS STATUS, 
       (SELECT XC.NUM_ORDEM_SERVICO||'/'||XC.ANO_ORDEM_SERVICO 
        FROM ORDEM_SERVICO XC 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM ) NUM_OS, 
       (SELECT XU.NOM_USUARIO||' - '||XU.SBN_USUARIO 
        FROM ORDEM_SERVICO XC, USUARIO XU 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.NUM_USER_BANCO = XU.NUM_USER_BANCO ) USUARIO, 
       (SELECT XE.COD_CENCUSTO||' - '||XE.NOM_CENCUSTO 
        FROM ORDEM_SERVICO XC, CENTRO_CUSTO XE 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.COD_CENCUSTO = XE.COD_CENCUSTO ) CCUSTO, 
       (SELECT XG.DSC_SITUACAO_OS 
        FROM ORDEM_SERVICO XC, TIPO_SITUACAO_OS XG 
        WHERE XC.NUM_ORDEM = EE.NUM_ORDEM 
          AND XC.COD_SITUACAO_OS = XG.COD_SITUACAO_OS) DSC_SITUACAO_OS, 
       (SELECT XF.NOM_UNIDADE_EXECUTANTE 
        FROM UNIDADE_EXECUTANTE XF 
        WHERE XF.COD_UNIDADE_EXECUTANTE = EE.COD_UNIDADE_EXECUTANTE) NOM_UNIDADE_EXECUTANTE 
FROM ( 
SELECT MAX(EE.DTA_HOR_EMPRESTIMO) DTA_HOR_EMPRESTIMO, BP.NUM_PATRIMONIO, BP.COD_TIPO_PATRIMONIO, TP.DSC_TIPO_PATRIMONIO, BP.NUM_BEM, 
       BP.IDF_EMPRESTIMO, SUBSTR(FC_NOM_BEM_PATRIMONIAL(BP.NUM_BEM) ,1,100) NOM_BEM, 
       DECODE(LC.IDF_UNIDADE_LOCALIZACAO,1,'CAMPUS',2,'U.EMERGENCIA',1,'CAMPUS',4,'U.EMERGENCIA') LOCALIZACAO 
FROM BEM_PATRIMONIAL BP, CENTRO_CUSTO_BEM_PATRIMONIAL CP, TIPO_PATRIMONIO TP, 
     LOCALIZACAO LC, EMPRESTIMO_EQUIPAMENTO EE 
WHERE CP.COD_CENCUSTO = 'CACK00104'
  AND CP.NUM_BEM = BP.NUM_BEM 
  AND BP.NUM_BEM = EE.NUM_BEM(+) 
  AND CP.DTA_FIM IS NULL  
  AND BP.DSC_COMPLEMENTAR LIKE '%BOMBA%'  
  AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO 
  AND BP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO 
  --AND bp.idf_emprestimo IN (1, 2)
GROUP BY BP.NUM_PATRIMONIO, BP.COD_TIPO_PATRIMONIO, TP.DSC_TIPO_PATRIMONIO, BP.NUM_BEM, 
       BP.IDF_EMPRESTIMO, SUBSTR(FC_NOM_BEM_PATRIMONIAL(BP.NUM_BEM) ,1,100), 
       DECODE(LC.IDF_UNIDADE_LOCALIZACAO,1,'CAMPUS',2,'U.EMERGENCIA',1,'CAMPUS',4,'U.EMERGENCIA') 
) Z, EMPRESTIMO_EQUIPAMENTO EE 
WHERE Z.NUM_BEM = EE.NUM_BEM(+) 
  AND Z.DTA_HOR_EMPRESTIMO = EE.DTA_HOR_EMPRESTIMO(+) 
) W 
WHERE W.STATUS IN ('DISPONIVEL')                         
   
      AND NOT EXISTS
         (SELECT       OTE.NOM_ABREVIADO_PESQUISA,
                       bp.num_bem
                  FROM BEM_PATRIMONIAL BP,
                       CENTRO_CUSTO_BEM_PATRIMONIAL CP,
                       NUMERO_PATRIMONIO NP,
                       LOCALIZACAO LC,
                       TIPO_PATRIMONIO TP,
                       (SELECT BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                               BPTE.NUM_BEM,
                               A.SEQ_CODIGO_SISTEMA_ORIGEM
                          FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE
                          JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO A
                            ON A.SEQ_TIPO_IMAGEM_EQUIPAMENTO =
                               BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                         GROUP BY BPTE.NUM_BEM,
                                  BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                                  A.SEQ_CODIGO_SISTEMA_ORIGEM) BPTI,
                       GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE,
                       GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OTE
                 WHERE 1 = 1
                   AND CP.COD_CENCUSTO = 'CACK00104'
                   AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO
                   AND NP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                   AND BP.NUM_BEM = CP.NUM_BEM
                   AND BP.NUM_BEM = NP.NUM_BEM
                   AND BPTI.NUM_BEM = BP.NUM_BEM
                   AND TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = BPTI.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                   AND OTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO =  BPTI.SEQ_CODIGO_SISTEMA_ORIGEM
                   AND CP.DTA_FIM IS NULL
                   AND W.num_bem = bp.num_bem );                  
                      
   -------------------------------------------------------------
   
   
           SELECT 
                  FROM BEM_PATRIMONIAL BP,
                       CENTRO_CUSTO_BEM_PATRIMONIAL CP,
                       NUMERO_PATRIMONIO NP,
                       LOCALIZACAO LC,
                       TIPO_PATRIMONIO TP,
                       (SELECT BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                               BPTE.NUM_BEM,
                               A.SEQ_CODIGO_SISTEMA_ORIGEM
                          FROM GENERICO.BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE
                          JOIN GENERICO.TIPO_IMAGEM_EQUIPAMENTO A
                            ON A.SEQ_TIPO_IMAGEM_EQUIPAMENTO =  BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                         GROUP BY BPTE.NUM_BEM,
                                  BPTE.SEQ_TIPO_IMAGEM_EQUIPAMENTO,
                                  A.SEQ_CODIGO_SISTEMA_ORIGEM) BPTI,
                       GENERICO.TIPO_IMAGEM_EQUIPAMENTO TIE,
                       GENERICO.ORDEM_SERVICO_TIPO_EMPRESTIMO OTE
                 WHERE 1 = 1
                   AND CP.COD_CENCUSTO = 'CACK00104'
                   AND CP.COD_LOCALIZACAO = LC.COD_LOCALIZACAO
                   AND NP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
                   AND BP.NUM_BEM = CP.NUM_BEM
                   AND BP.NUM_BEM = NP.NUM_BEM
                   AND BPTI.NUM_BEM = BP.NUM_BEM
                   AND TIE.SEQ_TIPO_IMAGEM_EQUIPAMENTO = BPTI.SEQ_TIPO_IMAGEM_EQUIPAMENTO
                   AND OTE.SEQ_ORDEM_SERV_TIPO_EMPRESTIMO =  BPTI.SEQ_CODIGO_SISTEMA_ORIGEM
                   AND CP.DTA_FIM IS NULL;
  SELECT *
   FROM BEM_PATRIMONIAL_TP_IMAGEM_EQUI BPTE                   
  WHERE BPTE.num_bem in (1932, 2418, 8160, 8179, 8220, 8257, 8702, 8715, 8730, 9201, 92272, 98921, 101738, 101740, 107378, 107388, 115360, 115363, 115372);
 
  
  SELECT *
   FROM CENTRO_CUSTO_BEM_PATRIMONIAL CP
 WHERE cp.num_bem in (115372, 8220, 92272, 8715, 2418, 8257, 8732, 115363, 8179, 101738, 98921, 8160, 115360, 157053, 8218, 8702, 157052, 9201, 107388, 107378, 101740, 8033, 1932, 8730, 157050)
  AND CP.COD_CENCUSTO = 'CACK00104'
  AND cp.dta_fim IS NULL;
  
  
  SELECT * FROM
  bem_patrimonial bp
  WHERE bp.num_bem in (115372, 8220, 92272, 8715, 2418, 8257, 8732, 115363, 8179, 101738, 98921, 8160, 115360, 157053, 8218, 8702, 157052, 9201, 107388, 107378, 101740, 8033, 1932, 8730, 157050)
  AND bp.idf_emprestimo IN (1, 2);
  
  SELECT *
   FROM emprestimo_equipamento ee
   WHERE ee.num_bem in (1932, 2418, 8160, 8179, 8220, 8257, 8702, 8715, 8730, 9201, 92272, 98921, 101738, 101740, 107378, 107388, 115360, 115363, 115372);
                 
                  
