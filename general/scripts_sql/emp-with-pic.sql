select * from SENIOR.R034FUN t
WHERE 1 = 1
AND t.nomfun LIKE '%AMANDA CRISTINA ALCANTARA%';
--AND t.numcad = 11028;

SELECT A.NUMEMP, A.NUMCAD, A.FOTEMP
     FROM R034FOT A
      WHERE A.TIPCOL = 1
      AND A.NUMCAD = 11028;
      
      SELECT
  F.NUMEMP, -- EMPRESA
  F.NUMCAD, -- MATRICULA
  E.APEEMP,
  F.NOMFUN,
  F.NUMCPF,
  F.DATADM,
  F.DATAFA, -- DATA DEMISS?O SE F.SITAFA IN (SELECT S.CODSIT FROM R010SIT S WHERE S.TIPSIT = 7)
  C.CODCAR,
  C.TITRED,
  T.CODLOC,
  G.NOMLOC,
  CP.EMAPAR,
  CP.EMACOM,
  CP.DDDTEL,
  CP.NUMTEL,
  CP.NMDDD2,
  CP.NMTEL2
FROM SENIOR.R034FUN F
    LEFT JOIN SENIOR.R024CAR C ON C.ESTCAR = F.ESTCAR AND C.CODCAR = F.CODCAR
    LEFT JOIN SENIOR.R030EMP E ON E.NUMEMP = F.NUMEMP
    LEFT JOIN SENIOR.R016ORN G ON G.TABORG = F.TABORG AND G.NUMLOC = F.NUMLOC
    LEFT JOIN SENIOR.R016HIE T ON T.TABORG = F.TABORG AND T.NUMLOC = F.NUMLOC AND SYSDATE BETWEEN T.DATINI AND T.DATFIM
    LEFT JOIN SENIOR.R034CPL CP ON CP.NUMEMP = F.NUMEMP AND CP.TIPCOL = F.TIPCOL AND CP.NUMCAD = F.NUMCAD
WHERE
  F.TIPCOL = 1 -- sempre 1
  -- filtro de demitido/admitido
  AND F.SITAFA NOT IN (SELECT S.CODSIT FROM R010SIT S WHERE S.TIPSIT = 7)
  and f.nomfun like '%AMAND%CRIS%';
