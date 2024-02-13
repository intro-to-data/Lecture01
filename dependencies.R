## Simple script used to install all packages needed by the lecture/lab.

p <- c(
    "ggrepel",
    "httpgd",
    "knitr",
    "lubridate",
    "markdown",
    "revealjs",
    "rio",
    "rmarkdown",
    "shiny",
    "tidyverse"
)
install.packages(p)

unlink("lab-answers.qmd")