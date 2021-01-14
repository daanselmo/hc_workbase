SELECT 
  trim(regexp_substr('51283-HCRP','[^-]+', 1,level) ) das
  FROM dual
  connect by regexp_substr('51283-HCRP', '[^-]+', 1, level) is not null
   order by das;
