@ECHO OFF

IF NOT EXIST ..\vim\tools\rename.bat GOTO :EOF

PUSHD ..\vim\tools
SET NEED_UNINSTAL_CHANGE=FALSE

FOR /F "usebackq tokens=*" %%G IN (`FINDSTR /I /R /C:"mv[ ]*uninstal\.exe[ ]*uninstalw32\.exe" rename.bat`) DO (
  SET NEED_UNINSTAL_CHANGE=TRUE
)

IF %NEED_UNINSTAL_CHANGE%==TRUE (
  REN rename.bat rename.bat.old
  FOR /F "usebackq tokens=*" %%G IN (`FINDSTR /I /V /R /C:"mv[ ]*uninstal\.exe[ ]*uninstalw32\.exe" rename.bat.old`) DO (
    ECHO %%G >> rename.bat
  )
  ECHO mv uninstall.exe uninstallw32.exe >> rename.bat
  DEL /Q rename.bat.old
)

POPD

