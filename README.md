# Pipeline for tracking medaka in opto-res experiments


## Instructions

1. Navigate to cluster
2. Set up directory structure, e.g. `repos`, `working`
3. Clone this repo
```bash
cd repos
git clone https://github.com/brettellebi/cos_opto_res.git
```
4. Install miniconda
5. Install snakemake: 
```bash
conda create -f code/snakemake/20210203/envs/snakemake_6.4.1.yaml
```
6. Adapt `config.yaml` and `init.sh`
