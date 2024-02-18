# Quantification of co-expression of gene pairs in E. coli

## 1. Remove the genes that have less than 3300 conditions
# out of the 4080 initial conditions

# Load raw matrix with 4080 conditions and 4322 genes
load("data/colombos.RData")

# Function that counts the NAs per gene
na.search <- function(colombos.row){
  na.sum <- sum(as.numeric(is.na(colombos.row)))
}

# Save the number o NA's per gene in a vector
na.vector<- c(apply(X=colombos, MARGIN = 1, FUN = na.search))

# Assign names to the na.vector according to its number
names(na.vector)<-c(1:length(colombos[,1]))

# Subset with genes that have less than 3300 conditions
genes_less_3300<-subset(na.vector, na.vector >= length(colnames(colombos)) - 3300)

# Subset of the original matrix with the genes that have more than 3300 conditions
colombos_greater_3300 <- colombos[-as.numeric(names(genes_less_3300)),]


# 2. Correlation

#Save number of genes in a variable
gene.number <- nrow(colombos_greater_3300)

# Create matrix for spearman and pearson correlations, as well as p-values
pearson.cor.matrix <- matrix(nrow = gene.number, ncol = gene.number)
pearson.p.matrix <- matrix(nrow = gene.number, ncol = gene.number)
spearman.cor.matrix <- matrix(nrow = gene.number, ncol = gene.number)
spearman.p.matrix <- matrix(nrow = gene.number, ncol = gene.number)

# Calculate correlation of each gene against every gene
### THIS PART TAKES APROX. 12 HRS. BETTER TO RUN IN THE SERVER ###
for (gene in 1:gene.number){
  print(gene)
  for (gene.compare in 1:gene.number){
    if (gene.compare >= gene){
      #pearson correlation and p-value
      pearson.cor <- cor.test(suppressWarnings(as.numeric(colombos_greater_3300[gene,])),
                              suppressWarnings(as.numeric(colombos_greater_3300[gene.compare,])),
                              exact = FALSE)
      pearson.cor.matrix[gene.compare, gene] <- abs(pearson.cor$estimate)
      pearson.p.matrix[gene.compare, gene] <- pearson.cor$p.value

      #spearman correlation and p-value
      spearman.cor <- cor.test(suppressWarnings(as.numeric(colombos_greater_3300[gene,])),
                               suppressWarnings(as.numeric(colombos_greater_3300[gene.compare,])),
                               method="spearman", exact = FALSE)
      spearman.cor.matrix[gene.compare, gene] <- abs(spearman.cor$estimate)
      spearman.p.matrix[gene.compare, gene] <- spearman.cor$p.value

      write.table(warnings(),file="warning.txt",append = TRUE)
    }
  }
}

# Turn to absolute values
pearson.cor.matrix <- abs(pearson.cor.matrix)
spearman.cor.matrix <- abs(spearman.cor.matrix)


# 3. To make sure that the matrices are correct, the diagonal
# must be 1 (because it is the same gene)

# save the length of the matrix as a variable
len_matrix <- nrow(pearson.cor.matrix)

# function to count cor==1
sum_if_one <- function(cor_row){
  cor_row_no_na <- subset(cor_row,!(is.na(cor_row)))
  sum_ones <- sum(cor_row_no_na >= 0.99999)
  return(sum_ones)
}

p.cor <- apply(pearson.cor.matrix, 2, sum_if_one)
s.cor <- apply(spearman.cor.matrix, 2, sum_if_one)

print(paste("Pearson. Genes with cor==1: ", sum(p.cor)))
print(paste("Spearman. Genes with cor==1: ", sum(s.cor)))


# Save the objects created
write.csv(pearson.cor.matrix, "../results/pearson_cor_matrix.csv", sep = ",")
write.csv(spearman.cor.matrix, "../results/spearman_cor_matrix.csv", sep = ",")
write.csv(pearson.p.matrix, "../results/pearson_p.csv", sep = ",")
write.csv(spearman.p.matrix, "../results/spearman_p.csv", sep = ",")
