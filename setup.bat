@echo off

set base=%~dp0

rem **** VIM ****{{{
if exist %userprofile%\.vimrc (
		del %userprofile%\.vimrc
)

mklink /H %userprofile%\.vimrc %base%.vimrc
rem }}} end VIM

