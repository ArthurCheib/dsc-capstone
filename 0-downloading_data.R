## Libraries
library(readxl)
library(here)
library(janitor)
library(tidyverse)
capstone_dir <- here('2023', 'Capstone')
capstone_raw_data <- here(capstone_dir, 'raw-data')

## URLs: on these four URLS we have four excel files about commercial licenses in Saudi
urls <- list(first_quarter_2021 = "http://www.momrah.gov.sa/sites/default/files/2022-08/alrkhs-altjaryt-llrb-alawl-2021.xlsx",
             second_quarter_2021 = 'http://www.momrah.gov.sa/sites/default/files/2022-08/alrkhs-altjaryt-llrb-althany-2021.xlsx',
             third_quarter_2021 = 'http://www.momrah.gov.sa/sites/default/files/2022-08/alrkhs-altjaryt-llrb-althalth-2021.xlsx',
             fourth_quarter_2021 = 'http://www.momrah.gov.sa/sites/default/files/2022-08/alrkhs-altjaryt-llrb-alrab-2021.xlsx',
             first_quarter_2022 = 'http://www.momrah.gov.sa/sites/default/files/2022-08/alrkhs-altjaryt-llrb-alawl-2022.xlsx')

dest_files <- list(first_quarter_2021 = "1st_quarter_commercial_licenses_21.xlsx",
                   second_quarter_2021 = '2nd_quarter_commercial_licenses_21.xlsx',
                   third_quarter_2021 = '3rd_quarter_commercial_licenses_21.xlsx',
                   fourth_quarter_2021 = '4th_quarter_commercial_licenses_21.xlsx',
                   first_quarter_2022 = '1st_quarter_commercial_licenses_22.xlsx')

## Downloading all the files ##
for (i in seq_along(urls)) {
  
  download.file(urls[[i]], here(capstone_raw_data,
                             dest_files[[i]]),
                mode = "wb",
                timeout = 500)
  
}

## Cleaning the files ##
## Cleaning steps
# 1) Merge all data into one df
# 2) Set the header of columns to R format + translated header

## Cleaning the header = the translation for the cols of the downloaded data
header <- make_clean_names(c(
  "id",
  'Municipality',
  "Municipality code",
  "Municipality branch",
  "Municipality branch code",
  "Subcategory",
  "Subcategory code",
  "Category",
  "Category code",
  "Date of issuance",
  "Date of expiration",
  "The service",
  "Date of the request"))

## Loading the data
commercial_files <- list.files(capstone_raw_data, pattern = 'commercial')
commercial_data <- map(here(capstone_raw_data, commercial_files),
                       read_excel) %>% 
  bind_rows() %>% 
  setNames(header)

## Saving the result
write_csv(commercial_data, here(capstone_dir, 'clean-data', 'commercial_licenses.csv'))
