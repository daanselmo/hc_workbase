select trim(regexp_substr('bbb;aaa;qqq;ccc','[^;]+', 1,level) ) as q 
from dual
connect by regexp_substr('bbb;aaa;qqq;ccc', '[^;]+', 1, level) is not null
order by LEVEL;

select trim(regexp_substr('bbb;aaa;qqq;ccc','[^;]+', 1,level) ) as q 
from dual
connect by regexp_substr('bbb;aaa;qqq;ccc', '[^;]+', 1, level) is not null
order by q;

SELECT X.*
FROM(SELECT  
  trim(regexp_substr('51283-HCRP','[^-]+', 1,level) ) das
  FROM dual
  connect by regexp_substr('51283-HCRP', '[^-]+', 1, level) is not null
   order by das)X;
   
   
   SELECT
       regexp_substr('a-b-c', '[^-]+', 1, 1) as grupo_1,
       regexp_substr('a-b-c', '[^-]+', 1, 2) as grupo_2,
       regexp_substr('a-b-c', '[^-]+', 1, 3) as grupo_3
   FROM dual;
   
   ----------------------------------------------------
      SELECT
       regexp_substr('51283-HCRP', '[^-]+', 1, 1) as num_patrimonio,
       regexp_substr('51283-HCRP', '[^-]+', 1, 2) as dsc_tipo_patrimonio       
   FROM dual;
   --------------------------------------------------------
   -- splitting as columns
--
select regexp_substr('a-b-c', '[^-]+', 1, 1) as grupo_1
      ,regexp_substr('a-b-c', '[^-]+', 1, 2) as grupo_2
      ,regexp_substr('a-b-c', '[^-]+', 1, 3) as grupo_3
  from dual;
  
-- result:
-- a b c
  
--
-- splitting as rows
--
 select regexp_substr('a-b-c', '[^-]+', 1, level) as one_element
   from dual
connect by regexp_substr('a-b-c', '[^-]+', 1, level) is not null;

-- result:
-- a
-- b
-- c
