SELECT COD_UNIDADE_EXECUTANTE,
       NOM_UNIDADE_EXECUTANTE,
       COD_UNIDADE_EXECUTANTE_PAI        
          FROM UNIDADE_EXECUTANTE        
         START WITH COD_UNIDADE_EXECUTANTE IN (1)        
        CONNECT BY PRIOR COD_UNIDADE_EXECUTANTE = COD_UNIDADE_EXECUTANTE_PAI;
