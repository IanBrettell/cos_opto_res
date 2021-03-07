#!/usr/bin/env Rscript

# Load libraries

library(ijtiff)

# Extract training frames

tif = ijtiff::read_tif(snakemake@input[[1]],
                       frames = snakemake@params[["start"]]:snakemake@params[["end"]])

# Write file

ijtiff::write_tif(tif, snakemake@output[[1]])
