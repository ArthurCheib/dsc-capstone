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
commercial_data <- read_csv(here(capstone_clean_data, '2-commercial_licenses_translated.csv'))

## Step1: removing unnecessary words from columns
# Word 'municipality' from the municipality_EN col
# Keep only words "Issuance" and 'Renewal' words on the_service_EN col
commercial_data_cleaned <- commercial_data %>% 
  mutate(municipality_EN = str_trim(str_remove(municipality_EN,
                                               'Municipality'), side = 'both'),
         the_service_EN = str_trim(str_remove(the_service_EN,
                                              ' of Commercial License'), side = 'both')) %>% 
  mutate(date_of_the_request = factor(date_of_the_request,
                                      levels = c("2021-1", "2021-2", "2021-3",
                                                 "2021-4", "2022-1"))) %>% 
  ## Cleaning the `municipality_EN` column
  mutate(municipality_EN = str_trim(str_remove(municipality_EN,
                                               pattern = c('Region|Governorate')),
                                    side = 'both'))


## Step2: cleaning the `municipality_branch_EN` column
undesired_words <- c('Municipality', 'Sub-municipality', 'Sub-Municipality',
                     'municipality', 'Governorate', 'governorate', 'Municipality of',
                     ' of', 'of')

separeted_branchCol <- commercial_data_cleaned %>% 
  select(municipality_branch_EN) %>% 
  separate(col = municipality_branch_EN, into = c(str_c('word', c(1:6))), sep = ' ')

separeted_branchCol2 <- separeted_branchCol %>% 
  mutate(word1 = if_else(word1 %in% undesired_words, NA, word1),
         word2 = if_else(word2 %in% undesired_words, NA, word2),
         word3 = if_else(word3 %in% undesired_words, NA, word3),
         word4 = if_else(word4 %in% undesired_words, NA, word4),
         word5 = if_else(word5 %in% undesired_words, NA, word5),
         word6 = if_else(word6 %in% undesired_words, NA, word6))

separeted_branchCol2[is.na(separeted_branchCol2)] <- ''

new_col <- character(nrow(separeted_branchCol2))

for (i in seq_along(new_col)) {
  
  new_col[i] <- str_c(separeted_branchCol2[[1]][i],
                      separeted_branchCol2[[2]][i],
                      separeted_branchCol2[[3]][i],
                      separeted_branchCol2[[4]][i],
                      separeted_branchCol2[[5]][i],
                      separeted_branchCol2[[6]][i], sep = ' ')
  
}

## Putting the column now transformed back to place
commercial_data_final <- commercial_data_cleaned %>% 
  mutate(municipality_branch_EN = str_trim(new_col, side = 'both'))


# No more steps are necessary
## Saving the file
write_csv(commercial_data_final, here(capstone_clean_data, '3-commercial_licenses_cleaned.csv'))
