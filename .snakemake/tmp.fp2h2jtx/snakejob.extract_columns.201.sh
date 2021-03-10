#!/bin/sh
# properties = {"type": "single", "rule": "extract_columns", "local": false, "input": ["/hps/research1/birney/users/ian/opto_res/videos/20210203/pass_2/results/raw/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default_CSV-Table.csv.csv"], "output": ["data/tracking/20210203/pass_2/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.csv"], "wildcards": {"sample": "20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 201, "cluster": {"memory": "5000", "n": "1", "name": "extract_columns.sample=20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default", "output": "../log/extract_columns_sample=20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.out", "error": "../log/extract_columns_sample=20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.err"}}
 cd /hps/research1/birney/users/ian/opto_res/cos_opto_res && \
PATH='/nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin':$PATH /nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin/python3.9 \
-m snakemake data/tracking/20210203/pass_2/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.csv --snakefile /hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx /hps/research1/birney/users/ian/opto_res/videos/20210203/pass_2/results/raw/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default_CSV-Table.csv.csv --latency-wait 1000 \
 --attempt 1 --force-use-threads --scheduler ilp \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules extract_columns --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --use-singularity  && touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx/201.jobfinished || (touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx/201.jobfailed; exit 1)

