#!/bin/sh
# properties = {"type": "single", "rule": "ilastik_probs", "local": false, "input": ["/hps/research1/birney/users/ian/opto_res/videos/20210203/h5s/20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006.h5"], "output": ["/hps/research1/birney/users/ian/opto_res/videos/20210203/h5s/20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006_Probabilities.h5"], "wildcards": {"sample": "20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 4, "cluster": {"memory": "5000", "n": "1", "name": "ilastik_probs.sample=20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006", "output": "../log/ilastik_probs_sample=20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006.out", "error": "../log/ilastik_probs_sample=20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006.err"}}
 cd /hps/research1/birney/users/ian/opto_res/cos_opto_res && \
PATH='/nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin':$PATH /nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin/python3.9 \
-m snakemake /hps/research1/birney/users/ian/opto_res/videos/20210203/h5s/20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006_Probabilities.h5 --snakefile /hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.k3oek44b /hps/research1/birney/users/ian/opto_res/videos/20210203/h5s/20210203_cab_50_green_90_op_0.6_sp_MMStack_Default.ome-006.h5 --latency-wait 300 \
 --attempt 1 --force-use-threads --scheduler ilp \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules ilastik_probs --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  && touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.k3oek44b/4.jobfinished || (touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.k3oek44b/4.jobfailed; exit 1)

