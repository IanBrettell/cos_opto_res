#!/bin/sh
# properties = {"type": "single", "rule": "draw_lanes", "local": false, "input": ["/hps/research1/birney/users/ian/opto_res/videos/20210203/tifs/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.ome.tif"], "output": ["plots/20210203/lane_demarcations/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.png"], "wildcards": {"sample": "20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default"}, "params": {"samples_file": "code/snakemake/20210203/config/samples.csv", "sample_name": "20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default"}, "log": [], "threads": 1, "resources": {}, "jobid": 49, "cluster": {"memory": "5000", "n": "1", "name": "draw_lanes.sample=20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default", "output": "../log/draw_lanes_sample=20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.out", "error": "../log/draw_lanes_sample=20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.err"}}
 cd /hps/research1/birney/users/ian/opto_res/cos_opto_res && \
PATH='/nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin':$PATH /nfs/research1/birney/users/brettell/anaconda3/envs/snakemake/bin/python3.9 \
-m snakemake plots/20210203/lane_demarcations/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.png --snakefile /hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx /hps/research1/birney/users/ian/opto_res/videos/20210203/tifs/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.ome.tif --latency-wait 1000 \
 --attempt 1 --force-use-threads --scheduler ilp \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules draw_lanes --nocolor --notemp --no-hooks --nolock \
--mode 2  --use-conda  --use-singularity  && touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx/49.jobfinished || (touch /hps/research1/birney/users/ian/opto_res/cos_opto_res/.snakemake/tmp.fp2h2jtx/49.jobfailed; exit 1)

