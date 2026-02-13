# ================================
# main.R - Run complete BFI-25 item analysis
# ================================

source("scripts/00_load_and_prep.R")  # Creates bfi_clean
source("scripts/01_calculate_correlations.R")  # Uses bfi_clean
source("scripts/02_visualise.R") # Visualise bfi_clean