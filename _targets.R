# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
# library(tarchetypes) # Load other packages as needed.

# Set target options:
tar_option_set(
  packages = c("tibble", "ggplot2", "tidyverse", "readr", "fs")
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source()
# tar_source("other_functions.R") # Source other scripts as needed.


list(
  # tar_target(get_filenames, get_data_files(paste(getwd(),"Data", sep = "/"))),
  # tar_target(read, map(get_filenames, read_data_file), pattern = map(get_filenames)),
  tar_target(data_dir, path(getwd(),"Data"), format = "file"),
  tar_target(raw_data, ingest_files(data_dir)),
  tar_target(combine, combine_data(raw_data)),
  tar_target(clean, {
    combine %>%
      mutate(across(where(is.numeric), ~ifelse(.x < 0, 0, .x)))
  }),
  tar_target(analyse, plot_age_dist(clean))
)

# tar_visnetwork() to see the dependency tree
# tar_read() to show plots or data in the console
# tar_load() to load the variable into the environment
