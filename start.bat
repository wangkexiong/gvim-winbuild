
CALL common :GetUnixTime TIMESTAMP
SET /A TIMESTAMP=%TIMESTAMP% - 24 * 60 * 60

git clone https://github.com/vim/vim
PUSHD vim\src

SET CMD_LATEST_TAG_TIMESTAMP="git log --format^=format:"%%d %%H %%ct" | FIND "tag" | FIND /N "tag" | FINDSTR /R \[1\]"
FOR /F "USEBACKQ DELIMS=" %%x in (`%CMD_LATEST_TAG_TIMESTAMP%`) DO SET GIT_INFO=%%x

SET TAG_COMMIT=%GIT_INFO:~-51,-11%
SET COMMIT_TIMESTAMP=%GIT_INFO:~-10%
FOR /F "USEBACKQ DELIMS=" %%x in (`git tag --contains %TAG_COMMIT%`) DO SET BUILD_TAG=%%x

IF %TIMESTAMP% LSS %COMMIT_TIMESTAMP% (
  @ECHO "START DAILY Build ..."

  COPY ..\..\build.bat .
  COPY ..\..\vcvars32all.bat .
  COPY ..\..\vcvars64all.bat .

  XCOPY /E ..\..\package\tools ..\nsis\tools\

  PUSHD ..\..\patch
    FOR %%f in (*.bat) DO CALL %%f
  POPD

  CALL build
) ELSE (
  @ECHO "NO COMMIT Yesterday ..."
)

POPD

