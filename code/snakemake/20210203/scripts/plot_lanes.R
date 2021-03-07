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
lined_img = magick::image_scale(img, 1000) # shrink
dev.off()

# write image

magick::image_write(lined_img, path = snakemake@output[[1]], format = "png")

# clean up

file.remove(tmp_file_name)
