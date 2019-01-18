@REM
@REM WINVER Definition
@REM #define _WIN32_WINNT_NT4                    0x0400 // Windows NT 4.0
@REM #define _WIN32_WINNT_WIN2K                  0x0500 // Windows 2000
@REM #define _WIN32_WINNT_WINXP                  0x0501 // Windows XP
@REM #define _WIN32_WINNT_WS03                   0x0502 // Windows Server 2003
@REM #define _WIN32_WINNT_WIN6                   0x0600 // Windows Vista
@REM #define _WIN32_WINNT_VISTA                  0x0600 // Windows Vista
@REM #define _WIN32_WINNT_WS08                   0x0600 // Windows Server 2008
@REM #define _WIN32_WINNT_LONGHORN               0x0600 // Windows Vista
@REM #define _WIN32_WINNT_WIN7                   0x0601 // Windows 7
@REM #define _WIN32_WINNT_WIN8                   0x0602 // Windows 8
@REM #define _WIN32_WINNT_WINBLUE                0x0603 // Windows 8.1
@REM #define _WIN32_WINNT_WINTHRESHOLD           0x0A00 // Windows 10
@REM #define _WIN32_WINNT_WIN10                  0x0A00 // Windows 10
@REM

SET VIM_OPTIONS=Features=HUGE DEFINES="-DFEAT_PROPORTIONAL_FONTS" ^
                OLE=yes IME=yes MBYTE=yes IME=yes GIME=yes DYNAMIC_IME=yes CSCOPE=yes ^
                POSTSCRIPT=yes DEBUG=no MAP=no COLOR_EMOJI=no ^
                USERNAME=wangkexiong USERDOMAIN=NOKIA

@REM VIM Extra Build Options
@REM PYTHON=C:\python27 PYTHON_VER=27 DYNAMIC_PYTHON=yes
@REM PERL=C:\activeperl5 PERL_VER=516 DYNAMIC_PERL=yes
@REM LUA=C:\lua5 LUA_VER= DYNAMIC_LUA=yes
@REM TCL=c:\ActiveTcl8 TCL_VER=85 TCL_VER_LONG=8.5 DYNAMIC_TCL=yes
@REM RUBY=c:\Ruby RUBY_VER=19 RUBY_VER_LONG=1.9.1 DYNAMIC_RUBY=yes
@REM MZSCHEME=c:\PLT MZSCHEME_VER=205_000 MZSCHEME_DEBUG=no DYNAMIC_MZSCHEME=yes 

SET "BEFORE_INCLUDE=%INCLUDE%"
SET "BEFORE_LIB=%LIB%"
SET "BEFORE_LIBPATH=%LIBPATH%"
SET "BEFORE_PATH=%PATH%"

@REM Building GvimExt64.dll
call vcvars64all
SET VIM64_OPTIONS=%VIM_OPTIONS% CPU=AMD64 SUBSYSTEM_VER=5.02

nmake -f Make_mvc.mak %VIM64_OPTIONS% GvimExt/gvimext.dll
PUSHD GvimExt
copy gvimext.dll gvimext64.dll
nmake -f Makefile clean
POPD

@REM Building win32 version
SET "INCLUDE=%BEFORE_INCLUDE%"
SET "LIB=%BEFORE_LIB%"
SET "LIBPATH=%BEFORE_LIBPATH%"
SET "PATH=%BEFORE_PATH%"

CALL vcvars32all
SET VIM32_OPTIONS=%VIM_OPTIONS% SUBSYSTEM_VER=5.01 ^
                  PYTHON=C:\Python27 PYTHON_VER=27 DYNAMIC_PYTHON=yes

nmake -f Make_mvc.mak GUI=yes %VIM32_OPTIONS%
COPY gvim.exe gvim_ole.exe

nmake -f Make_mvc.mak GUI=no %VIM32_OPTIONS%
call ..\tools\rename.bat

@REM i18n
PUSHD po
nmake -f Make_mvc.mak install-all GETTEXT_PATH=c:\cygwin\bin
POPD

@REM uganda.nsis.txt
PUSHD ..\runtime\doc
sed -e 's/[ build]*\*[-a-zA-Z0-9.]*\*//g' -e 's/vim:tw=78://' uganda.txt | uniq > uganda.nsis.txt
POPD

@REM makensis
PUSHD ..\nsis
7z x icons.zip
"C:\Program Files (x86)\NSIS\makensis.exe" /DVIMRT=..\runtime /DVIMTOOLS=tools /DGETTEXT=tools gvim.nsi
COPY *.exe ..\..
POPD

