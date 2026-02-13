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

# ================================
# Clean BFI data set
# ================================

{
  reverse_items <- c()   # Create empty vector to store reverse-coded item names
  for (i in bfi.keys)       # Loop through each Big Five dimension in bfi.keys
    for (j in i)  # Loop through each individual item within the current dimension
      if (substr(j, 1, 1) == "-")     # Check if the item name starts with a minus sign
        reverse_items <- append(reverse_items, j)    # If true, add the item name to the reverse_items vector
}

print(reverse_items)

bfi_clean <- bfi  # Create a copy of bfi with ALL columns
clean_items <- sub("-", "", reverse_items)  # Get the clean column names
bfi_clean <- bfi_clean %>%
  mutate(across(all_of(clean_items), ~ 7 - .))  # Transform only those specific columns

# Calculate dimension totals
# This creates five new columns, one for each Big Five dimension
bfi_clean <- bfi_clean %>%
  mutate(
    agreeableness_total = rowSums(select(., A1, A2, A3, A4, A5), na.rm = TRUE),
    conscientiousness_total = rowSums(select(., C1, C2, C3, C4, C5), na.rm = TRUE),
    extraversion_total = rowSums(select(., E1, E2, E3, E4, E5), na.rm = TRUE),
    neuroticism_total = rowSums(select(., N1, N2, N3, N4, N5), na.rm = TRUE),
    openness_total = rowSums(select(., O1, O2, O3, O4, O5), na.rm = TRUE)
  )

# List containing item dimensions
dimensions <- list(
  agreeableness_items = c("A1", "A2", "A3", "A4", "A5"),
  conscientiousness_items = c("C1", "C2", "C3", "C4", "C5"),
  extraversion_items = c("E1", "E2", "E3", "E4", "E5"),
  neuroticism_items = c("N1", "N2", "N3", "N4", "N5"),
  openness_items = c("O1", "O2", "O3", "O4", "O5")
)
