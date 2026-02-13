# ================================
# 02_visualise.R - Produce 5 bar plots, 1 heat map and 1 rank table
# ================================

# Bar plots for all five Big Five dimensions
filtered_items <- c("agreeableness_items", "conscientiousness_items", 
                    "extraversion_items", "neuroticism_items", "openness_items")

# Loop through each dimension to create individual plots
for (dim_name in filtered_items) {
  # Clean the dimension name for the plot title 
  clean_dim_name <- str_to_title(sub("_items", "", dim_name))
  # Filter correlations for the current dimension and sort from highest to lowest
  filtered_data <- cors_dataframe_long %>%
    filter(dimension == dim_name) %>%
    arrange(desc(correlation)) 
  
  barplot_correlations <- ggplot(filtered_data, aes(x = reorder(item, -correlation), y = correlation)) +
    geom_bar(stat = "identity") +
    ggtitle(paste0("Item-Total Correlations: ", clean_dim_name)) +
    xlab("Item") +
    ylab("Correlation") +
    # Reference line at 0.50 indicates the threshold for "strong" item correlations
    geom_hline(yintercept = 0.50, linetype = "dashed", color = "hotpink")
  
  print(barplot_correlations)
}