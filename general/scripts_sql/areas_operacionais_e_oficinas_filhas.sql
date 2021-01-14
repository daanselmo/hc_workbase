     SELECT Z.*, Y.NOM_INSTITUTO
       FROM (SELECT UE.COD_UNIDADE_EXECUTANTE_PAI,                   
                    (SELECT E.NOM_UNIDADE_EXECUTANTE
                       FROM UNIDADE_EXECUTANTE E
                      WHERE E.COD_UNIDADE_EXECUTANTE = UE.COD_UNIDADE_EXECUTANTE_PAI) UN_EXECUTANTE,                    
                    RTRIM(XMLAGG(XMLELEMENT(E, UE.NOM_UNIDADE_EXECUTANTE, ',' || CHR(13)).EXTRACT('//text()') ORDER BY UE.NOM_UNIDADE_EXECUTANTE)
                          .GETCLOBVAL(),  ',') OFICINAS,
                          COUNT(*) QTD
               FROM UNIDADE_EXECUTANTE UE 
               WHERE ue.idf_ativo = 0              
              START WITH COD_UNIDADE_EXECUTANTE IN
                         ((SELECT UE.COD_UNIDADE_EXECUTANTE
                            FROM UNIDADE_EXECUTANTE UE
                           WHERE UE.COD_UNIDADE_EXECUTANTE_PAI IS NULL))
             CONNECT BY PRIOR
                         COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI                         
              GROUP BY UE.COD_UNIDADE_EXECUTANTE_PAI) Z              
       JOIN (SELECT UE.COD_UNIDADE_EXECUTANTE, INS.NOM_INSTITUTO
               FROM UNIDADE_EXECUTANTE UE
               JOIN INSTITUTO INS
                 ON INS.COD_INSTITUTO = UE.COD_INSTITUTO
              WHERE UE.COD_UNIDADE_EXECUTANTE_PAI IS NULL) Y
         ON Y.COD_UNIDADE_EXECUTANTE = Z.COD_UNIDADE_EXECUTANTE_PAI     
      WHERE Z.UN_EXECUTANTE IS NOT NULL
      ORDER BY Y.NOM_INSTITUTO, Z.UN_EXECUTANTE;
      
      
      
     
