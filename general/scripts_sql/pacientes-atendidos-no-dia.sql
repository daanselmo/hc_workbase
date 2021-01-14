  select nvl(vr.cod_paciente, '__'||psrhc.cod_paciente_sem_registro_hc||'__') paciente,       
         COUNT(*) qtd,        
         CASE
            WHEN vra.idf_status = 0 THEN
                 LISTAGG('['||vra.seq_vacina_recepcao||'] '||tp.dsc_tipo_vacina||' - cancelada', ', '||CHR(13))
                 WITHIN GROUP (ORDER BY tp.dsc_tipo_vacina)
            WHEN vra.idf_status = 1 THEN
                 LISTAGG('['||vra.seq_vacina_recepcao||'] '||tp.dsc_tipo_vacina||' - aguardando', ', '||CHR(13))
                 WITHIN GROUP (ORDER BY tp.dsc_tipo_vacina)  
            ELSE               
                 LISTAGG('['||vra.seq_vacina_recepcao||'] '||tp.dsc_tipo_vacina||' - aplicada', ', '||CHR(13))
                 WITHIN GROUP (ORDER BY tp.dsc_tipo_vacina)
          END Vacina,
         trunc(vr.dta_hor_cadastro) dta_hor_cadastro
          FROM  vacina_recepcao vr
   JOIN vacina_recepcao_aplicacao vra
      ON vra.seq_vacina_recepcao = vr.seq_vacina_recepcao
   JOIN tipo_vacina tp
      ON tp.cod_tipo_vacina = vra.cod_tipo_vacina
   LEFT JOIN paciente_sem_registro_hc psrhc  
       ON psrhc.cod_paciente_sem_registro_hc = vr.cod_paciente_sem_registro_hc
   LEFT JOIN paciente p 
       ON p.cod_paciente = vr.cod_paciente
      where 1 = 1
      --AND nvl(vr.cod_paciente, psrhc.cod_paciente_sem_registro_hc) = '0006715K'
      AND vr.dta_hor_cadastro >= trunc(SYSDATE)--to_date('03.12.2018', 'DD.MM.YYYY')--trunc(sysdate) - 2
     -- AND vra.idf_status <> 0
      GROUP BY vr.cod_paciente,
               psrhc.cod_paciente_sem_registro_hc,
               trunc(vr.dta_hor_cadastro),
               vra.idf_status
            --   p.nom_paciente,
           --    p.sbn_paciente,
           --    psrhc.nom_paciente,
           --    psrhc.sbn_paciente
       ORDER BY vr.cod_paciente; 
       
       --66827 My User
  ------------------------------------------------------------
  SELECT * FROM vacina_recepcao vr
  WHERE 1 = 1
  AND vr.cod_paciente = '1435547C';
  
  SELECT * FROM VACINA_RECEPCAO_APLICACAO VRA
  WHERE 
  seq_vacina_recepcao in (15581, 13756, 6318, 5565);

 
  
  SELECT * FROM vacina_recepcao_aplicacao vra
  WHERE vra.seq_vacina_recepcao = 17707;
  --088560
  SELECT * FROM PACIENTE P
  WHERE P.COD_PACIENTE = '0154073G'
  
  
