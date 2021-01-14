SELECT generico.pcg_central_equipamentos.fcn_tratar_codigobarra('123781-LOCAÇÃO') code_bar
FROM dual;

SELECT REGEXP_INSTR ('CE-123781-34-1', '^CE-\d{1,12}-\d{1,3}-\d{1,3}$') code_bar
FROM dual;
