## Libraries
library(tidyverse)
library(here)
library(readxl)
library(janitor)
library(openxlsx)
capstone_dir <- here('2023', 'Capstone')
capstone_raw_data <- here(capstone_dir, 'raw-data')
capstone_clean_data <- here(capstone_dir, 'clean-data')

## Loading the data
commercial_data <- read_csv(here(capstone_clean_data, '1-commercial_licenses_original.csv'))

## Initializing empty list
unique_cols <- list()

## Checking the necessity for translation
for (i in seq_along(colnames(commercial_data))) {
  
  ## For each col in the dataset:
  
  # Get the unique values
  unique_values <- unique(commercial_data[[i]])
  
  # Store information inside a list
  unique_cols[[colnames(commercial_data)[i]]] <- list(
    count = length(unique_values),
    values = unique_values
  )
  
}

## Columns that needs translatin
cols_need_translation <- c('municipality', 'municipality_branch', 'subcategory', 'category', 'the_service')

## Saving all the data that needs translation
wb <- openxlsx::createWorkbook()

## Creating a different sheet for every column in the data
for (col in cols_need_translation) {
  
  unique_values_col <- commercial_data %>% 
    pull(col) %>% 
    unique()
  
  openxlsx::addWorksheet(wb, col)
  openxlsx::writeData(wb, col, x = str_c(col, '_AR'), startCol = 1, startRow = 1, colNames = F)
  openxlsx::writeData(wb, col, x = str_c(col, '_EN'), startCol = 2, startRow = 1, colNames = F)
  openxlsx::writeData(wb, col, unique_values_col, startCol = 1, startRow = 2, colNames = F)
  
}

# Finalizing the save
openxlsx::saveWorkbook(wb, here(capstone_raw_data, 'columns_to_translate.xlsx'),
                       overwrite = T)


