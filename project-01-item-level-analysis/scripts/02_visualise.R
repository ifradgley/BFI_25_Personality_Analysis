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

# Rank items within each dimension from strongest to weakest correlation
ranked_items <- cors_dataframe_long %>% 
  group_by(dimension) %>% 
  mutate(item_rank = rank(-correlation)) %>%
  # Sort by dimension, then by rank within each dimension
  arrange(dimension, item_rank)

# Presentable ranking table
ranking_table <- ranked_items %>%
  select(dimension, item_rank, item, correlation) %>%
  mutate(dimension = str_to_title(sub("_items", "", dimension))) %>%
  rename("Dimension" = dimension, 
         "Rank" = item_rank, 
         "Item" = item, 
         "Correlation" = correlation)

# Display ranking table as a formatted flextable
flextable(ranking_table) %>%
  font(fontname = "Arial", part = "all") %>%
  set_caption("BFI-25 Item Rankings by Dimension")

# Create a heatmap showing all 25 items across all 5 dimensions
heatmap_items <- cors_dataframe_long %>%
  mutate(dimension_clean = str_to_title(sub("_items", "", dimension))) %>%
  ggplot(aes(x = dimension_clean, y = item, fill = correlation)) + 
  geom_tile() +
  ggtitle("BFI-25 Item-Dimension Correlations Heatmap") +
  xlab("Dimension") +
  ylab("Item") +
  scale_fill_gradient(low = "white", high = "darkblue", name = "Correlation") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(heatmap_items)

