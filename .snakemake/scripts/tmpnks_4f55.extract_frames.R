
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
    input = list('../videos/20210203/tifs/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.ome.tif'),
    output = list('../ilastik/training/20210306/tifs/20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default.ome.tif'),
    params = list(63, 72, "start" = 63, "end" = 72),
    wildcards = list('20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default', "sample" = '20210301_6_7dpi4dpi_cabcr5inj2_W50_sp0.6_op20_GW_MMStack_Default'),
    threads = 1,
    log = list(),
    resources = list(),
    config = list("samples_file" = 'code/snakemake/20210203/config/samples.csv', "input_dir" = '/nfs/ftp/private/indigene_ftp/upload/OMR_Risa/20210225-0301', "training_dir" = '../ilastik/training/20210306', "extract_frames_script" = 'scripts/extract_frames.R', "output_dir" = '../videos/20210203', "r_container" = '../sing_conts/baseR.sif', "baseR_env" = 'envs/baseR.yaml', "fiji" = '/nfs/software/birney/Fiji.app/ImageJ-linux64', "convert_to_h5_script" = 'code/snakemake/20210203/scripts/convert_tif_to_h5.ijm', "ilastik" = '/nfs/software/birney/ilastik-1.3.3-Linux/run_ilastik.sh', "ilastik_project_pixclass" = '../ilastik/projects/20210107_test_pixclass.ilp', "ilastik_project_anitrack" = '../ilastik/projects/20210107_test_antrack.ilp'),
    rule = 'extract_training_frames',
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

library(ijtiff)

# Extract training frames

tif = ijtiff::read_tif(snakemake@input[[1]],
                       frames = snakemake@params[["start"]]:snakemake@params[["end"]])

# Write file

ijtiff::write_tif(tif, snakemake@output[[1]])
