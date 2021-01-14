SELECT *
 FROM vacina_recepcao vr
 WHERE 1 = 1
--  AND vr.dta_hor_cadastro > to_date('01/01/2019', 'DD/MM/YYYY')
AND vr.dta_hor_cadastro > TRUNC(SYSDATE)
AND vr.cod_paciente = '0314174A';

SELECT *
 FROM vacina_recepcao_aplicacao vra
 WHERE vra.seq_vacina_recepcao_aplic IN (31430, 31431);


 
 SELECT  nvl(vr.cod_paciente,  '_'||vr.cod_paciente_sem_registro_hc) cod_paciente,
        
          CASE                
               WHEN vr.cod_paciente IS NULL THEN
                 (SELECT pshc.nom_paciente||' '||pshc.sbn_paciente FROM
                  paciente_sem_registro_hc pshc WHERE pshc.cod_paciente_sem_registro_hc = vr.cod_paciente_sem_registro_hc)
               ELSE
                  (SELECT p.nom_paciente||' '||p.sbn_paciente
                     FROM paciente p WHERE p.cod_paciente = vr.cod_paciente)  
         END nome_paciente,         
         COUNT(*) qtd,
         RTRIM(XMLAGG(XMLELEMENT(E,  'vr: '||vra.seq_vacina_recepcao ||' - vra: '||vra.seq_vacina_recepcao_aplic||' '||vra.dta_hor_aplicacao||'   '||tv.dsc_tipo_vacina, ',' || CHR(13)).EXTRACT('//text()') ORDER BY vra.dta_hor_aplicacao DESC).GETCLOBVAL(),  ',') Vacinas,
      
         CASE 
               vra.idf_status
              WHEN 0 THEN 'cancelado'
         END cancelado
  
 FROM vacina_recepcao vr
 JOIN vacina_recepcao_aplicacao vra
   ON vra.seq_vacina_recepcao = vr.seq_vacina_recepcao
 JOIN tipo_vacina tv 
    ON tv.cod_tipo_vacina = vra.cod_tipo_vacina
 WHERE 1 = 1
-- AND vr.dta_hor_cadastro >= to_date('01/10/2019', 'DD/MM/YYYY')
  AND vr.dta_hor_cadastro >= TRUNC(SYSDATE)
--AND vr.cod_paciente = '1410355C'
--AND vra.idf_status <> 0 --Cancelado
GROUP BY vr.cod_paciente,
         vr.cod_paciente_sem_registro_hc,
         vra.idf_status
       ORDER BY nome_paciente;
         
       
       SELECT *
        FROM paciente p
        WHERE p.cod_paciente = '0340324J';
       
  
SELECT *
 FROM paciente_sem_registro_hc p
 WHERE p.cod_paciente_sem_registro_hc = 1334504;
