SELECT A.NUM_AGRUPAMENTO,
       B.NUM_DOCUMENTO || '/' || B.ANO_DOCUMENTO NUMERO_DOC,
       B.NUM_DOCUMENTO NUMERO,
       B.ANO_DOCUMENTO ANO,
       C.DSC_MODALIDADE_LICITACAO || ' N� ' || B.NUM_LICITACAO || '/' ||
       B.ANO_LICITACAO DESCRICAO
  FROM AGRUPAMENTO_COMPRA A, LICITACAO B, MODALIDADE_LICITACAO C
 WHERE A.IDF_ESTAGIO_AGRUPAMENTO = '3'
   AND A.IDF_DIRECIONAMENTO = '4'
   AND A.NUM_AGRUPAMENTO = B.NUM_AGRUPAMENTO
   AND B.COD_INSTITUICAO = 2
   AND B.COD_MODALIDADE_LICITACAO = C.COD_MODALIDADE_LICITACAO
UNION ALL
SELECT A.NUM_AGRUPAMENTO,
       B.NUM_ORCAMENTO || '/' || B.ANO_ORCAMENTO NUMERO_DOC,
       B.NUM_ORCAMENTO NUMERO,
       B.ANO_ORCAMENTO ANO,
       'DISPENSA N� ' || B.NUM_ORCAMENTO || '/' || B.ANO_ORCAMENTO DESCRICAO
  FROM AGRUPAMENTO_COMPRA A, DISPENSA B
 WHERE A.IDF_ESTAGIO_AGRUPAMENTO = '3'
   AND A.IDF_DIRECIONAMENTO = '2'
   AND A.NUM_AGRUPAMENTO = B.NUM_AGRUPAMENTO
   AND B.COD_INSTITUICAO = 2
 ORDER BY ANO, NUMERO
