SELECT * FROM PEDIDO_COMPRA PC
WHERE PC.NUM_PEDIDO_COMPRA = 32061
AND PC.ANO_PEDIDO_COMPRA = 2017;

SELECT PFP.NUM_PEDIDO_COMPRA, PFP.ANO_PEDIDO_COMPRA, PFP.IDF_CLASSIFICACAO, PFP.COD_MATERIAL FROM PRECO_FORNECEDOR_PEDIDO PFP
WHERE PFP.NUM_PEDIDO_COMPRA = 32061
AND PFP.ANO_PEDIDO_COMPRA = 2017
FOR UPDATE;
