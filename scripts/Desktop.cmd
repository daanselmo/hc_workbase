@echo off    
    set dsktp=%homepath%\Desktop

    if "%~1"=="" (
      call :OpnBsPth
    ) else (
      if "%~1"=="/tmp" call :OpnTmpDrPth
      if "%~1"=="/scr" call :OpnScrptDrPth       
    )
    ::Mandatory to make distinction about Main body from de app and others functions...
    EXIT /B %ERRORLEVEL% 
::-----------------------   
    Rem funtions
    :OpnBsPth    
    explorer %dsktp%
    exit /B 0   

    :OpnTmpDrPth
    set tmp_dir=%dsktp%\tmp
    explorer %tmp_dir%
    exit /B 0

    :OpnScrptDrPth
    set scrpt_dir=%dsktp%\tmp\scripts
    explorer %scrpt_dir%
    exit /B 0
::------------------------

