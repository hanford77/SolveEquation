@echo off
rem 定义环境变量-----------------------------------------------------------
set RunDirectory=%~dp0..\..\..\..\Run\
set DSWFILE="SolveEquation.dsw"
set CFG="SolveEquation - Win32 RA"
rem 获得VC的安装目录-------------------------------------------------------
rem 设置本批处理文件所在目录为当前目录
cd /d %~dp0
rem 执行 vspath.vbs,生成 vspath.bat
cscript -e:vbs vspath.vbs
rem 执行 vspath.bat 设置环境变量(VC的安装目录)
call vspath.bat
rem 删除 vspath.bat
del vspath.bat
rem 执行编译--------------------------------------------------------------
if not defined vc6path goto :eof
rem 执行编译(MSDEV.EXE会创建新的命令窗口,MSDEV.COM不会;/NORECURSE 将不编译依赖项)
"%vc6path%MSDEV.COM" %DSWFILE% /make %CFG% /rebuild
if not errorlevel 0 goto :eof
echo 编译成功完成
goto end
:eof
echo 编译失败
:end
pause
