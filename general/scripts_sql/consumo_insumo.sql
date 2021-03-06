--
SELECT * FROM PESQUISA_SISTEMA PS
WHERE PS.NOM_PESQUISA LIKE '%PESQUISA ITENS RASTREAVEIS CONSIGNAÇÃO%';

SELECT M.COD_MATERIAL,
       M.NOM_MATERIAL,
       L.NUM_LOTE_FABRICANTE,
       MS.NUM_SERIE,
       L.DTA_VALIDADE_LOTE,
       NF.NUM_NOTA_FISCAL || '-' || NF.IDF_SERIE NOTA_FISCAL,
       F.COD_FORNECEDOR,
       F.NOM_FORNECEDOR,
       F.CGC_FORNECEDOR CNPJ_FORN
  FROM INSUMO_UNITARIO IU,
       MATERIAL        M,
       NOTA_FISCAL     NF,
       LOTE            L,
       MATERIAL_SERIE  MS,
       FORNECEDOR      F
 WHERE IU.SEQ_INSUMO_UNITARIO = '33342'
   AND IU.NUM_LOTE = L.NUM_LOTE
   AND L.COD_MATERIAL = M.COD_MATERIAL
   AND IU.NUM_LOTE = MS.NUM_LOTE(+)
   AND IU.SEQ_NUM_SERIE = MS.SEQ_NUM_SERIE(+)
   AND L.SEQ_NOTA_FISCAL = NF.SEQ_NOTA_FISCAL
   AND NF.COD_FORNECEDOR = F.COD_FORNECEDOR;
   
   SELECT * FROM NOTA_FISCAL NF
   WHERE NF.NUM_NOTA_FISCAL = 6239
   AND NF.COD_FORNECEDOR = 15360;
   
   SELECT * FROM insumo_unitario ui
   WHERE ui.seq_insumo_unitario = 33342;
