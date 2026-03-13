set WORKSPACE=../..
set LUBAN_DLL=%WORKSPACE%\Luban\Tools\Luban\Luban.dll
set CONF_ROOT=.

dotnet %LUBAN_DLL% ^
    -t clien ^
	-c cs-simple-json ^
    -d json ^
    --conf %CONF_ROOT%\luban.conf ^
    -x outputDataDir=%WORKSPACE%\UnityProject\Assets\DataTablesJson ^
	-x outputCodeDir=%WORKSPACE%\UnityProject\Assets\Scripts\DataTables
pause