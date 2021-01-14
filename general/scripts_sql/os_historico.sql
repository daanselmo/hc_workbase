SELECT * FROM
   ordem_servico os
   WHERE os.num_ordem_servico = 55979
   AND os.ano_ordem_servico = 2019;
   
     SELECT os.num_ordem_servico||'/'||os.ano_ordem_servico OS,           
           (SELECT ue.nom_unidade_executante FROM
             unidade_executante ue WHERE ue.cod_unidade_executante = os.cod_unidade_executante) unidade_executante,           
           (SELECT usr.nom_usuario||' '||usr.sbn_usuario
             FROM usuario usr WHERE usr.num_user_banco = os.num_user_banco) quem_abriu_os ,
           os.nom_contato,
           os.cpl_local,
           os.dsc_servico,
           tos.num_triagem_os,           
           (SELECT usr.nom_usuario||' '||usr.sbn_usuario
             FROM usuario usr WHERE usr.num_user_banco = tos.num_user_banco) func_triagem,          
           tos.dta_hor_triagem,
           tos.dta_hor_fim_triagem,          
           (SELECT ue.nom_unidade_executante FROM
             unidade_executante ue WHERE ue.cod_unidade_executante = tos.cod_unidade_executante) oficina_triagem,          
           (SELECT ue.nom_unidade_executante FROM
             unidade_executante ue WHERE ue.cod_unidade_executante = ots.cod_unidade_executante) oficina_que_realizou,          
           (SELECT usr.nom_usuario||' '||usr.sbn_usuario
             FROM usuario usr WHERE usr.num_user_banco = ots.num_user_banco) func_apontamento,
           ots.dsc_observacao
          FROM
        ordem_servico os
   LEFT JOIN triagem_ordem_servico tos
   ON tos.num_ordem = os.num_ordem
   LEFT JOIN GENERICO.OBSERVACAO_TRIAGEM_OS ots
   ON ots.num_triagem_os = tos.num_triagem_os   
   WHERE 1 = 1
   AND os.num_ordem_servico = 55979
   AND os.ano_ordem_servico = 2019
   ORDER BY tos.dta_hor_fim_triagem;
  
   
  
