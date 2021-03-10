
######## snakemake preamble start (automatically inserted, do not edit) ########
library(methods)
Snakemake <- setClass(
    "Snakemake",
    slots = c(
        input = "list",
        output = "list",
        params = "list",
        wildcards = "list",
        threads = "numeric",
        log = "list",
        resources = "list",
        config = "list",
        rule = "character",
        bench_iteration = "numeric",
        scriptdir = "character",
        source = "function"
    )
)
snakemake <- Snakemake(
    input = list('/hps/research1/birney/users/ian/opto_res/videos/20210203/pass_2/results/raw/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default_CSV-Table.csv.csv'),
    output = list('data/tracking/20210203/pass_2/20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default.csv'),
    params = list(),
    wildcards = list('20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default', "sample" = '20210301_3_7dpi4dpi_cabcr5inj2_W50_sp0.6_op50_GW_MMStack_Default'),
    threads = 1,
    log = list(),
    resources = list(),
    config = list("samples_file" = 'code/snakemake/20210203/config/samples.csv', "training_samples_file" = 'code/snakemake/20210203/config/samples_pass_2_training.csv', "input_dir" = '/nfs/ftp/private/indigene_ftp/upload/OMR_Risa/20210225-0301', "training_dir" = '/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/pass_2', "extract_frames_script" = 'scripts/extract_frames.R', "output_dir" = '/hps/research1/birney/users/ian/opto_res/videos/20210203', "plots_dir" = 'plots/20210203/lane_demarcations', "r_container" = '../sing_conts/baseR.sif', "plot_lanes_script" = 'scripts/plot_lanes.R', "fiji" = '/nfs/software/birney/Fiji.app/ImageJ-linux64', "convert_to_h5_script" = 'code/snakemake/20210203/scripts/convert_tif_to_h5.ijm', "pass_dir" = '/hps/research1/birney/users/ian/opto_res/videos/20210203/pass_2', "ilastik_container" = '../sing_conts/Ilastik.sif', "ilastik_run" = '/ilastik-release/run_ilastik.sh', "ilastik_project_pixclass" = '../ilastik/projects/20210107_test_pixclass.ilp', "ilastik_project_anitrack" = '../ilastik/projects/20210107_test_anitrack.ilp', "training_results_dir" = '/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/results/pass_2/raw', "extract_columns_script" = 'scripts/extract_columns.R', "full_results_out" = 'data/tracking/20210203/pass_2'),
    rule = 'extract_columns',
    bench_iteration = as.numeric(NA),
    scriptdir = '/hps/research1/birney/users/ian/opto_res/cos_opto_res/code/snakemake/20210203/scripts',
    source = function(...){
        wd <- getwd()
        setwd(snakemake@scriptdir)
        source(...)
        setwd(wd)
    }
)


######## snakemake preamble end #########
#!/usr/bin/env Rscript

# Load libraries

library(tidyverse)

# Read in file, select target columns and write to table

readr::read_csv(snakemake@input[[1]]) %>%
  dplyr::select(FRAME = frame,
                TRACKID = trackId,
                COORD_X = Object_Center_0,
                COORD_Y = Object_Center_1) %>%
  readr::write_csv(snakemake@output[[1]])
