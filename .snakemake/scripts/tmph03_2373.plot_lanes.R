
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
    input = list('/hps/research1/birney/users/ian/opto_res/videos/20210203/tifs/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.ome.tif'),
    output = list('plots/20210203/lane_demarcations/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.png'),
    params = list('code/snakemake/20210203/config/samples.csv', '20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default', "samples_file" = 'code/snakemake/20210203/config/samples.csv', "sample_name" = '20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default'),
    wildcards = list('20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default', "sample" = '20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default'),
    threads = 1,
    log = list(),
    resources = list(),
    config = list("samples_file" = 'code/snakemake/20210203/config/samples.csv', "input_dir" = '/nfs/ftp/private/indigene_ftp/upload/OMR_Risa/20210225-0301', "training_dir" = '/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306', "extract_frames_script" = 'scripts/extract_frames.R', "output_dir" = '/hps/research1/birney/users/ian/opto_res/videos/20210203', "plots_dir" = 'plots/20210203/lane_demarcations', "r_container" = '../sing_conts/baseR.sif', "plot_lanes_script" = 'scripts/plot_lanes.R', "fiji" = '/nfs/software/birney/Fiji.app/ImageJ-linux64', "convert_to_h5_script" = 'code/snakemake/20210203/scripts/convert_tif_to_h5.ijm', "ilastik_container" = '../sing_conts/Ilastik.sif', "ilastik_run" = '/ilastik-release/run_ilastik.sh', "ilastik_project_pixclass" = '../ilastik/projects/20210107_test_pixclass.ilp', "ilastik_project_anitrack" = '../ilastik/projects/20210107_test_anitrack.ilp', "training_results_dir" = '/hps/research1/birney/users/ian/opto_res/ilastik/training/20210306/results/pass_1/raw', "full_results_dir" = '/hps/research1/birney/users/ian/opto_res/videos/20210203/results/pass_1/raw', "extract_columns_script" = 'scripts/extract_columns.R', "full_results_out" = 'data/tracking/20210203/pass_1'),
    rule = 'draw_lanes',
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
library(ijtiff)
library(magick)

# Read in samples file

samples_df = readr::read_csv(snakemake@params[["samples_file"]])
sample_name = snakemake@params[["sample_name"]]

# Get lane coords

## Total lanes in video
lanes_n = samples_df %>%
  dplyr::filter(SAMPLE == sample_name) %>%
  dplyr::pull(TOTAL_LANES)

## Get lane coords
lane_coords = samples_df %>%
  dplyr::filter(SAMPLE == sample_name) %>%
  dplyr::select(starts_with("END_LANE")) %>%
  subset(select = 1:lanes_n -1) %>%
  unlist(use.names = F)

# read first frame of tiff
frame_1 = ijtiff::read_tif(snakemake@input[[1]], frames = 1)

# write to file (magick can't read directly...)
tmp_file_name = paste(sample_name, ".tmp.tif", sep = "")
ijtiff::write_tif(frame_1, tmp_file_name)

# read back in as magick image
frame_1_m = magick::image_read(tmp_file_name)

# add horizontal lines

img = magick::image_draw(frame_1_m) # make image object
abline(h = lane_coords, col = "white") # draw lines
lined_img = magick::image_scale(img, 1000) %>% # shrink
    magick::image_modulate(brightness = 700) # increase brightness
dev.off()

# write image

magick::image_write(lined_img, path = snakemake@output[[1]], format = "png")

# clean up

file.remove(tmp_file_name)
