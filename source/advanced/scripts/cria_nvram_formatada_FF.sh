#!/bin/bash
#
# Criado por Wellington Terumi Uemura
# 09/10/2026
# Licença: CC by 4.0

# Define o nome do arquivo que será criado
FILENAME="nvram"

echo "Criando novo arquivo NVRAM do 3DO (Preenchido com FF): $FILENAME..."

# Header String
HEX="015A5A5A5A5A02006372656174656420627920777475656D757261000000000000000000000000006E7672616D000000000000000000000000000000000000000000000000000000FFFFFFFF0000000100008000FFFFFFFE00000000000000010000000000000084FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF855A02B6000000980000009800000014000000147AA565BD000000840000008400007F6800000040"

# 1. Cria o arquivo contendo os dados binários do cabeçalho
echo -n "$HEX" | xxd -r -p > "$FILENAME"

# 2. Calcula quantos bytes faltam para completar 32768 (32768 - 168 = 32600)
HEADER_SIZE=$(wc -c < "$FILENAME")
REMAINING_BYTES=$((32768 - HEADER_SIZE))

# 3. Injeta a quantidade exata de bytes FF (\xff) no final do arquivo
dd if=/dev/zero bs=1 count=$REMAINING_BYTES 2>/dev/null | tr '\000' '\377' >> "$FILENAME"

# NOTA: O comando 'tr \000 \377' converte o caractere nulo do /dev/zero 
# para o valor octal \377, que equivale a \xff (255 em decimal).

echo "[SUCESSO] Novo arquivo '$FILENAME' criado com 32 KB e finalizado com FF!"
