## Imports the class survey data and returns it to the user.

## SETUP =======================================================================
library(dplyr)
library(readr)
library(tibble)
raw_file <- "data/ITD Class Survey Survey Student Analysis Report.csv"
clean_file <- "data/survey.csv"

## DATA ========================================================================
raw <- read_csv(raw_file)
names_raw <- names(raw)
names_clean <- names_raw
names_clean[9] <- "age"
names_clean[11] <- "climate"
names_clean[13] <- "pizza"
names_clean[15] <- "degree"
names_clean[17] <- "used_data"
names_clean[19] <- "year"
names_clean[21] <- "separate"
names_clean[23] <- "do_math"
names_clean[25] <- "like_math"
names_clean[27] <- "counting"
names_clean[29] <- "data_ever"
names_clean[31] <- "data_tool"
names_clean[33] <- "hope"
names_clean[35] <- "why"
names_clean[37] <- "worries"
names_clean[39] <- "state"
names_clean[41] <- "career"
names(raw) <- names_clean

which <- c(c(1:6), 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41)
survey <-
    raw %>%
    select(which)
questions <- names_raw[which]
comment(survey) <- questions
View(survey)

survey %>%
    select(-name, -id, -sis_id, -section, -section_id, -section_sis_id, -used_data, -hope, -worries) %>%
    mutate(id = row_number()) %>%
    select(id, age:career) %>%
    sample_n(size = nrow(raw)) %>%
    write_csv("data/survey.csv")
