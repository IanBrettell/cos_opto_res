#!/bin/sh
# properties = {"type": "single", "rule": "tif2h5", "local": false, "input": ["../videos/20210203/raw/20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.tif"], "output": ["../videos/20210203/h5s/20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.h5"], "wildcards": {"sample": "20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 2, "cluster": {"memory": "10000", "n": "1", "name": "tif2h5.sample=20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004", "output": "log/tif2h5_sample=20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.out", "error": "log/tif2h5_sample=20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.err"}}
 cd /hps/research1/birney/users/ian/opto_res/cos_opto_res && \
PATH='/nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin':$PATH /nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin/python3.9 \
-m snakemake ../videos/20210203/h5s/20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.h5 --snakefile /hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.ruq_99ni ../videos/20210203/raw/20210203_cab_50_green_80_op_0.6_sp-2_MMStack_Default.ome-004.tif --latency-wait 100 \
 --attempt 1 --force-use-threads --scheduler ilp \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules tif2h5 --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  && touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.ruq_99ni/2.jobfinished || (touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.ruq_99ni/2.jobfailed; exit 1)

