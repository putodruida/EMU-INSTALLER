@echo off

REM .bat con permisos de administrador
REM .bat with administrator permissions
:-------------------------------------
REM --> Analizando los permisos
IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If there is an error, it means that there are no administrator permissions.
if '%errorlevel%' NEQ '0' (

REM not shown --> echo Solicitando permisos de administrador... 

REM not shown --> echo Requesting administrative privileges... 

REM not shown --> echo Anfordern Administratorrechte ...

goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
:--------------------------------------
cls

echo Instalando VC++ Runtime

REM Necesario para el emulador
"%~dp0\Tools\VC_redist.x64.exe"
cls

:inicio
cls

echo ******************************************************************************************
echo . ESCRIBE EL NUMERO PARA EL EMULADOR QUE DESEAS INSTALAR .
echo .
echo . Duckstation [PS1] -------------------- 1
echo .
echo . PCSX2 [PS2] -------------------------- 2
echo .
echo . RPCS3 [PS3] -------------------------- 3
echo .
echo . Yuzu [Nintendo Switch] --------------- 4
echo .
echo . Ryujinx [Nintendo Switch] ------------ 5
echo .
echo . Ryujinx LDN [Nintendo Switch] -------- 6
echo .
echo . VisualBoyAdvance [GB/GBC/GBA] -------- 7
echo .
echo . DeSmuME [Nintendo DS] ---------------- 8
echo .
echo . Citra [Nintendo 3DS] ----------------- 9
echo .
echo . Dolphin [Wii/GameCube] ---------------10
echo .
echo . CEMU [WiiU] ------------------------- 11
echo .
echo . Xemu [XBOX Classic] ----------------- 12
echo .
echo . Xenia [XBOX 360] -------------------- 13
echo .
echo . PPSSPP [PSP] ------------------------ 14
echo .
echo . Project64 [Nintendo 64] ------------- 15
echo .
echo . SALIR -------------------------------- 0
echo .
set /p respuesta= Escribe el numero: 
IF %respuesta%==1 goto ps1
IF %respuesta%==2 goto ps2
IF %respuesta%==3 goto ps3
IF %respuesta%==4 goto yuzu
IF %respuesta%==5 goto ryujinx
IF %respuesta%==6 goto ldn
IF %respuesta%==7 goto gba
IF %respuesta%==8 goto ds
IF %respuesta%==9 goto 3ds
IF %respuesta%==10 goto dolphin
IF %respuesta%==11 goto cemu
IF %respuesta%==12 goto xemu
IF %respuesta%==13 goto xenia
IF %respuesta%==14 goto ppsspp
IF %respuesta%==15 goto project64
IF %respuesta%==0 goto salir

REM ############################################
REM INICIO PS1
:ps1

md "C:\Emuladores"
md "C:\Emuladores\PS1"
md "C:\Emuladores\PS1\Duckstation"
cls

%~dp0\Tools\wget.exe "https://github.com/stenzek/duckstation/releases/download/latest/duckstation-windows-x64-release.zip"

DEL /F /A "%~dp0\Tools\*.wget*"

powershell -command "Expand-Archive -Force '%~dp0duckstation*.zip' 'C:\Emuladores\PS1\Duckstation'"

DEL /F /A "%~dp0duckstation*.zip"
cls
ROBOCOPY "%~dp0\PS1\Duckstation\BIOS" "C:\Emuladores\PS1\Duckstation\BIOS" /E
copy "%~dp0\PS1\RutaBIOS.png" "C:\Emuladores\PS1\Duckstation"
copy "%~dp0\PS1\Duckstation\Duckstation.lnk" "C:\Emuladores\PS1\Duckstation"
copy "C:\Emuladores\PS1\Duckstation\Duckstation.lnk" "C:\Users\%USERNAME%\Desktop"

cls
echo REVISA LA IMAGEN PARA CONFIGURAR LA BIOS...
"C:\Emuladores\PS1\Duckstation\RutaBIOS.png"

REM Vuelve al inicio
goto inicio

REM FIN PS1
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO PS2
:ps2
md "C:\Emuladores"
md "C:\Emuladores\PS2"
md "C:\Emuladores\PS2\PCSX2"
cls

powershell -command "Expand-Archive -Force '%~dp0\PS2\pcsx2*.zip' 'C:\Emuladores\PS2\PCSX2'"

cls
copy "C:\Emuladores\PS2\PCSX2\PCSX2.lnk" "C:\Users\%USERNAME%\Desktop"
cls

REM Vuelve al inicio
goto inicio

REM FIN PS2
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO PS3
:ps3
md "C:\Emuladores"
md "C:\Emuladores\PS3"
md "C:\Emuladores\PS3\RPCS3"
md "C:\Emuladores\PS3\RPCS3\OFW"
cls

REM powershell -command "Expand-Archive -Force '%~dp0\PS3\rpcs3*.zip' 'C:\Emuladores\PS3\RPCS3'"
%~dp0\Tools\wget.exe "https://github.com/RPCS3/rpcs3-binaries-win/releases/download/build-1852b370d7a8310de092ca4132464c84192671cb/rpcs3-v0.0.26-14568-1852b370_win64.7z"
%~dp0\Tools\7zr.exe x rpcs3*.7z -oC:\Emuladores\PS3\RPCS3

DEL /F /A "%~dp0rpcs3*.7z"

cls
copy "%~dp0\PS3\RPCS3.lnk" "C:\Users\%USERNAME%\Desktop"
cls

echo ## DESCARGA EL OFW DE PS3, Y METELO EN ESTA CARPETA PARA INSTALARLO CUANDO LO PIDA ##
explorer "C:\Emuladores\PS3\RPCS3\OFW"
PAUSE
REM Vuelve al inicio
goto inicio

REM FIN PS3
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO YUZU
:yuzu


REM Vuelve al inicio
goto inicio

REM FIN YUZU
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO ryujinx
:ryujinx
cls
md "C:\Emuladores"
md "C:\Emuladores\Switch"
md "C:\Emuladores\Switch\Ryujinx"
md "C:\Emuladores\Switch\Ryujinx\OFW"

%~dp0\Tools\wget.exe "https://github.com/Ryujinx/release-channel-master/releases/download/1.1.552/ryujinx-1.1.552-win_x64.zip"

powershell -command "Expand-Archive -Force '%~dp0ryujinx*.zip' 'C:\Emuladores\Switch\Ryujinx'"

DEL /F /A "%~dp0ryujinx*.zip"

cls
copy "%~dp0\Nintendo Switch\Ryujinx\Ryujinx.lnk" "C:\Users\%USERNAME%\Desktop"
cls

echo ## DESCARGA EL OFW DE SWITCH, Y METELO EN ESTA CARPETA PARA INSTALARLO CUANDO LO PIDA ##
explorer "C:\Emuladores\Switch\Ryujinx\OFW"
PAUSE
REM Vuelve al inicio
goto inicio

REM FIN ryujinx
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO ldn
:ldn

md "C:\Emuladores"
md "C:\Emuladores\Switch"
md "C:\Emuladores\Switch\Ryujinx [LDN]"
cls


REM Vuelve al inicio
goto inicio

REM FIN ldn
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO GBA
:gba

md "C:\Emuladores"
md "C:\Emuladores\GB-GBC-GBA"
md "C:\Emuladores\GB-GBC-GBA\VisualBoyAdvance"

cls 
powershell -command "Expand-Archive -Force '%~dp0\GB GBC GBA\VisualBoyAdvance.zip' 'C:\Emuladores\GB-GBC-GBA\VisualBoyAdvance'"
cls
copy "C:\Emuladores\GB-GBC-GBA\VisualBoyAdvance\VisualBoyAdvance.lnk" "C:\Users\%USERNAME%\Desktop"
cls

REM Vuelve al inicio
goto inicio

REM FIN GBA
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO DS
:ds

md "C:\Emuladores"
md "C:\Emuladores\DS"
md "C:\Emuladores\DS\DeSmuME"
cls

powershell -command "Expand-Archive -Force '%~dp0\Nintendo DS\desmume*.zip' 'C:\Emuladores\DS\DeSmuME'"

cls
copy "C:\Emuladores\DS\DeSmuME\DeSmuME.lnk" "C:\Users\%USERNAME%\Desktop"
cls

REM Vuelve al inicio
goto inicio

REM FIN DS
REM ############################################

REM *****************************************************************************************



REM ############################################
REM INICIO 3DS
:3ds

%~dp0\Tools\wget.exe "https://github.com/citra-emu/citra-web/releases/download/1.0/citra-setup-windows.exe"
cls
"%~dp0citra-setup-windows.exe"
echo INSTALANDO Citra...


DEL /F /A "%~dp0citra-setup-windows.exe"


cls
REM Vuelve al inicio
goto inicio

REM FIN 3DS
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO dolphin
:dolphin
cls
md "C:\Emuladores"
md "C:\Emuladores\Wii-GameCube"
md "C:\Emuladores\Wii-GameCube\Dolphin"

%~dp0\Tools\wget.exe "https://dl.dolphin-emu.org/builds/a3/80/dolphin-master-5.0-17995-x64.7z"

%~dp0\Tools\7zr.exe x dolphin*.7z -oC:\Emuladores\Wii-GameCube\Dolphin

DEL /F /A "%~dp0dolphin*.7z"

cls
copy "%~dp0\Wii-GameCube\Dolphin\Dolphin.lnk" "C:\Users\%USERNAME%\Desktop"
copy "%~dp0\Wii-GameCube\Dolphin\Dolphin Tool.lnk" "C:\Users\%USERNAME%\Desktop"
cls


REM Vuelve al inicio
goto inicio

REM FIN dolphin
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO cemu
:cemu
md "C:\Emuladores"
md "C:\Emuladores\WiiU"
md "C:\Emuladores\WiiU\Cemu"

%~dp0\Tools\wget.exe "https://cemu.info/releases/cemu_1.26.2.zip"
PAUSE
cls

powershell -command "Expand-Archive -Force '%~dp0cemu*.zip' 'C:\Emuladores\WiiU\Cemu'"

DEL /F /A "%~dp0cemu*.zip"

REM Vuelve al inicio
goto inicio

REM FIN cemu
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO xemu
:xemu
md "C:\Emuladores"
md "C:\Emuladores\XBOX"
md "C:\Emuladores\XBOX\Xemu"

%~dp0\Tools\wget.exe "https://github.com/xemu-project/xemu/releases/latest/download/xemu-win-release.zip"
PAUSE
cls

powershell -command "Expand-Archive -Force '%~dp0xemu*.zip' 'C:\Emuladores\XBOX\Xemu'"

DEL /F /A "%~dp0xemu*.zip"

REM Vuelve al inicio
goto inicio

REM FIN xemu
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO xenia
:xenia
md "C:\Emuladores"
md "C:\Emuladores\XBOX360"
md "C:\Emuladores\XBOX360\Xenia"

%~dp0\Tools\wget.exe "https://github.com/xenia-project/release-builds-windows/releases/latest/download/xenia_master.zip"

cls

powershell -command "Expand-Archive -Force '%~dp0xenia*.zip' 'C:\Emuladores\XBOX360\Xenia'"

DEL /F /A "%~dp0xenia*.zip"

REM Vuelve al inicio
goto inicio

REM FIN xenia
REM ############################################

REM *****************************************************************************************


REM ############################################
REM INICIO ppsspp
:ppsspp
md "C:\Emuladores"
md "C:\Emuladores\PSP"
md "C:\Emuladores\PSP\PPSSPP"
cls
%~dp0\Tools\wget.exe "https://www.ppsspp.org/files/1_14_4/ppsspp_win.zip"

cls

powershell -command "Expand-Archive -Force '%~dp0ppsspp*.zip' 'C:\Emuladores\PSP\PPSSPP'"

DEL /F /A "%~dp0ppsspp*.zip"
copy "%~dp0\PSP\PPSSPP\PPSSPP - 32bits.lnk" "C:\Users\%USERNAME%\Desktop"
copy "%~dp0\PSP\PPSSPP\PPSSPP - 64bits.lnk" "C:\Users\%USERNAME%\Desktop"

REM Vuelve al inicio
goto inicio

REM FIN ppsspp
REM ############################################

REM *****************************************************************************************

REM ############################################
REM INICIO project64
:project64
md "C:\Emuladores"
md "C:\Emuladores\Nintendo 64"
md "C:\Emuladores\Nintendo 64\Project64"
cls

powershell -command "Expand-Archive -Force '%~dp0\Nintendo 64\Project64\Project64*.zip' 'C:\Emuladores\Nintendo 64\Project64'"

cls
copy "%~dp0\Nintendo 64\Project64\Project64.lnk" "C:\Users\%USERNAME%\Desktop"

REM Vuelve al inicio
goto inicio

REM FIN ppsspp
REM ############################################

:salir
DEL /F /A "%~dp0\Tools\.wget-hsts"
exit
