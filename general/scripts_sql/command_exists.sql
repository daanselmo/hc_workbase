SELECT *
  FROM VACINA_RECEPCAO ET
 WHERE ET.DTA_HOR_CADASTRO > TRUNC(SYSDATE)
   AND EXISTS (SELECT *
                FROM (SELECT *
                        FROM VACINA_RECEPCAO VR
                       WHERE VR.DTA_HOR_CADASTRO > TRUNC(SYSDATE)
                      UNION ALL
                      SELECT *
                        FROM VACINA_RECEPCAO VR2
                       WHERE VR2.DTA_HOR_CADASTRO > TRUNC(SYSDATE)) INE
         WHERE INE.COD_PACIENTE = ET.COD_PACIENTE);
