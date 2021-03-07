#!/usr/bin/env Rscript

# Load libraries

library(tidyverse)

# Get column types

cols = c("i", "_", "i", rep("_", 35), "d", "d", rep("_", 8))
cols = paste(cols, collapse = "")

# Import CSV and extract key columns

readr::read_csv(snakemake@input[[1]],
                col_types = cols) %>%
    readr::write_csv(snakemake@output[[2]])
            
