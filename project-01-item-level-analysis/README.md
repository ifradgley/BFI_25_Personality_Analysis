# Item Level Analysis of BFI-25

## Overview

In this project, I carried out an item level analysis of the BFI-25. The 25-item Big Five Inventory data set is an abbreviated assessment designed to measure the five core personality traits: Openness, Conscientiousness, Extraversion, Agreeableness, and Neuroticism (OCEAN).

## Methods

The initial data set contained 2800 participants. Given this large sample size, correlation estimates are considered highly stable and my interpretation focuses on magnitude rather than statistical significance.

Although documentation suggests a 5-point scale, the data set contained responses ranging from 1-6, indicating a 6-point implementation.

Prior to analysis, I prepared the raw data by reverse-coding items and and looping through each, before adding to the empty vector.

I identified reverse-coded items from the data set documentation, then applied a 7-minus transformation. This reverses the scale of reverse-coded items by subtracting each response value from 7, so that low responses (1) become high responses (6), and vice versa.

``` r
bfi_clean <- bfi   clean_items <- sub("-", "", reverse_items)  bfi_clean <- bfi_clean %>% mutate(across(all_of(clean_items), ~ 7 - .)) 
```

#### Scoring

I then calculated scale scores using available item responses i.e., missing items were ignored when calculating totals. This created five new columns, one for each Big Five dimension.
