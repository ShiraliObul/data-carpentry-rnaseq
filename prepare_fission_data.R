# Preparing fission data for lesson

library(fission)
library(DESeq2)
library(magrittr)
library(tibble)

data("fission")

# modify colnames of the data to be a bit less confusing
colnames(fission) <- colData(fission)$id

# Create DESeq dataset - simple design, no interaction
dds <- DESeqDataSet(fission, design = ~ strain + minute)

# Remove very low count genes - at least half the samples with more than 5 reads
genes_to_keep <- rowSums((counts(dds) > 5)) > 18
dds <- dds[genes_to_keep, ]


#
# Run tests ----
#
# Run DESeq model
dds <- DESeq(dds)

# Make a contrast between first and final time points for WT
test_result <- results(dds , contrast = c("minute", "180", "0"), tidy = TRUE) %>% 
  as_tibble()

# Retain only genes with FDR < 5%
test_result <- test_result[test_result$padj < 0.05, ]

# Rename first column
names(test_result)[1] <- "gene"


#
# Gene counts ----
#
# Extract raw counts
norm_cts <- counts(dds, normalized = TRUE)

# Applying normalization to data (ignoring design) - for clustering, etc.
trans_cts <- vst(dds, blind = TRUE) %>% assay()

# Get sample information
sample_info <- colData(dds) %>% as.data.frame() %>% as_tibble(rownames = "sample")
sample_info <- sample_info[, c("sample", "strain", "minute", "replicate")]  # retain only a few columns


#
# Save objects ----
#
save(norm_cts, trans_cts, sample_info, test_result,
     file = "data/fission_data.RData", compress = "bzip2")




