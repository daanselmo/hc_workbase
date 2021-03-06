/*VER TABELAS PAIS*/
SELECT C.TABLE_NAME CHILD_TABLE, P.TABLE_NAME PARENT_TABLE
  FROM ALL_CONSTRAINTS P, ALL_CONSTRAINTS C
 WHERE (P.CONSTRAINT_TYPE = 'P' OR P.CONSTRAINT_TYPE = 'U')
   AND C.CONSTRAINT_TYPE = 'R'
   AND P.CONSTRAINT_NAME = C.R_CONSTRAINT_NAME
   AND C.TABLE_NAME = UPPER('USUARIO');


/*VER TABELAS FILHAS*/
SELECT P.TABLE_NAME PARENT_TABLE, C.TABLE_NAME CHILD_TABLE
  FROM ALL_CONSTRAINTS P,
       ALL_CONSTRAINTS C
 WHERE (P.CONSTRAINT_TYPE = 'P' OR P.CONSTRAINT_TYPE = 'U')
   AND C.CONSTRAINT_TYPE = 'R'
   AND P.CONSTRAINT_NAME = C.R_CONSTRAINT_NAME
   AND P.TABLE_NAME = 'NOME_DA_TABELA';

/*VER TABELAS FILHAS CONSTRAINT*/
SELECT TABLE_NAME, CONSTRAINT_NAME
  FROM ALL_CONSTRAINTS
 WHERE R_CONSTRAINT_NAME IN
       (SELECT CONSTRAINT_NAME
          FROM ALL_CONSTRAINTS
         WHERE CONSTRAINT_TYPE IN ('P', 'U')
           AND TABLE_NAME = 'NOME_DA_TABELA')
 ORDER BY TABLE_NAME;

