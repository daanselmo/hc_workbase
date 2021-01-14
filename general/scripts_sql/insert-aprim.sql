insert into TEMP_GENERICA_DWHC (NUM_SEQUENCIA, DSC_CONTEUDO, CTU_CONTEUDO)
SELECT vr.seq_vacina_recepcao,
       vr.cod_paciente,     
       vr.num_user_cadastro FROM vacina_recepcao vr
WHERE vr.dta_hor_cadastro >= TRUNC(SYSDATE);

TRUNCATE TABLE GENERICO.TEMP_GENERICA_DWHC;
