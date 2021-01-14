SELECT --tv.dsc_tipo_vacina,
        CASE
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacaO) =  1 THEN 'JANEIRO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  2 THEN 'FEVEREIRO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  3 THEN 'MARÇO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  4 THEN 'ABRIL'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  5 THEN 'MAIO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  6 THEN 'JUNHO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  7 THEN 'JULHO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  8 THEN 'AGOSTO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  9 THEN 'SETEMBRO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  10 THEN 'OUTUBRO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  11 THEN 'NOVEMBRO'
           WHEN EXTRACT(MONTH FROM t.dta_hor_aplicacao) =  12 THEN 'DEZEMBRO'
        END MES,
        CASE
           WHEN vr.num_seq_local = 12400 THEN 'CACD02010 - SALA DE VACINA'
           WHEN vr.num_seq_local = 12401 THEN 'CACD02046 - DISPENSACAO PARA MUNICIPIO'
        END Centro_custo,
      -- vr.num_seq_local,
      -- COUNT(*) qtd,       
       tv.dsc_tipo_vacina,
       count(tv.cod_tipo_vacina) qtd_tp_vacina
       --LISTAGG(count(tv.cod_tipo_vacina) ||' '|| tv.dsc_tipo_vacina, ',') WITHIN GROUP(ORDER BY TV.dsc_tipo_vacina) VACINAS
       --LISTAGG(TV.cod_tipo_vacina, ',') WITHIN GROUP(ORDER BY TV.cod_tipo_vacina) VACINAS
  FROM VACINA_RECEPCAO VR
  JOIN GENERICO.VACINA_RECEPCAO_APLICACAO T
    ON T.SEQ_VACINA_RECEPCAO = VR.SEQ_VACINA_RECEPCAO
  LEFT JOIN PACIENTE P
    ON P.COD_PACIENTE = VR.COD_PACIENTE
  LEFT JOIN PACIENTE_SEM_REGISTRO_HC PSRHC
    ON PSRHC.COD_PACIENTE_SEM_REGISTRO_HC = VR.COD_PACIENTE_SEM_REGISTRO_HC
  JOIN TIPO_VACINA TV
    ON TV.COD_TIPO_VACINA = T.COD_TIPO_VACINA
 WHERE 1 = 1
 --AND TRUNC(VR.DTA_HOR_CADASTRO) = TRUNC(SYSDATE)
 AND EXTRACT(YEAR FROM TRUNC(VR.DTA_HOR_CADASTRO)) = 2018
 AND EXTRACT(YEAR FROM TRUNC(t.dta_hor_aplicacao)) = 2018
 AND vr.num_seq_local IS NOT NULL
 AND t.seq_utilizacao_material IS NOT NULL
 AND t.idf_status = 2
-- AND TV.COD_TIPO_VACINA = 19
 GROUP BY tv.cod_tipo_vacina,
         tv.dsc_tipo_vacina,
          vr.num_seq_local,
          EXTRACT(MONTH FROM t.dta_hor_aplicacao)
  ORDER BY  EXTRACT(MONTH FROM t.dta_hor_aplicacao);
  ------------------------------------------
  SELECT * FROM TIPO_VACINA TV
  WHERE tv.dsc_tipo_vacina LIKE '%TET%';
  
  SELECT * FROM VACINA_RECEPCAO_APLICACAO V
  WHERE V.COD_TIPO_VACINA = 19;


SELECT * 
    FROM ITEM_REQUISICAO_MATERIAL IRM
    JOIN REQUISICAO_MATERIAL RM
    ON RM.NUM_REQUISICAO = IRM.NUM_REQUISICAO
    AND IRM.ANO_REQUISICAO_MATERIAL = RM.ANO_REQUISICAO_MATERIAL
WHERE IRM.COD_MATERIAL = '70102107'
AND IRM.ANO_REQUISICAO_MATERIAL = 2018
--AND RM.COD_CENCUSTO_SOLICITANTE = 'CACD02046';
AND RM.COD_CENCUSTO_SOLICITANTE = 'CACD02046';
--AND IRM.NUM_REQUISICAO IN (1351172, 619588, 1200640, 807687, 1217167);
