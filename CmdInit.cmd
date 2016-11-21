@ECHO off
REM CmdInit script for Windows cmd on ConEmu

REM Alias
DOSKEY ls=ls --color
DOSKEY todo=ruby C:\Workdir\tools\mine\todo\todo.rb $*

REM Let Clink customize the prompt with lua addons
CALL "%~dp0clink\clink" inject --quiet -p "%~dp0clink\profile"
