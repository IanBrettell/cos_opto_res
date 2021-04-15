#!/usr/bin/env Rscript

# Load libraries

library(tidyverse)
library(ijtiff)
library(magick)

# Get variables

in_file = snakemake@input[[1]]
out_file = snakemake@output[[2]]

# Convert TIF to AVI

