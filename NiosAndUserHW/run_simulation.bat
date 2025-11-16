@echo off
echo ========================================
echo    NiosAndUserHW - Simulacao ModelSim
echo ========================================
echo.

REM Navega para o diretorio do script
cd /d "%~dp0"

echo Compilando arquivos VHDL...
vlib work
if errorlevel 1 (
    echo Erro ao criar biblioteca work
    pause
    exit /b 1
)

vcom -work work ../BRAM1024/bram1024x32.vhd
if errorlevel 1 (
    echo Erro ao compilar bram1024x32.vhd
    pause
    exit /b 1
)

vcom -work work NiosAndUserHW.vhd
if errorlevel 1 (
    echo Erro ao compilar NiosAndUserHW.vhd
    pause
    exit /b 1
)

vcom -work work NiosAndUserHW_tb.vhd
if errorlevel 1 (
    echo Erro ao compilar NiosAndUserHW_tb.vhd
    pause
    exit /b 1
)

echo.
echo Compilacao concluida com sucesso!
echo.
echo Iniciando simulacao...
echo.

REM Executa a simulacao
vsim -t ps work.niosanduserhw_tb -do simulate.do

echo.
echo Simulacao finalizada.
pause

