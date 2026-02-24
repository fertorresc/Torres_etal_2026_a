# Workflow for reproducing Mazzaella laminarioides genomic analyses

This document describes the order of analyses and where each manuscript result is generated.

---

# 1. Metadata preparation

Input:
metadata/sample_table.tsv

Must include:
- sample ID
- lineage
- locality
- sequencing type
- sex

Used across all analyses.

---

# 2. Genome assembly (optional)

Skip if using public assemblies.

Scripts:
assembly/run_masurca.sh
assembly/polishing_pilon.sh
assembly/blobtools_filter.sh
assembly/repeats_masking.sh
assembly/quast_assessment.sh
assembly/busco_assessment.sh

Outputs:
results/assembly/
results/assembly_qc/

Used in supplementary genome tables.

---

# 3. Genome annotation (optional)

Scripts:
annotation/run_hisat2.sh
annotation/run_trinity.sh
annotation/run_transdecoder.sh
annotation/run_braker.sh

Outputs:
results/annotation/

---

# 4. Phylogenomics

Ortholog inference:
phylogenomics/orthofinder_run.sh

Alignments:
phylogenomics/align_mafft.sh
phylogenomics/filter_bmge.sh

Species tree inference:
phylogenomics/run_starbeast2.sh
phylogenomics/combine_runs.sh

Discordance:
phylogenomics/phyparts_run.sh

Topology tests:
phylogenomics/monophyly_test.R

Outputs:
results/phylogenomics/

Used in Figure 1.

---

# 5. Selection analyses (PAML)

Run models:
selection/run_codeml.sh

Control files:
selection/codeml_branch.ctl
selection/codeml_clade.ctl

Extract statistics:
selection/extract_lnL_np.py
selection/run_LRT_FDR.R

Heatmap:
selection/heatmap_dn_ds.R

Outputs:
results/selection/

Used in Figure 2.

---

# 6. Demographic inference (DILS)

Prepare windows:
dils/prepare_fasta_windows.py

Run models:
dils/run_dils.sh

Plot summaries:
dils/posterior_plotting.R

Outputs:
results/dils/

Used in Figure 3.

---

# 7. PSMC analyses

Mapping:
psmc/mapping_minimap2.sh
psmc/snp_calling_bcftools.sh

Pseudo-diploids:
psmc/make_pseudodiploids.sh

Run PSMC:
psmc/psmc_run.sh

Plot trajectories:
psmc/psmc_plot.R

Outputs:
results/psmc/

Used in Figure 4.

---

# 8. ABBA-BABA tests

Run:
abba_baba/dsuite_run.sh

Plot:
abba_baba/abba_baba_plot.R

Outputs:
results/abba_baba/

---

# 9. Figures

All final figures should be reproducible using scripts in:

figures/

Outputs:
figures_out/

---

# 10. Reproducibility checks

- Ensure consistent sample IDs across analyses
- Verify StarBEAST2 convergence
- Remove unrealistic omega estimates in codeml
- Confirm population assignments in DILS and Dsuite

