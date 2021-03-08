#!/bin/sh
# properties = {"type": "single", "rule": "training_ilastik_probs", "local": false, "input": ["/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/pass_2/h5s/20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.h5"], "output": ["/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/pass_2/h5s/20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default_Probabilities.h5"], "wildcards": {"training_sample": "20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default"}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 129, "cluster": {"memory": "30000", "n": "1", "name": "training_ilastik_probs.training_sample=20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default", "output": "../log/training_ilastik_probs_training_sample=20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.out", "error": "../log/training_ilastik_probs_training_sample=20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.err"}}
 cd /hps/research1/birney/users/ian/opto_res/cos_opto_res && \
PATH='/nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin':$PATH /nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin/python3.9 \
-m snakemake /hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/pass_2/h5s/20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default_Probabilities.h5 --snakefile /hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.jv9305l7 /hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/pass_2/h5s/20210301_4_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.h5 --latency-wait 1000 \
 --attempt 1 --force-use-threads --scheduler ilp \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules training_ilastik_probs --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --use-singularity  && touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.jv9305l7/129.jobfinished || (touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.jv9305l7/129.jobfailed; exit 1)

