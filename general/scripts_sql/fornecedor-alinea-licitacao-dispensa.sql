/*Fornecedor por alinea(Licita��o)*/

SELECT ALN.DSC_ALINEA,
       TAC.DSC_TIPO_AUTORIZACAO,
       TA.DSC_TIPO_AQUISICAO,
       ACM.NUM_PEDIDO_COMPRA || '/' || ACM.ANO_PEDIDO_COMPRA PC,
       M.COD_MATERIAL,
       M.NOM_MATERIAL,
       FORN.COD_FORNECEDOR,
       FORN.NOM_FORNECEDOR,
       ACM.DTA_INICIO_VALIDADE,
       ACM.DTA_FIM_VALIDADE,
       ACM.QTD_MAT_PERIODO,
       ACM.VLR_MATERIAL
  FROM AUTORIZACAO_COMPRA_MATERIAL ACM
  JOIN MATERIAL M
    ON M.COD_MATERIAL = ACM.COD_MATERIAL
  JOIN FORNECEDOR FORN
    ON FORN.COD_FORNECEDOR = ACM.COD_FORNECEDOR
  JOIN GRUPO GRP
    ON GRP.COD_GRUPO = M.COD_GRUPO
  JOIN ALINEA ALN
    ON ALN.COD_ALINEA = GRP.COD_ALINEA
  JOIN TIPO_AUTORIZACAO_COMPRA TAC
    ON TAC.COD_TIPO_AUTORIZACAO = ACM.COD_TIPO_AUTORIZACAO
  JOIN PEDIDO_COMPRA PC
    ON PC.NUM_PEDIDO_COMPRA = ACM.NUM_PEDIDO_COMPRA
   AND PC.ANO_PEDIDO_COMPRA = ACM.ANO_PEDIDO_COMPRA
  JOIN TIPO_AQUISICAO TA
    ON TA.COD_TIPO_AQUISICAO = PC.IDF_DIRECIONAMENTO
 WHERE TRUNC(SYSDATE) BETWEEN ACM.DTA_INICIO_VALIDADE AND
       ACM.DTA_FIM_VALIDADE;
 --------------------------------------------
 
 /*Fornecedor por alinea(Dispensa)*/
  SELECT ALN.DSC_ALINEA ALINEA,
       AC.NUM_AGRUPAMENTO,      
       D.NUM_ORCAMENTO OR�AMENTO,
       D.ANO_ORCAMENTO,          
       INS.NOM_FANTASIA INSTITUTO,       
      CASE
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 1 THEN 'ABERTURA LICITA��O'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 2 THEN 'CONTACTANDO FORNECEDORES'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 3 THEN 'PREENCHENDO QUADRO DE PRE�OS'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 4 THEN 'ANALISE JULGAMENTO'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 5 THEN 'FATURAMENTO'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 6 THEN 'HOMOLOGADO'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 8 THEN 'CANDELADO'
          WHEN AC.IDF_ESTAGIO_AGRUPAMENTO = 9 THEN 'FINALIZADO'
       END FASE_COMPRA,
      CASE
          WHEN PC.IDF_ESTAGIO_PEDIDO = 0 THEN 'ANALISE DO PEDIDO DE COMPRA'
          WHEN PC.IDF_ESTAGIO_PEDIDO = 1 THEN 'A DEFINIR LICITACAO/DISPENSA'
          WHEN PC.IDF_ESTAGIO_PEDIDO = 2 THEN 'DEFININDO ONERACAO'
          WHEN PC.IDF_ESTAGIO_PEDIDO = 3 THEN 'AGRUPANDO'                
          WHEN PC.IDF_ESTAGIO_PEDIDO = 6 THEN 'FATURAMENTO'          
          WHEN PC.IDF_ESTAGIO_PEDIDO = 8 THEN 'COMPRA CANCELADA'
          WHEN PC.IDF_ESTAGIO_PEDIDO = 9 THEN 'COMPRA FINALIZADA'         
          WHEN PC.IDF_ESTAGIO_PEDIDO = 14 THEN 'CADASTRO DA ATA DE REG.PRE�OS'         
          WHEN PC.IDF_ESTAGIO_PEDIDO = 16 THEN 'HOMOLOGA��O DO ITEM'                              
       END ESTADO_DO_PC,
       TI.DSC_TIPO_AQUISICAO TIPO_AQUISICAO,      
       PC.NUM_PEDIDO_COMPRA ,
       PC.ANO_PEDIDO_COMPRA,
       M.COD_MATERIAL,
       M.NOM_MATERIAL,
       FORN.COD_FORNECEDOR,
       FORN.NOM_FORNECEDOR,                                                                    
       TO_CHAR(PC.VLR_UNITARIO * QTD_APROVADA, 'FM999G999G990D9000', 'nls_numeric_characters='',.') VLR_ESTIMADO,      
       TO_CHAR(PFP.VLR_MATERIAL * PFP.QTD_FORNECER, 'FM999G999G990D9000', 'nls_numeric_characters='',.') VLR_NEGOCIADO,
       MIS.DTA_ULTIMA_COMPRA
        FROM
       DISPENSA D
       JOIN AGRUPAMENTO_COMPRA AC ON AC.NUM_AGRUPAMENTO = D.NUM_AGRUPAMENTO
       JOIN PEDIDO_COMPRA PC ON PC.NUM_AGRUPAMENTO = AC.NUM_AGRUPAMENTO
       JOIN PRECO_FORNECEDOR_PEDIDO PFP ON 
          PFP.NUM_PEDIDO_COMPRA = PC.NUM_PEDIDO_COMPRA
          AND PFP.ANO_PEDIDO_COMPRA = PC.ANO_PEDIDO_COMPRA
          AND PFP.IDF_CLASSIFICACAO = '1'       
       JOIN INSTITUICAO INS ON INS.COD_INSTITUICAO = D.COD_INSTITUICAO
       JOIN TIPO_AQUISICAO TI ON TI.COD_TIPO_AQUISICAO = AC.IDF_DIRECIONAMENTO
       JOIN MATERIAL M ON M.COD_MATERIAL = PFP.COD_MATERIAL
       JOIN GRUPO GRP ON GRP.COD_GRUPO = M.COD_GRUPO
       JOIN ALINEA ALN ON ALN.COD_ALINEA = GRP.COD_ALINEA
       JOIN FORNECEDOR FORN ON FORN.COD_FORNECEDOR = PFP.COD_FORNECEDOR
       JOIN MATERIAL_INST_SISTEMA MIS ON MIS.COD_MATERIAL = PC.COD_MATERIAL
            AND MIS.COD_INST_SISTEMA = PC.COD_INST_SISTEMA
 WHERE AC.DTA_HOR_AGRUPAMENTO BETWEEN TO_DATE('01/01/2019', 'DD/MM/YYYY') AND TO_DATE('30/01/2019', 'DD/MM/YYYY')
 ORDER BY AC.DTA_HOR_AGRUPAMENTO;
 
  
  SELECT * FROM pedido_compra pc;
  SELECT * FROM autorizacao_compra_material;
  
  SELECT TRUNC(SYSDATE) FROM dual;
  
  SELECT * FROM pesquisa_sistema ps  
  ORDER BY 1 DESC;
  --FOR UPDATE;
  
  WHERE UPPER(ps.nom_pesquisa) LIKE '%VIGENTE%';
  
  SELECT * FROM MATERIAL_INST_SISTEMA;
