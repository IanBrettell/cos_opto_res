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

# Process data

process_tracking = function(samples_file, in_dir){
  
  # Get samples metadata
  samples_df = readr::read_csv(samples_file)
  
  # Get list of files
  files = list.files(in_dir, full.names = T)
  names(files) = basename(files) %>% 
    stringr::str_remove(".csv")
  
  # Read all into list
  df_list = lapply(files, function(file){
    # get sample name
    sample_name = basename(file) %>% 
      stringr::str_remove(".csv")
    # get target_row from samples_df
    target_row = samples_df %>% 
      dplyr::filter(SAMPLE == sample_name)
    # set up output list
    out = list()
    # get sample name
    out[["META"]] = list()
    out[["META"]][["SAMPLE"]] = sample_name
    # add some metadata
    out[["META"]][["TOTAL_FRAMES"]] = target_row %>% 
      dplyr::pull(TOTAL_FRAMES)
    out[["META"]][["MAX_Y"]] = target_row %>% 
      dplyr::pull(MAX_Y)
    out[["META"]][["N_LANES"]] = target_row %>% 
      dplyr::pull(TOTAL_LANES)
    
    # add lane breaks
    lanes_n = out$META$N_LANES
    
    out[["META"]][["LANE_BREAKS"]] = samples_df %>%
      dplyr::filter(SAMPLE == out$META$SAMPLE) %>%
      dplyr::select(starts_with("END_LANE")) %>%
      subset(select = 1:lanes_n -1) %>%
      unlist(use.names = F) %>% 
      c(0, ., out$META$MAX_Y)
    
    # add tracking data
    out[["RAW"]] = readr::read_csv(file)
    
    # process
    ## create recode vector for `COORD_Y`
    frames_seq = seq(0, out$META$MAX_Y)
    recode_vec = rev(frames_seq)
    names(recode_vec) = frames_seq
    ## run
    out[["CLEAN"]] = out$RAW %>% 
      dplyr::filter(TRACKID != -1) %>% 
      # divide by lane and flip Y coords
      dplyr::mutate(LANE = cut(COORD_Y,
                               breaks = out$META$LANE_BREAKS,
                               labels = F),
                    COORD_X = round(COORD_X),
                    COORD_Y = round(COORD_Y),
                    COORD_Y = dplyr::recode(COORD_Y, !!!recode_vec)) %>% 
      dplyr::arrange(LANE, FRAME) 
    
    return(out)
  })
  
  return(df_list)
}  

generate_tile_plot = function(df_list, out_path){
  # create directory if it doesn't exist
  dir.create(out_path, showWarnings = F, recursive = T)
  out_file = file.path(out_path, "tile.png")
  
  # extract data from list and bind into DF
  lapply(df_list, function(SAMPLE){
    SAMPLE$CLEAN
  }) %>% 
    dplyr::bind_rows(.id = "SAMPLE") %>% 
    ggplot() +
    geom_tile(aes(FRAME, LANE, fill = LANE)) +
    facet_wrap(~SAMPLE, ncol = 1) +
    scale_fill_viridis()
  
  # save
  ggsave(out_file, 
         device = "png",
         width = 20,
         height = 40,
         units = "cm",
         dpi = 400)  
}
