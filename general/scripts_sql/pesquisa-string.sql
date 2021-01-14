  FUNCTION fnc_tratar_codigobarra(p_string IN VARCHAR2) RETURN VARCHAR2
  IS  
  BEGIN
      IF (INSTR(p_string, '*', 1, 1) > 0 ) OR (INSTR(p_string, '*', 1, 2) > 0) THEN
         RETURN REPLACE(p_string, '*', '');
      END IF;
      
      RETURN '0';
  END fnc_tratar_codigobarra;
