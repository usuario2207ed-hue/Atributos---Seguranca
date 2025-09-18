@echo off
:: ==============================================
:: Painel de Opções de Pasta - EDCELLTECH
:: Necessário rodar como ADMINISTRADOR
:: Compatível Windows 7 até 11
:: ==============================================

:: Verifica privilégios de administrador
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo.
    echo [!] Este script precisa ser executado como ADMINISTRADOR.
    pause
    exit /b
)

:MENU
cls
echo ===========================================
echo   🔒 Painel - Opcoes de Pasta e Exibicao
echo ===========================================
echo [1] Mostrar arquivos, pastas e unidades ocultas
echo [2] Ocultar arquivos, pastas e unidades ocultas
echo [3] Mostrar arquivos protegidos do sistema
echo [4] Ocultar arquivos protegidos do sistema
echo [5] Mostrar extensoes dos tipos de arquivo conhecidos
echo [6] Ocultar extensoes dos tipos de arquivo conhecidos
echo [7] Restaurar padrao (voltar ao recomendado)
echo [0] Sair
echo ===========================================
set /p opcao="Escolha uma opcao: "

if "%opcao%"=="1" goto MOSTRAR_OCULTOS
if "%opcao%"=="2" goto OCULTAR_OCULTOS
if "%opcao%"=="3" goto MOSTRAR_SISTEMA
if "%opcao%"=="4" goto OCULTAR_SISTEMA
if "%opcao%"=="5" goto MOSTRAR_EXT
if "%opcao%"=="6" goto OCULTAR_EXT
if "%opcao%"=="7" goto PADRAO
if "%opcao%"=="0" exit
goto MENU

:MOSTRAR_OCULTOS
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f
call :REFRESH
echo [OK] Agora arquivos ocultos serao exibidos.
pause
goto MENU

:OCULTAR_OCULTOS
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f
call :REFRESH
echo [OK] Agora arquivos ocultos estao escondidos.
pause
goto MENU

:MOSTRAR_SISTEMA
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 1 /f
call :REFRESH
echo [OK] Agora arquivos de sistema protegidos sao exibidos.
pause
goto MENU

:OCULTAR_SISTEMA
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f
call :REFRESH
echo [OK] Agora arquivos de sistema protegidos estao ocultos.
pause
goto MENU

:MOSTRAR_EXT
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
call :REFRESH
echo [OK] Extensoes de arquivos agora sao exibidas.
pause
goto MENU

:OCULTAR_EXT
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f
call :REFRESH
echo [OK] Extensoes de arquivos agora estao ocultas.
pause
goto MENU

:PADRAO
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f
call :REFRESH
echo [OK] Configuracoes restauradas ao padrao recomendado.
pause
goto MENU

:REFRESH
:: Reinicia o Explorer para aplicar mudanças
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
exit /b
