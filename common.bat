CALL %*
GOTO :EOF

:GetUnixTime
  @REM Returns epoch Unix Timestamp ----------------------------------------{{{{
  @REM     -- timestamp [out] - variable used to return the Unix Timestamp
  @REM

  SETLOCAL ENABLEDELAYEDEXPANSION
    SET /A ARGS_COUNT=0
    FOR %%A in (%*) DO SET /A ARGS_COUNT+=1
    IF %ARGS_COUNT% LSS 1 GOTO :EOF

    FOR /F %%x in ('WMIC PATH win32_utctime GET /FORMAT:list ^| FINDSTR "="') do (SET %%x)
    SET /A z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
    SET /A ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
    SET /A ut=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
(
  ENDLOCAL
  SET "%1=%ut%"
)

  GOTO :EOF
  @REM }}}}
