![Build Status](https://ci.appveyor.com/api/projects/status/github/wangkexiong/gvim-winbuild?branch=master&svg=true)

**Last Build in: Wed, 16 Oct 2019 04:03:11 +0000**

## Daily build Bram Moolenaar's vim with appveyor

* The job is scheduled to be run at 12:00 Beijing Time everyday. Er, UTC Time 04:00.

## No 64bit gvim.exe anymore.
* The mininum requirement is WindowsXP.
* COLOR_EMOJI is disable. (Which requires WinSDK8.1)
* VC9 Runtime libraries is NOT included, please install from [microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=29)
* Python2 enabled. Need copy python.dll under VIM directory with Python2 installed.
* The last working balll with 64bit gvim.exe is [v8.1.0635](https://github.com/wangkexiong/gvim-winbuild/releases/download/v8.1.0635/gvim81.exe)

## Patches

* ~~v8.0.1783 breaks vc9 compilation. (uint8_t)~~ v8.0.1791 fix this
* v8.1.2082 change uninstal.exe to uninstall.exe

