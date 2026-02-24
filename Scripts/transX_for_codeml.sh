#!/bin/bash

# Definir directorios
TRANSLATORX="/media/server/a77f75fe-fd07-402e-84d7-a7341c29141c/fertorres/dnds/paulina/1_TRANSLATORX/0_SCRIPT/translatorx_vLocal.pl"
INPUT_DIR="/media/server/a77f75fe-fd07-402e-84d7-a7341c29141c/fertorres/mazz_cds/Single_Copy_Orthologue_Sequences"
OUTPUT_DIR="/media/server/a77f75fe-fd07-402e-84d7-a7341c29141c/fertorres/dnds/paulina/1_TRANSLATORX/1_RESULTADO"

# Crear directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Iterar sobre todos los archivos .fa en el directorio de entrada
for file in "$INPUT_DIR"/*.fa; do
    filename=$(basename "$file" .fa)  # Extraer el nombre del archivo sin extensión
    
    echo "Procesando: $filename"

    # Ejecutar TranslatorX
    perl "$TRANSLATORX" -i "$file" -o "$OUTPUT_DIR/$filename" -p C -t F -w 1 -c 1 

    echo "✅ Completado: $filename"
done

echo "🎉 Todos los ortólogos han sido procesados con TranslatorX."
