SELECT
       O.NUMLOC,
       O.NOMLOC,
       O.USU_CENCUSTO,
       F.*
 FROM SENIOR.R034FUN F
  LEFT JOIN R016ORN O ON O.TABORG = F.TABORG
                     AND O.NUMLOC = F.NUMLOC
 WHERE O.TABORG = 9
   AND O.USU_CENCUSTO IN ('CACM02011',
                          'CACE0203X',
                          'CACE0301X',
                          'CACG04063',
                          'CABU00036',
                          'CACE04049',
                          'CACC0002X',
                          'CABU00012',
                          'CACE02041',
                          'CACC01035',
                          'CACF04019',
                          'CACM01018',
                          'CACJ00018',
                          'CACJ03019');
