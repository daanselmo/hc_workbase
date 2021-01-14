SELECT C.DATPAG AS DATAPAGAMENTO,
       E.CODEVE AS EVENTO,
       E.DESEVE AS "DESCRICAO EVENTO",
       F.VALEVE AS VALOR,
       F.REFEVE AS REFERENCIA
  FROM R046VER /*R046FFR*/ F
  LEFT JOIN R008EVC E
    ON E.CODTAB = F.TABEVE
   AND E.CODEVE = F.CODEVE
  LEFT JOIN R044CAL C
    ON C.CODCAL = F.CODCAL
   AND C.NUMEMP = F.NUMEMP
 WHERE F.NUMEMP = 1
   AND F.TIPCOL = 1
   AND F.NUMCAD = 6373
   AND F.CODCAL IN
       (SELECT CODCAL
          FROM SENIOR.R044CAL
         WHERE NUMEMP = 1
              --AND TIPCAL = 11
           AND EXTRACT(MONTH FROM DATPAG) = EXTRACT(MONTH FROM SYSDATE )--+30)
           AND EXTRACT(YEAR FROM DATPAG) = EXTRACT(YEAR FROM SYSDATE ));--+30);
      --------------------------------------
  select 
   c.codcal,
   c.datpag as DataPagamento,
   e.codeve as Evento,
   e.deseve as "Descricao Evento",
   f.valeve as Valor,
   f.refeve as Referencia
from  r046ver f 
     left join R008EVC e on e.codtab = f.tabeve and e.codeve = f.codeve
     left join R044CAL c on c.codcal = f.codcal and c.numemp = f.numemp 
where 
  f.numemp = 1 
  and f.tipcol = 1 
  and f.numcad =  6373
  and f.codcal in (select codcal
                from SENIOR.R044CAL
                where numemp = 1 
                      and extract(month from datpag) = extract(month from SYSDATE)
                      and extract(year from datpag) = extract(year from SYSDATE)
                      )
order by datapagamento, codcal, evento;

