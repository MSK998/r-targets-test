
get_data_files <- function(dir) {
  list.files(dir, full.names = TRUE)
}

read_data_file <- function(path) {
  read.csv(path)
}

combine_data <- function(dataframes) {
  bind_rows(dataframes)
}

plot_age_dist <- function(dataset) {
  print(summary(dataset))
  ggplot(dataset, aes(x = Age)) +
    geom_histogram(binwidth = 5, fill = "steelblue", color = "black", alpha = 0.7) +
    scale_y_continuous(transform = "log10") +
    labs(title = "Age Distribution", x = "Age", y = "Count") +
    theme_minimal()
}

ingest_files <- function(data_dir) {
  new_files <- dir_ls(data_dir, regexp = ".csv$") 
  existing <- dir_ls(path(data_dir,"processed"))
  
  to_process <- setdiff(new_files, existing)
  
  map(to_process, ~{
    df <- read_csv_chunked(.x, DataFrameCallback$new(function(x, pos) {
      x %>% mutate(ingest_version = as.double(format(Sys.Date(), "%Y%m%d")))
    }), chunk_size = 1000)
    
    output_path <- path(data_dir,"processed", path_file(.x))
    if(file_exists(output_path)) {
      existing_df <- read_csv(output_path)
      df <- bind_rows(existing_df, df) %>% distinct()
    }
    write_csv(df, output_path)
  })
  
}

