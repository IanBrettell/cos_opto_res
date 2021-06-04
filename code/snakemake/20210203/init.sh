#!/bin/bash

# Bash script to run on EBI codon cluster:

bsub -Is bash
cd /hps/software/users/birney/ian/repos/cos_opto_res
conda activate snakemake
snakemake \
  --jobs 5000 \
  --latency-wait 100 \
  --cluster-config code/snakemake/20210203/config/cluster.json \
  --cluster 'bsub -g /snakemake_bgenie -J {cluster.name} -n {cluster.n} -M {cluster.memory} -o {cluster.output} -e {cluster.error}' \
  --keep-going \
  --rerun-incomplete \
  --use-conda \
  --use-singularity \
  -s code/snakemake/20210203/Snakefile \
  -pn

# Bash script to run on Heidelberg cluster:

