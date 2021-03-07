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
