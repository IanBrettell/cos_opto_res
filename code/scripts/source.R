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

get_training_samples = function(samples_file, prev_pass, n_frames = 10, min_lanes_success = 1, seed){
  # Read in data
  samples_df = readr::read_csv(samples_file)
  prev_pass_df = readr::read_csv(prev_pass)
  
  # NON-TRACKED
  failed_samples = samples_df$SAMPLE[which(!samples_df$SAMPLE %in% unique(prev_pass_df$SAMPLE))]
  
  training_samples = data.frame(SAMPLE = failed_samples) %>% 
    dplyr::left_join(dplyr::select(samples_df, SAMPLE, TOTAL_FRAMES, SAMPLE_START, SAMPLE_END),
                     by = "SAMPLE")
  
  # get random start and end
  final_nontracked = get_random_start(training_samples,
                                      n_frames = n_frames,
                                      seed = seed)
  
  # POORLY-TRACKED
  
  # Find frames only covered by one lane
  poor_tracking = prev_pass_df %>% 
    dplyr::group_by(SAMPLE, FRAME) %>% 
    dplyr::count() %>% 
    dplyr::filter(n <= min_lanes_success)
  
  set.seed(seed)
  poor_frames = lapply(unique(poor_tracking$SAMPLE), function(target_sample){
    # get final frame
    final_frame = samples_df %>% 
      dplyr::filter(SAMPLE == target_sample) %>% 
      dplyr::pull(TOTAL_FRAMES)
    # get last frame to sample
    final_frame_sample = final_frame - n_frames
    # extract random frame
    target_frame = poor_tracking %>% 
      dplyr::filter(SAMPLE == target_sample & FRAME <= final_frame_sample) %>% 
      dplyr::ungroup() %>% 
      dplyr::slice_sample(n = 1) %>% 
      dplyr::pull(FRAME)
    
    # create output df
    out = data.frame(SAMPLE = target_sample,
                     TOTAL_FRAMES = final_frame,
                     SAMPLE_START = target_frame,
                     SAMPLE_END = target_frame + (n_frames -1 ))
  }) %>% 
    dplyr::bind_rows()
  
  # Bind non-tracked to poorly-tracked DFs
  final_samples = bind_rows(final_nontracked,
                            poor_frames)
  
  
  return(final_samples)
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
