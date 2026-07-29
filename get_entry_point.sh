#!/bin/bash

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Xəta: Fayl tapılmadı və ya daxil edilmədi." >&2
    exit 1
fi

file_name="$1"

if ! readelf -h "$file_name" &>/dev/null; then
    echo "Xəta: '$file_name' faylı etibarlı ELF faylı deyil." >&2
    exit 1
fi

magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/^[[:space:]]*Magic:[[:space:]]*//')
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/^[[:space:]]*Data:[[:space:]]*//')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

if [ -f "./messages.sh" ]; then
    source ./messages.sh
    display_elf_header_info
else
    echo "ELF Header Information for '$file_name':"
    echo "----------------------------------------"
    echo "Magic Number: $magic_number"
    echo "Class: $class"
    echo "Byte Order: $byte_order"
    echo "Entry Point Address: $entry_point_address"
fi
