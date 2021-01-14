SELECT DISTINCT SUBSTR(NVL(BP.DSC_COMPLEMENTAR,
                           (SELECT M.NOM_MATERIAL
                              FROM INCORPORACAO I, MATERIAL M
                             WHERE I.NUM_INCORPORACAO = BP.NUM_INCORPORACAO
                               AND I.COD_MATERIAL = M.COD_MATERIAL)),0, 80) DSC_COMPLEMENTAR,
                FCN_VALOR_DEPRECIACAO(TO_DATE('01/01/2018', 'DD/MM/YYYY'),
                                      TO_DATE('01/07/2018 23:59:59',
                                              'DD/MM/YYYY HH24:MI:SS'),
                                      CCBP.NUM_BEM,
                                      CCBP.COD_CENCUSTO) VALOR_DEPR,
                CCBP.COD_CENCUSTO,
                BP.NUM_PATRIMONIO,
                TP.DSC_TIPO_PATRIMONIO,
                DECODE(CC.COD_GRUPO, NULL, 'SEM GRUPO', CC.COD_GRUPO) CODIGO_GRUPO
  FROM -- GRUPO_CENCUSTO GC,
       CENTRO_CUSTO_BEM_PATRIMONIAL CCBP,
       CENTRO_CUSTO                 CC,
       BEM_PATRIMONIAL              BP,
       TIPO_PATRIMONIO              TP

 WHERE CC.COD_CENCUSTO = CCBP.COD_CENCUSTO
      --        AND    GC.COD_GRUPO           = CC.COD_GRUPO
   AND CCBP.NUM_BEM = BP.NUM_BEM
   AND CCBP.DTA_INICIO <=  TO_DATE('31/12/2018 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
   AND BP.COD_TIPO_PATRIMONIO = TP.COD_TIPO_PATRIMONIO
   AND NVL(CCBP.DTA_FIM, TO_DATE('31/12/9999', 'DD/MM/YYYY')) >=  TO_DATE('01/01/2018', 'DD/MM/YYYY')

--        AND CCBP.NUM_BEM = 176746
 ORDER BY VALOR_DEPR DESC
