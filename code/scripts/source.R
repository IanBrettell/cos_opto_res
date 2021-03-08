###########################
# Libraries
###########################

library(tidyverse)
library(ijtiff)
library(gganimate)

###########################
# Functions
###########################

# Get random start frames for training
get_random_start = function(df, n_frames, seed){
  
  df = df %>% 
    dplyr::mutate(LAST_SAMPLE  = TOTAL_FRAMES - (n_frames - 1))
  
  # get column index
  target_index = which(colnames(df) == "LAST_SAMPLE")
  
  # get random start frames
  set.seed(seed)
  df$SAMPLE_START = sapply(1:nrow(df), function(x){
    sample(1:df[[x, target_index]], size = 1)
  })
  
  # add end frame and write to file
  df = df %>% 
    dplyr::mutate(SAMPLE_END = SAMPLE_START + (n_frames - 1)) %>% 
    dplyr::select(-LAST_SAMPLE) 
  
  return(df)
}
