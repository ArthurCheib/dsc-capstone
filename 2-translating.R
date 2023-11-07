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
commercial_cols <- colnames(commercial_data)
translated_cols <- c('municipality', 'municipality_branch', 'subcategory', 'category', 'the_service')
translation <- read_excel(here(capstone_clean_data, 'translated_columns_org.xlsx'), 
                          sheet = translated_cols[1])

## For every column that was translated:
for (col in translated_cols) {
  
  # Open the sheet containing the translation as a df
  translation <- read_excel(here(capstone_clean_data, 'translated_columns-org.xlsx'),
                            sheet = col)
  
  colnames(translation)[1] <- col
  
  # Discover the position of the arabic column + get the name in english
  en_col_name <- str_c(col, '_EN')
  
  # Merge it with the commercial data
  commercial_data <- commercial_data %>% 
    left_join(translation,
              by = col) %>% 
    select('id':col, any_of(en_col_name), everything(.))
    
}

## Saving the translated data
write_csv(commercial_data, here(capstone_clean_data, '2-commercial_licenses_translated.csv'))
