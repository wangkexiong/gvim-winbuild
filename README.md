![Build Status](https://ci.appveyor.com/api/projects/status/github/wangkexiong/gvim-winbuild?branch=master&svg=true)

**Last Build in: Thu, 26 Jul 2018 04:05:02 +0000**

## Daily build Bram Moolenaar's vim with appveyor

* The job is scheduled to be run at 12:00 Beijing Time everyday. Er, UTC Time 04:00.

## The target installation package supports both 32 and 64 bits version of Windows.

* The mininum requirement is WindowsXP.
* COLOR_EMOJI is disable. (Which requires WinSDK8.1)
* VC9 Runtime libraries is NOT included, please install from [microsoft](https://www.microsoft.com/en-us/download/details.aspx?id=29)
* The installation package will check if 32 or 64 bits of Windows, and install 32 or 64 versions of vim

## VisVim plugin on 64bits Windows is NOT tested...

## Patches

* ~~v8.0.1783 breaks vc9 compilation. (uint8_t)~~ v8.0.1791 fix this

