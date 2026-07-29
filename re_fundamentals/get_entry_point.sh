#!/bin/bash

if [ -z "$1" ] || [ ! -f "$1" ]; then
    exit 1
fi

file_name="$1"

if ! readelf -h "$file_name" &>/dev/null; then
    exit 1
fi

magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/^[[:space:]]*Magic:[[:space:]]*//; s/[[:space:]]*$//')
class=$(readelf -h "$file_name" | grep "Class:" | awk '{print $2}')
byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/.*, //' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk '{print $4}')

if [ -f "./messages.sh" ]; then
    source ./messages.sh
    display_elf_header_info
fi
