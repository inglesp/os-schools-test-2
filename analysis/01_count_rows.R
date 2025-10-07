library(tidyverse)

data_dir <- "data"
output_dir <- "output"
output_file <- file.path(output_dir, "counts.csv")

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

csv_files <- list.files(path = data_dir, pattern = "\\.csv$", full.names = TRUE)

row_counts <- tibble(
  file = basename(csv_files),
  rows = map_int(csv_files, ~ nrow(read_csv(.x, show_col_types = FALSE)))
)

write_csv(row_counts, output_file)

cat("Row counts written to:", output_file, "\n")
