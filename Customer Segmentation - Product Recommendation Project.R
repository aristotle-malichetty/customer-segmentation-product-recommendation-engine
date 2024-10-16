# Data Science Project for Acme Innovations
# Author: Aristotle Malichetty
# Date: 04-15-2024


# Install Required Packages (as needed)

# install.packages("readr")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("cluster")
# install.packages("stringr")
# install.packages("arules")

# Load Required Packages

library(readr)    # For reading CSV files and other rectangular data formats
library(dplyr)    # For data manipulation and transformation
library(ggplot2)  # For creating elegant data visualizations
library(cluster)  # For cluster analysis and algorithms like K-means
library(stringr)  # For string manipulation and cleaning
library(arules)   # For association rule mining and frequent itemset mining

# Set working directory (adjust as needed)
# setwd("/path/to/your/project/directory")

# 1. Data Loading and Exploration ----

# Load customer data
customers <- read.csv("customer_data.csv")

# Exploring customers dataset
summary(customers)        # Generate summary statistics for the dataset
dim(customers)            # Print dimensions of the dataset
colSums(is.na(customers)) # Check for missing values in the dataset
head(customers)           # Display the first few rows to understand the data structure
str(customers)           # Display the structure of the dataset to understand variable types


# 2. Customer Segmentation using KNN Clustering ----

# Select features for clustering
features <- customers[, c("salary", "spending_score")]

# Plot histograms
salary_hist <- hist(features[, "salary"], main = "Salary Distribution", xlab = "Salary")

spending_hist <- hist(features[, "spending_score"], main = "Spending Score Distribution", xlab = "Spending Score")


# Scale the features
scaled_features <- scale(features)


# Clustering of Customers
# Elbow method to find optimal number of clusters

set.seed(6) # Set random seed again for reproducibility
wcss = vector()
for (i in 1:10) wcss[i] = sum(kmeans(scaled_features, i)$withinss)
elbow_plot <- plot(x = 1:10,
     y = wcss,
     type = 'b',
     main = paste('The Elbow Method'),
     xlab = 'Number of clusters',
     ylab = 'WCSS')



# Perform K-means clustering
set.seed(29) # Set random seed again for reproducibility
kmeans <- kmeans(x = scaled_features,
                 centers = 4,  # Perform K-Means with 4 clusters
                 iter.max = 300,
                 nstart = 10) 

# Visualize clusters
cluster_plot <- clusplot(x = scaled_features,
         clus = kmeans$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = paste('Four Clusters of Customers'),
         xlab = 'Salary',
         ylab = 'Spending score')


# ggplot visualization

# Convert features to a data frame and add cluster assignments
features_df <- as.data.frame(features)  
features_df$cluster <- as.factor(kmeans$cluster)  # Add cluster assignments from your K-means result

# Create a named vector for cluster labels
cluster_labels <- c(
  "1" = "1. High Income, High Spenders",
  "2" = "2. Low Income, Low Spenders",
  "3" = "3. Low Income, Low Spenders",
  "4" = "4. High Income, High Spenders"
  )

# ggplot with clusters
cluster_ggplot <- ggplot(features_df, aes(x = salary, y = spending_score, color = cluster)) +
  geom_point(alpha = 0.6, size = 3) +  # Points with semi-transparency for better visibility
  labs(title = "Cluster Analysis of Customers",
       x = "Salary",
       y = "Spending Score",
       color = "Customer Segment") +
  scale_color_discrete(labels = cluster_labels) +  # Use custom labels
  theme_minimal() +                   # Minimal theme for a cleaner look
  theme(legend.position = "right")    # Adjust legend position


cluster_ggplot



# 3. Product Recommendation using Apriori Algorithm ----

# Load and clean purchase history data
purchases <- read.csv("customer_purchase_history_final.csv", header = FALSE) #Data doesn't have headers


# Exploring purchases data

summary(purchases)        # Generate summary statistics for the dataset
dim(purchases)            # Print dimensions of the dataset
colSums(is.na(purchases)) # Check for missing values in the dataset
head(purchases)           # Display the first few rows to understand the data structure
str(purchases)            # Display the structure of the dataset to understand variable types
 

# Clean product names

clean_product_names <- purchases %>%
    mutate(across(everything(), 
                  ~ str_replace_all(., "^X\\.\\.|\\.$", "") %>%   # Cleaning product names starting with X and removing it.
                    str_replace_all("^X(\\..*)?$", "") %>%        #Cleaning product names having only "X", "X.", etc..
                    str_replace_all("\\.(?=\\w)", " ") %>%        # Cleaning product names having "." between product name such as "washing.machine"
                    str_trim()))                                  #Trim whitespace if some cells are now empty


purchases_cleaned <- clean_product_names

# Subset to match customer data
purchases_cleaned <- purchases_cleaned %>% slice(1:nrow(customers))

# Write cleaned data
write.csv(purchases_cleaned, "cleaned_purchases.csv", row.names = FALSE, quote = FALSE)

# Create transactions
transactions <- read.transactions('cleaned_purchases.csv', format = 'basket', 
                                  sep = ',', rm.duplicates = TRUE)

summary(transactions)    # Generate summary statistics for the dataset

# Visualize top products
top_products <- itemFrequencyPlot(transactions, topN = 10, type = "relative",
                                 main = "Top 10 Products", col = "skyblue")

# Generate apriori association rules
apriori_rules <- apriori(transactions, 
                         parameter = list(support = 0.03, confidence = 0.2))

# Display top 10 rules
top_rules <- inspect(sort(apriori_rules, by = 'lift')[1:10])

# Display all rules

all_rules <- inspect(sort(apriori_rules, by = 'lift'))


# 4. Save Results ----

# Save plots

# i. Customer Segmentation

png("salary_distribution.png")
salary_hist <- hist(features[, "salary"], main = "Salary Distribution", xlab = "Salary")
dev.off()

png("spending_score_distribution.png")
spending_hist <- hist(features[, "spending_score"], main = "Spending Score Distribution", xlab = "Spending Score")
dev.off()

png("elbow_plot.png")
elbow_plot <- plot(x = 1:10,
                   y = wcss,
                   type = 'b',
                   main = paste('The Elbow Method'),
                   xlab = 'Number of clusters',
                   ylab = 'WCSS')
dev.off()

pdf("customer_segments.pdf")
cluster_plot <- clusplot(x = scaled_features, clus = kmeans$cluster,
                         lines = 0, shade = TRUE, color = TRUE, labels = 2,
                         plotchar = FALSE, span = TRUE,
                         main = paste('Four Clusters of Customers'),
                         xlab = 'Salary', ylab = 'Spending score')
dev.off()



ggsave("gg_customer_segments.pdf",plot = cluster_ggplot)


# ii. Product Recommendation

# Convert top rules to a data frame
top_rules_df <- as(top_rules, "data.frame")
# Save top rules to CSV
write.csv(top_rules_df, file = "top_association_rules.csv", row.names = FALSE)

# Convert all rules to a data frame
all_rules_df <- as(all_rules, "data.frame")
# Save all rules to CSV
write.csv(all_rules_df, file = "all_association_rules.csv", row.names = FALSE)

png("top_products.png")
top_products <- itemFrequencyPlot(transactions, topN = 10, type = "relative",
                                  main = "Top 10 Products", col = "skyblue")
dev.off()


# 5. Conclusion ----

cat("Analysis Complete. Key findings:\n")
cat("- Optimal number of customer segments:", 4, "\n")
cat("- Top product associations saved in 'top_association_rules.csv'\n")
cat("- Visualizations saved as PNG and PDF files\n")