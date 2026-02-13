# ================================
# 01_calculate_correlations.R - Calculate and organise dimension totals and item-total correlations
# ================================

# Empty vector that will hold the five correlation coefficients
cors_list <- list(
  agreeableness_items = c(),
  conscientiousness_items = c(),
  extraversion_items = c(),
  neuroticism_items= c(),
  openness_items = c()
)

for (dim_name in names(dimensions)) {
  # Extract the base dimension name and construct the total column name
  total_name <- sub("_items", "_total", dim_name)
  print(item)
  # Loop through each dimension item
  for (item in dimensions[[dim_name]]) {
    # Calculate Pearson correlation between the current item and its dimension total
    correlation <- cor(bfi_clean[[item]], bfi_clean[[total_name]], use = "pairwise.complete.obs")
    # Append the correlation value to the corresponding dimension's vector
    cors_list[[dim_name]] <- append(cors_list[[dim_name]], correlation)
    print(total_name)
  }
}

# Display all item-total correlations organized by dimension
cors_list

{ # Convert correlations from wide format to long format
  cors_dataframe_long <- cors_dataframe %>%
    # Add a row number (1-5) to identify which item within each dimension
    mutate(item_number = row_number()) %>%
    # Pivot all columns except item_number into long format
    pivot_longer(cols = -item_number, names_to = "dimension", values_to = "correlation") %>%
    # Create a new column called "item" with the actual item names (A1, A2, etc.)
    mutate(item = toupper(paste0(substr(dimension, 1, 1), item_number))) %>%
    select(-item_number)
}
# Display first few rows to verify structure
head(cors_dataframe_long)
