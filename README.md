# Mazzaella laminarioides genomics project

This repository contains scripts, configuration files, and plotting code required to reproduce the analyses and figures from the manuscript:

Genome-wide insights into the evolutionary and demographic history of the red alga *Mazzaella laminarioides*: speciation with ancient migration along the southeast Pacific coast

Authors:  
M.F.T., F.S-E., P.C., M.-L.G.

---

## Overview

This project integrates genome assembly, annotation, phylogenomics, demographic inference, introgression tests, and selection analyses to reconstruct the evolutionary history of *Mazzaella laminarioides*.

Analyses included:

- Whole-genome assembly and annotation  
- Orthology inference and phylogenomics  
- Gene tree discordance analyses  
- Demographic inference using DILS  
- Historical population size inference using PSMC  
- Introgression testing using ABBA-BABA (Dsuite)  
- Selection inference using PAML (branch models + Clade Model C)

Large datasets are stored in external repositories.  
This GitHub repository contains scripts, parameters, metadata, and figure-generation code.

---

## Repository structure

XXXX/        XXX  
Scripts/        script for orthology, codeml runs, LRT test, monophyly  
Dils/            demographic modelling parameters  
data_links.md    links to external data repositories  

---

## Data availability

Raw reads, assemblies, and SNP datasets are stored externally (see `data_links.md`).  
This repository assumes data are downloaded locally before running scripts.

---

## Requirements

Key tools include:

FastQC, MaSuRCA, BWA/minimap2, Pilon, QUAST, BUSCO, BlobTools, RepeatMasker,  
HISAT2, Trinity, TransDecoder, BRAKER3, CD-HIT, OrthoFinder, MAFFT, BMGE,  
BEAST2/StarBEAST2, PhyParts, bcftools, seqtk, PSMC, Dsuite, PAML, R.

Exact versions should be listed in `software_versions.yml`.

---

## Reproducing analyses

See:

WORKFLOW.md

for the complete execution order.

---

## Reproducibility notes

- Scripts assume execution from repository root.
- Paths to local datasets should be edited at the top of each script.
- Intermediate files are not tracked.
- Fix random seeds when possible.

---

## Citation

Please cite the associated manuscript and the software tools listed in the paper.

---

## Contact

Open an issue or contact the corresponding author.

