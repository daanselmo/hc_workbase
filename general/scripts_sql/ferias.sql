select a.dta_inicio_ferias, a.qtd_dias_ferias, '***', a.*
   from periodo_ferias a
  where a.num_matricula = 6373 and a.dta_inicio_ferias > SYSDATE
  AND 
order by a.dta_inicio_ferias;


SELECT * FROM usuario u
WHERE u.nom_usuario LIKE '%ANDRE%'
AND U.SBN_USUARIO LIKE '%SOUSA%';

select * from SENIOR.R034FUN t
WHERE 1 = 1
AND t.nomfun LIKE UPPER('%ANDRE%SOUSA%');
--AND t.nomfun LIKE UPPER('%DANIEL%ANSELMO%');
