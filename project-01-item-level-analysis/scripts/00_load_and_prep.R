# ================================
# 00_load_and_prep.R - 
# ================================

# List of required packages
packages <- c(
  "psych", "psychTools", "GPArotation", "tidyverse", "janitor", "lubridate", "here",
  "skimr", "readxl", "writexl", "corrplot", "ggplot2", "dplyr", "naniar", "gtExtras", 
  "mice", "kableExtra", "corrr", "ggcorrplot", "FactoMineR", "factoextra", "flextable",
  "stringr", "officer"
)

# Install missing packages
installed <- rownames(installed.packages())
for (pkg in packages) {
  if (!pkg %in% installed) {
    install.packages(pkg, dependencies = TRUE)
  }
}

# Load packages
for (pkg in packages) {
  library(pkg, character.only = TRUE)
}
# Optional: confirmation message
message("Packages loaded successfully.")

# ================================
# BFI data checks
# ================================

# Read RDA file
load("bfi.rda")

# Check data loaded correctly
ls()
dim(bfi)

# View first few rows
head(bfi)

# Check structure
str(bfi)

# Summary of data set
summary(bfi)

# Check for missing values
sum(is.na(bfi))
