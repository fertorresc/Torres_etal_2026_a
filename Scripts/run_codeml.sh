#!/bin/bash

# ================================
# Batch para correr CODEML - MODELO NULO Clade Model C
# ================================
 
# Rutas
DIRECTORIO_DATOS="...para_codeml"
DIRECTORIO_OUT="/...resultados_clados_nulo"
TREEFILE="...especies_clade2_nulo.tree"
AAFILE="...paml4.9j/dat/jones.dat"
CODEML_BIN="/media/server/a77f75fe-fd07-402e-84d7-a7341c29141c/fertorres/dnds/paml4.9j/bin/codeml"

mkdir -p "$DIRECTORIO_OUT"

# Paso 1: Generar los .ctl
echo "🛠️ Generando archivos .ctl para cada gen (modelo nulo)..."

find "$DIRECTORIO_DATOS" -maxdepth 1 -name "*.phy" | while read phyfile; do
    filename=$(basename "$phyfile")
    gene_name="${filename%.phy}"
    gene_dir="$DIRECTORIO_OUT/$gene_name"

    mkdir -p "$gene_dir"

    cat > "$gene_dir/$gene_name.ctl" << EOF
      seqfile = $phyfile
     treefile = $TREEFILE
      outfile = $gene_dir/${gene_name}_codeml_output_nulo.txt

        noisy = 9
      verbose = 1
      runmode = 0

      seqtype = 1
    CodonFreq = 2

        ndata = 1
        clock = 0
       aaDist = 0
   aaRatefile = $AAFILE

        model = 3       * Clade Model
      NSsites = 3       * No site variation, model C is a branch-site model

        icode = 0
        Mgene = 0

    fix_kappa = 0
        kappa = 2
    fix_omega = 0         * << MODELO NULO: omega fijo
        omega = 1.5       * << MODELO NULO: sin selección positiva

    fix_alpha = 1
        alpha = 0.
       Malpha = 0
        ncatG = 8

        getSE = 0
 RateAncestor = 1

   Small_Diff = .5e-6
    cleandata = 1
*  fix_blength = 1
       method = 0
EOF

done

echo "✅ Archivos .ctl del modelo nulo generados. Ejecutando CODEML..."

# Paso 2: Ejecutar en paralelo con reporte de errores
find "$DIRECTORIO_OUT" -name "*.ctl" | parallel -j 35 --bar '
    dir=$(dirname {});
    cd "$dir";
    echo "→ Ejecutando $(basename {})";
    '"$CODEML_BIN"' $(basename {}) > run.log 2>&1 || echo "❌ ERROR en {}"
'

# Paso 3: Revisar contenidos
echo -e "\n🔍 Revisión rápida de subdirectorios (modelo nulo):"
find "$DIRECTORIO_OUT" -maxdepth 2 -type f \( -name "*.ctl" -o -name "*_codeml_output_nulo.txt" -o -name "run.log" \) | sort

echo -e "\n✅ Script modelo nulo finalizado."
