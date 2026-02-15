# ================================
# main.R - Run complete BFI-25 internal consistency analysis
# ================================

source("scripts/00_load_and_prep.R")  # Creates bfi_clean
source("scripts/01_calculate_cronbachs_alpha.R")  # Extracts alpha from bfi_clean subscales