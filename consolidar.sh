#!/bin/bash

for archivo in "$HOME/TP1_IDS/EPNro1/entrada/"*.txt; do

  if [ -f "$archivo" ]; then 

    nombre_archivo=$(basename "$archivo")

    echo ""
    echo "Procesando archivo $nombre_archivo..."

    cat "$archivo" >> "$HOME/TP1_IDS/EPNro1/salida/$FILENAME.txt"
    mv "$archivo" "$HOME/TP1_IDS/EPNro1/procesado"

    echo "Archivo $nombre_archivo procesado con éxito"

  fi
done

