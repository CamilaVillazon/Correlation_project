# p-value histogram

#packages
library(ggplot2)

#load files
pearson_p <- read.table("results/pearson_one_col.csv", header = FALSE, dec = ".",)
spearman_p <- read.table("results/spearman_one_col.csv", header = FALSE, dec = ".",)

#subset p-values smaller than 0.05
p_less_5 <- subset(pearson_p, pearson_p <= 0.05)
s_less_5 <- subset(spearman_p, spearman_p <= 0.05)

#subset p-values greater than 0.05
p_greater_5 <- subset(pearson_p, pearson_p > 0.05)
s_greater_5 <- subset(spearman_p, spearman_p > 0.05)

#Plots
ggplot(data = p_less_5) + geom_histogram(aes(x = p_less_5[, 1])) + labs(
  title = "pearson p-values",
  subtitle = "p-value<=0.05",
  x = "p-values",
  caption = "n = 8,164,556"
)

ggplot(data = p_greater_5) + geom_histogram(aes(x = p_greater_5[, 1])) + labs(
  title = "pearson p-values",
  subtitle = "p-value>0.05",
  x = "p-values",
  caption = "n = 6,347"
)

ggplot(data = s_less_5) + geom_histogram(aes(x = s_less_5[, 1])) + labs(
  title = "spearman p-values",
  subtitle = "p-value<=0.05",
  x = "p-values",
  caption = "n = 6,047,040"
)

ggplot(data = s_greater_5) + geom_histogram(aes(x = s_greater_5[, 1])) + labs(
  title = "spearman p-values",
  subtitle = "p-value>0.05",
  x = "p-values",
  caption = "n = 2,123,862"
)
