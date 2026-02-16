# ================================
# 01.calculate_cronbachs_alpha.R -
# ================================

# Empty list that will hold the five Cronbachs alpha values
alpha_list <- list(
  agreeableness_items = c(),
  conscientiousness_items = c(),
  extraversion_items = c(),
  neuroticism_items = c(),
  openness_items = c()
)

# Define items for each subscale
subscales_alpha <- list(
  agreeableness_items = c("A1", "A2", "A3", "A4", "A5"),
  conscientiousness_items = c("C1", "C2", "C3", "C4", "C5"),
  extraversion_items = c("E1", "E2", "E3", "E4", "E5"),
  neuroticism_items = c("N1", "N2", "N3", "N4", "N5"),
  openness_items = c("O1", "O2", "O3", "O4", "O5")
)

# Loop through each subscale item
for (subscale in names(subscales_alpha)) {
  # Calculate the Cronbachs alpha of each subscale
  alpha_list[[subscale]] <- psych::alpha(bfi_clean[, subscales_alpha[[
    subscale
  ]]])
}

# Extract key statistics from each subscale's alpha object

all_alphas <- data.frame(
  subscale = names(alpha_list),
  raw_alphas = sapply(alpha_list, function(item) item$total$raw_alpha),
  std_alphas = sapply(alpha_list, function(item) item$total$std.alpha),
  avg_r = sapply(alpha_list, function(item) item$total$average_r)
)

# Remove "_items" suffix from subscale names for cleaner display

all_alphas$subscale <- gsub("_items", "", all_alphas$subscale)

# Format results into table

knitr::kable(
  all_alphas,
  digits = 2,
  row.names = FALSE,
  col.names = c("Subscale", "Raw α", "Std α", "Avg r"),
  caption = "<span style='font-size: 16px; font-weight: bold;'>Cronbach's Alpha by Subscale</span>"
) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover"),
    full_width = FALSE
  ) %>%
  column_spec(1, bold = TRUE)
