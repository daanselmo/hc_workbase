 SELECT  nvl(vr.cod_paciente,  '_'||vr.cod_paciente_sem_registro_hc) cod_paciente,
        
          CASE                
               WHEN vr.cod_paciente IS NULL THEN
                 (SELECT pshc.nom_paciente||' '||pshc.sbn_paciente FROM
                  paciente_sem_registro_hc pshc WHERE pshc.cod_paciente_sem_registro_hc = vr.cod_paciente_sem_registro_hc)
               ELSE
                  (SELECT p.nom_paciente||' '||p.sbn_paciente
                     FROM paciente p WHERE p.cod_paciente = vr.cod_paciente)  
         END paciente, 
 
          
         COUNT(*) qtd,
         RTRIM(XMLAGG(XMLELEMENT(E,  'vr: '||vra.seq_vacina_recepcao ||' - vra: '||vra.seq_vacina_recepcao_aplic||' '||vra.dta_hor_aplicacao||'   '||tv.dsc_tipo_vacina, ',' || CHR(13)).EXTRACT('//text()') ORDER BY vra.dta_hor_aplicacao DESC).GETCLOBVAL(),  ',') Vacinas
 FROM vacina_recepcao vr
 JOIN vacina_recepcao_aplicacao vra
   ON vra.seq_vacina_recepcao = vr.seq_vacina_recepcao
 JOIN tipo_vacina tv 
    ON tv.cod_tipo_vacina = vra.cod_tipo_vacina
 WHERE 1 = 1
  AND vr.dta_hor_cadastro > to_date('01/01/2019', 'DD/MM/YYYY')
 -- AND vr.dta_hor_cadastro > TRUNC(SYSDATE)
--AND vr.cod_paciente = '1511478K'
GROUP BY vr.cod_paciente,
         vr.cod_paciente_sem_registro_hc
       ORDER BY qtd DESC;
