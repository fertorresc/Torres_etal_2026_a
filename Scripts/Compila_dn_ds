import re
import pandas as pd
from pathlib import Path

# Ruta raíz de resultados
base_path = Path("../resultados_clados")

results = []

# Buscar en cada subdirectorio OG000*_SIN_CODON_STOP
for subdir in base_path.glob("OG000*_SIN_CODON_STOP"):
    for txt_file in subdir.glob("*.txt"):
        content = txt_file.read_text(errors="ignore")

        # lnL y np
        lnL_match = re.search(r"lnL\(ntime: \d+\s+np: (\d+)\):\s+(-?\d+\.\d+)", content)
        np = int(lnL_match.group(1)) if lnL_match else None
        lnL = float(lnL_match.group(2)) if lnL_match else None

        # kappa
        kappa_match = re.search(r"kappa\s*\(ts\/tv\)\s*=\s*([0-9.]+)", content)
        kappa = float(kappa_match.group(1)) if kappa_match else None

        # Proporciones de clases de sitio
        site_prop_match = re.search(r"proportion\s+([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)", content)
        prop_0, prop_1, prop_2 = (float(site_prop_match.group(i)) for i in range(1, 4)) if site_prop_match else (None, None, None)

        # Valores de omega por tipo de rama y clase de sitio
        omega_block = re.findall(r"branch type \d+:\s+(.*)", content)
        omega_by_branch = []
        for line in omega_block:
            try:
                values = list(map(float, line.strip().split()))
                omega_by_branch.append(values)
            except:
                omega_by_branch.append([None, None, None])

        def safe_get(branch_idx, class_idx):
            try:
                return omega_by_branch[branch_idx][class_idx]
            except:
                return None

        results.append({
            "gen": subdir.name.split("_")[0],
            "archivo": txt_file.name,
            "lnL": lnL,
            "np": np,
            "kappa": kappa,
            "prop_class0": prop_0,
            "prop_class1": prop_1,
            "prop_class2": prop_2,
            "w_b0_class0": safe_get(0, 0),
            "w_b0_class1": safe_get(0, 1),
            "w_b0_class2": safe_get(0, 2),
            "w_b1_class0": safe_get(1, 0),
            "w_b1_class1": safe_get(1, 1),
            "w_b1_class2": safe_get(1, 2),
            "w_b2_class0": safe_get(2, 0),
            "w_b2_class1": safe_get(2, 1),
            "w_b2_class2": safe_get(2, 2),
            "w_b3_class0": safe_get(3, 0),
            "w_b3_class1": safe_get(3, 1),
            "w_b3_class2": safe_get(3, 2),
        })

# Guardar resultados
df = pd.DataFrame(results)
output_path = base_path / "resumen_clade_model_completo.tsv"
df.to_csv(output_path, sep="\t", index=False)

print(f"✅ Resultados con clases de sitio guardados en: {output_path}")
print(df.head())
