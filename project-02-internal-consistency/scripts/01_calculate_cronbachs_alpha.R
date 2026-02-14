# ================================
# 01.calculate_cronbachs_alpha.R - 
# ================================

# Empty list that will hold the five Cronbachs alpha values
alpha_list <- list(
  agreeableness_items = c(),
  conscientiousness_items = c(),
  extraversion_items = c(),
  neuroticism_items= c(),
  openness_items = c()
)

# Define items for each subscale
subscales_alpha <- list(
  agreeableness_items = c("A1", "A2", "A3", "A4", "A5"),
  conscientiousness_items = c("C1", "C2", "C3", "C4", "C5"),
  extraversion_items = c("E1", "E2", "E3", "E4", "E5"),
  neuroticism_items= c("N1", "N2", "N3", "N4", "N5"),
  openness_items = c("O1", "O2", "O3", "O4", "O5")
)

# Loop through each subscale item
for (subscale in names(subscales_alpha)) {
 # Calculate the Cronbachs alpha of each subscale
 alpha_list[[subscale]] <- psych::alpha(bfi_clean[, subscales_alpha[[subscale]]]) 
}

# Convert list to dataframe 
alpha_dataframe <- as.data.frame(alpha_list)