library(data.table)
library(dplyr)
library(ggplot2)
library(ggrepel)
# read counts from the txt file
count_ft <-  read.table('gene_fpkm.txt',
                        header = TRUE,
                        sep = '\t',
                        stringsAsFactors = FALSE)

# One way of doing it is first transposing the TPM count matrix (assuming you want to run PCA on the samples rather than the genes), centering it, then doing an SVD and subsequently plotting the first and second columns of the u matrix (assuming you are interested in the first and second principal components.
count_mat <- data.matrix(count_ft[,2:ncol(count_ft)])
sample_names = c("IEV_1_1", "IEV_1_2", "IEV_10_1", "IEV_10_2","SEV_4_1", "SEV_4_2", "SEV_12_1", "SEV_12_2", "FEV_7_1", "FEV_7_2","FEV_17_1", "FEV_17_2","Parental1", "Parental2")
group_types = c("IEV", "IEV", "IEV", "IEV","SEV", "SEV", "SEV", "SEV", "FEV", "FEV", "FEV", "FEV", "Parental", "Parental")
logTransformed.dat= log2(count_mat+ 1)
FPKM_centered <- t(logTransformed.dat-rowMeans(logTransformed.dat))
# Doing SVD(singular value decomposition)
FPKM_svd <- svd(FPKM_centered)

# check the u table inside the FPKM_svd
FPKM_svd["u"]
# make a dataframe table with PC1 and PC2 with sample info
plot_df <- data.frame(PC1 =FPKM_svd$u[,1], PC2 = FPKM_svd$u[,2], Samples =sample_names, Sample_Type = group_types)
PCA_plot <- ggplot(plot_df, aes(x=PC1, y=PC2, col = group_types)) + geom_point(shape=20, size=5) +
  geom_label_repel(aes(label=Samples)) 
# remove the grids
PCA_plot +  theme_classic()
PCA_plot +scale_color_manual(labels = c("FEV", "IEV","Parental", "SEV" ), values = c("red", "blue", "black", "green")) +
  theme_classic() + scale_fill_manual(values =c("red", "blue", "black", "green") )
