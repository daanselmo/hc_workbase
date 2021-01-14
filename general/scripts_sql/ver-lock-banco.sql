
SELECT DECODE(A.request,0,'Holder: ','Waiter: ')|| A.sid sess, B.USERNAME, B.INST_ID , STATE,
        'EXECUTE PB_KILL_SESSION('||B.SID||','||B.SERIAL#||');' PROC_KIL,
        'ALTER SYSTEM KILL SESSION '''||B.SID||','||B.SERIAL#||''' IMMEDIATE;' COMANDO_KILL,
        B.MACHINE, B.TERMINAL, B.PROGRAM, 
        A.id1, A.id2, A.lmode, A.request, A.type,
        B.SQL_ADDRESS, B.SQL_HASH_VALUE
 FROM GV$LOCK A, GV$SESSION B
 WHERE A.INST_ID=B.INST_ID  
   AND A.SID=B.SID
   AND USERNAME IS NOT NULL
--    AND PROGRAM='p_Fat_Hospitalar.exe'
  AND (A.id1, A.id2, A.type) IN  (SELECT id1 , id2, type FROM GV$LOCK WHERE request>0 AND id1=a.id1 and id2=a.id2)
order by INST_ID, SESS;
