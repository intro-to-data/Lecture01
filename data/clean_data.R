## Imports the class survey data and returns it to the user.

## SETUP =======================================================================
library(dplyr)
library(lubridate)
library(readr)
library(stringr)
library(tibble)
raw_data_file <- "data/ITD Class Survey Survey Student Analysis Report.csv"
survey_data_file <- "data/survey.csv"

## DATA ========================================================================
raw <- 
  read_csv(raw_data_file) |>
  mutate(submitted = date(ymd_hms(submitted)))

names_raw <- names(raw)
names_clean <- names_raw
#if (interactive()) {
#    library(knitr)
#    glimpse(raw)
#    kable(names_raw)
#}

# Convenience function used below to make sure I don't make a future edit
# that breaks my string searches below. I was using straight col numbers, but it
# was a little unreliable.
check_number_found <- function(x) {
    if (length(x) > 1) stop("More than one column found.")
    if (length(x) == 0) stop("No columns found.")
    x
}
cols_to_keep <- numeric()



## Column names are renamed in the order they were given the day I did this.
which_col <- check_number_found(str_which(names_raw, "submitted"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "submitted"
rm(which_col)


which_col <- check_number_found(str_which(names_raw, "How tall"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "how_tall"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "What state"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "what_state"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "favorite kind of pizza"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "favorite_pizza"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "What year"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "what_year"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "your Degree"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "what_degree"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "tried to use data"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "tried_use_data"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "have you ever used?"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "data_tool_used"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "What is \\(5"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "order_operations_test"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "Are you good at counting thing?"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "good_at_counting"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "Do you like math?"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "like_math"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "Have you ever analyzed data?"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "ever_analyzed_data"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "wondering why I am asking"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "wondering_why"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "current age"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "age"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "considered a career"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "career"
rm(which_col)

which_col <- check_number_found(str_which(names_raw, "climate"))
cols_to_keep <- c(cols_to_keep, which_col)
names_clean[which_col] <- "climate"
rm(which_col)

survey <-
    raw |>
    select(cols_to_keep)
# comment(survey) <- questions
names(survey) <- names_clean[cols_to_keep]
questions <- data.frame(
    clean_name = names(survey),
    ## Improves report formatting by removing the column ids from the answers
    ## and it also removes the \n at the beginning of some questions.
    raw_names = str_remove(str_remove(names_raw[cols_to_keep], "[0-9]*\\: "), "^\n")
)

if (interactive()) {
    View(survey)
    View(questions)
}

survey |>
    mutate(id = row_number()) |>
    write_csv(survey_data_file)

questions |>
    mutate(col_num = row_number()) |>
    write_csv("data/questions.csv")
