#!/bin/bash
# Criado por Wellington Terumi Uemura
# 09/10/2026
# Licença: CC by 4.0

# Verifica se o arquivo foi passado como argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <caminho_do_arquivo_nvram>"
    exit 1
fi

FILE="$1"

# Verifica se o arquivo realmente existe
if [ ! -f "$FILE" ]; then
    echo "[ERRO] Arquivo não encontrado: $FILE"
    exit 1
fi

echo "Atualizando o arquivo: $FILE..."

# String hexadecimal do cabeçalho (168 bytes)
HEX="015A5A5A5A5A02006372656174656420627920777475656D757261000000000000000000000000006E7672616D000000000000000000000000000000000000000000000000000000FFFFFFFF0000000100008000FFFFFFFE00000000000000010000000000000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF855A02B6000000980000009800000014000000147AA565BD000000840000008400007F6800000040"

# 1. Sobrescreve o arquivo atual com os dados binários do cabeçalho
echo -n "$HEX" | xxd -r -p > "$FILE"

# 2. Calcula quantos bytes faltam para completar 32768 (32768 - 168 = 32600)
HEADER_SIZE=$(wc -c < "$FILE")
REMAINING_BYTES=$((32768 - HEADER_SIZE))

# 3. Injeta a quantidade exata de bytes FF (\xff) no final do arquivo
dd if=/dev/zero bs=1 count=$REMAINING_BYTES 2>/dev/null | tr '\000' '\377' >> "$FILE"

echo "[SUCESSO] Arquivo '$FILE' formatado com o novo cabeçalho e finalizado com FF!"
