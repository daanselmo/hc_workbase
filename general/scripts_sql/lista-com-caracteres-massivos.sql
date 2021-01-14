SELECT L.COD_LOCALIZACAO_PAI LOCAL_BASE,
       COUNT(*) QTD,
       RTRIM(XMLAGG(
                XMLELEMENT(E, 'LOC: '||L.COD_LOCALIZACAO||' - '||L.DSC_LOCALIZACAO, ',' || CHR(13) ).EXTRACT('//text()')
                   ORDER BY L.COD_LOCALIZACAO).GETCLOBVAL(), ',') LOCALIZACOES
  FROM MANUTENCAO.LOCALIZACAO L
 WHERE 1 = 1 
 GROUP BY L.COD_LOCALIZACAO_PAI;
 
 

