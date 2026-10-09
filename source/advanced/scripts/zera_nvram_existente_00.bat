@echo off
setlocal enabledelayedexpansion

:: Criado por Wellington Terumi Uemura
:: 09/10/2026
:: Licença: CC by 4.0

Title Formata uma NVRAM já existente do 3DO
 
:: Verifica se um arquivo foi arrastado e solto
if "%~1"=="" (
    echo [ERRO] Arraste e solte o arquivo nvram em cima deste icone.
    pause
    exit /b
)

set "FILE_PATH=%~1"

echo Atualizando o arquivo: %~nx1...

:: Executa o script PowerShell para injetar o header e preencher com zeros até 32KB
powershell -NoProfile -Command ^
    "$hex = '015A5A5A5A5A02006372656174656420627920777475656D757261000000000000000000000000006E7672616D000000000000000000000000000000000000000000000000000000FFFFFFFF0000000100008000FFFFFFFE00000000000000010000000000000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF855A02B6000000980000009800000014000000147AA565BD000000840000008400007F6800000040';" ^
    "$bytes = for($i=0; $i -lt $hex.Length; $i+=2){[Convert]::ToByte($hex.Substring($i,2),16)};" ^
    "$zeros = New-Object byte[] (32768 - $bytes.Length);" ^
    "$stream = [System.IO.File]::Create('%FILE_PATH%');" ^
    "$stream.Write($bytes, 0, $bytes.Length);" ^
    "$stream.Write($zeros, 0, $zeros.Length);" ^
    "$stream.Close();"

echo [SUCESSO] Arquivo NVRAM formatado com o novo cabecalho!
timeout /t 3 >nul
