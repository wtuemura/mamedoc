#!/bin/bash
#
# Criado por Wellington Terumi Uemura
# 09/10/2026
# Licença: CC by 4.0

if [ -z "$1" ]; then
    echo "Uso: $0 <caminho_do_arquivo_nvram>"
    exit 1
fi

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "[ERRO] Arquivo não encontrado: $FILE"
    exit 1
fi

echo "Atualizando o arquivo: $FILE..."

# String hexadecimal fornecida
HEX="015A5A5A5A5A02006372656174656420627920777475656D757261000000000000000000000000006E7672616D000000000000000000000000000000000000000000000000000000FFFFFFFF0000000100008000FFFFFFFE00000000000000010000000000000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF855A02B6000000980000009800000014000000147AA565BD000000840000008400007F6800000040"

# Converte o hex para dados binários salvando diretamente no arquivo
echo -n "$HEX" | xxd -r -p > "$FILE"

# Expande o arquivo de volta para os 32 KB (32768 bytes) preenchendo o restante com zeros
truncate -s 32768 "$FILE"

echo "[SUCESSO] Arquivo NVRAM formatado com o novo cabeçalho!"
