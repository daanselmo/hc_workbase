/*Acessos exames site*/
SELECT * FROM
(SELECT
SUM(Y.QTD) QTD,
  CASE
                 WHEN MES_NUM = 1 THEN
                  'JANEIRO'
                 WHEN MES_NUM = 2 THEN
                  'FEVEREIRO'
                 WHEN MES_NUM = 3 THEN
                  'MARÇO'
                 WHEN MES_NUM = 4 THEN
                  'ABRIL'
                 WHEN MES_NUM = 5 THEN
                  'MAIO'
                 WHEN MES_NUM = 6 THEN
                  'JUNHO'
                 WHEN MES_NUM = 7 THEN
                  'JULHO'
                 WHEN MES_NUM = 8 THEN
                  'AGOSTO'
                 WHEN MES_NUM = 9 THEN
                  'SETEMBRO'
                 WHEN MES_NUM = 10 THEN
                  'OUTUBRO'
                 WHEN MES_NUM = 11 THEN
                  'NOVEMBRO'
                 WHEN MES_NUM = 12 THEN
                  'DEZEMBRO'
               END MES,
  Y.ANO
FROM (SELECT X.COD_PACIENTE,
       COUNT(*) QTD,
       X.MES_NUM,
       X.ANO
  FROM (SELECT IXL.COD_PACIENTE,
               IXL.NUM_PEDIDO_EXAME_ITEM,
               COUNT(*) QTD_ACESSO,
               EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO) MES_NUM,
               EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO) ANO
          FROM IMPRESSAO_EXAMES_LOG IXL
         WHERE 1 = 1
           --AND IXL.COD_PACIENTE = '1330287B'
           AND IXL.DTA_HOR_ACESSO BETWEEN
               TO_DATE('01/01/2017', 'DD/MM/YYYY') AND TO_DATE('31/12/2019', 'DD/MM/YYYY')
         GROUP BY IXL.COD_PACIENTE,
                  IXL.NUM_PEDIDO_EXAME_ITEM,
                  EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO),
                  EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO)
         ORDER BY EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO), ANO DESC) X
 GROUP BY X.COD_PACIENTE, X.MES_NUM, X.ANO) Y
 WHERE Y.MES_NUM BETWEEN 1 AND 12
 AND Y.ANO = 2017
 GROUP BY MES_NUM,
           ANO)

 UNION ALL

SELECT * FROM
(SELECT
SUM(Y.QTD) QTD,
  CASE
                 WHEN MES_NUM = 1 THEN
                  'JANEIRO'
                 WHEN MES_NUM = 2 THEN
                  'FEVEREIRO'
                 WHEN MES_NUM = 3 THEN
                  'MARÇO'
                 WHEN MES_NUM = 4 THEN
                  'ABRIL'
                 WHEN MES_NUM = 5 THEN
                  'MAIO'
                 WHEN MES_NUM = 6 THEN
                  'JUNHO'
                 WHEN MES_NUM = 7 THEN
                  'JULHO'
                 WHEN MES_NUM = 8 THEN
                  'AGOSTO'
                 WHEN MES_NUM = 9 THEN
                  'SETEMBRO'
                 WHEN MES_NUM = 10 THEN
                  'OUTUBRO'
                 WHEN MES_NUM = 11 THEN
                  'NOVEMBRO'
                 WHEN MES_NUM = 12 THEN
                  'DEZEMBRO'
               END MES,
  Y.ANO
FROM (SELECT X.COD_PACIENTE,
       COUNT(*) QTD,
       X.MES_NUM,
       X.ANO
  FROM (SELECT IXL.COD_PACIENTE,
               IXL.NUM_PEDIDO_EXAME_ITEM,
               COUNT(*) QTD_ACESSO,
               EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO) MES_NUM,
               EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO) ANO
          FROM IMPRESSAO_EXAMES_LOG IXL
         WHERE 1 = 1
           --AND IXL.COD_PACIENTE = '1330287B'
           AND IXL.DTA_HOR_ACESSO BETWEEN
               TO_DATE('01/01/2017', 'DD/MM/YYYY') AND TO_DATE('31/12/2019', 'DD/MM/YYYY')
         GROUP BY IXL.COD_PACIENTE,
                  IXL.NUM_PEDIDO_EXAME_ITEM,
                  EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO),
                  EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO)
         ORDER BY EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO), ANO DESC) X
 GROUP BY X.COD_PACIENTE, X.MES_NUM, X.ANO) Y
 WHERE Y.MES_NUM BETWEEN 1 AND 12
 AND Y.ANO = 2018
 GROUP BY MES_NUM,
           ANO)
UNION ALL
SELECT * FROM
(SELECT
SUM(Y.QTD) QTD,
  CASE
                 WHEN MES_NUM = 1 THEN
                  'JANEIRO'
                 WHEN MES_NUM = 2 THEN
                  'FEVEREIRO'
                 WHEN MES_NUM = 3 THEN
                  'MARÇO'
                 WHEN MES_NUM = 4 THEN
                  'ABRIL'
                 WHEN MES_NUM = 5 THEN
                  'MAIO'
                 WHEN MES_NUM = 6 THEN
                  'JUNHO'
                 WHEN MES_NUM = 7 THEN
                  'JULHO'
                 WHEN MES_NUM = 8 THEN
                  'AGOSTO'
                 WHEN MES_NUM = 9 THEN
                  'SETEMBRO'
                 WHEN MES_NUM = 10 THEN
                  'OUTUBRO'
                 WHEN MES_NUM = 11 THEN
                  'NOVEMBRO'
                 WHEN MES_NUM = 12 THEN
                  'DEZEMBRO'
               END MES,
  Y.ANO
FROM (SELECT X.COD_PACIENTE,
       COUNT(*) QTD,
       X.MES_NUM,
       X.ANO
  FROM (SELECT IXL.COD_PACIENTE,
               IXL.NUM_PEDIDO_EXAME_ITEM,
               COUNT(*) QTD_ACESSO,
               EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO) MES_NUM,
               EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO) ANO
          FROM IMPRESSAO_EXAMES_LOG IXL
         WHERE 1 = 1
           --AND IXL.COD_PACIENTE = '1330287B'
           AND IXL.DTA_HOR_ACESSO BETWEEN
               TO_DATE('01/01/2017', 'DD/MM/YYYY') AND TO_DATE('31/12/2019', 'DD/MM/YYYY')
         GROUP BY IXL.COD_PACIENTE,
                  IXL.NUM_PEDIDO_EXAME_ITEM,
                  EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO),
                  EXTRACT(YEAR FROM IXL.DTA_HOR_ACESSO)
         ORDER BY EXTRACT(MONTH FROM IXL.DTA_HOR_ACESSO), ANO DESC) X
 GROUP BY X.COD_PACIENTE, X.MES_NUM, X.ANO) Y
 WHERE Y.MES_NUM BETWEEN 1 AND 12
 AND Y.ANO = 2019
 GROUP BY MES_NUM,
           ANO);
