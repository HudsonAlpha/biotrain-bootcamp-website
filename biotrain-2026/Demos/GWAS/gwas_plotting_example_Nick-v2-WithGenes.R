
# Load the necessary libraries
library(qqman)
library(data.table)
library(rtracklayer)
library(GenomicRanges)
library(GenomicFeatures)

### Edit below to the path on your computer
file_path <- "/Users/nickcochran/Downloads/redlat_genotools_4-23-25-25_AMR_ad_GEMMA_gwas_sex_age_country.assoc_no-nan_0.05-Head.txt"

data <- fread(file_path)

# Ensure the column names are as expected
colnames(data) <- c("chr", "rs", "ps", "n_miss", "allele1", "allele0", "af", "beta", "se", "logl_H1", "l_remle", "l_mle", "p_wald", "p_lrt", "p_score")

# Load the GTF file
# Note the below file is available from: https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/gencode.v46.annotation.gtf.gz

### Edit the below to point to the local location on your machine
gtf_file_path <- "/Users/nickcochran/Downloads/gencode.v46.annotation.gtf"
gtf <- rtracklayer::import(gtf_file_path)

# Convert the GTF to a GRanges object for genes
genes <- subset(gtf, type == "gene")
genes_gr <- GRanges(seqnames = seqnames(genes),
                    ranges = IRanges(start = start(genes), end = end(genes)),
                    gene_id = genes$gene_id,
                    gene_name = genes$gene_name)

# Convert numeric chr to standard labels
data$chr_label <- as.character(data$chr)
data$chr_label[data$chr == 23] <- "X"
data$chr_label[data$chr == 24] <- "Y"
data$chr_label <- paste0("chr", data$chr_label)

# Remove any chr not found in GTF (optional)
valid_chrs <- intersect(unique(data$chr_label), seqlevels(gtf))  # e.g., chr1 - chr22, chrX, chrY
data <- data[data$chr_label %in% valid_chrs]

# Now create the SNP GRanges object
snps_gr <- GRanges(
  seqnames = data$chr_label,
  ranges = IRanges(start = data$ps, end = data$ps),
  rs = data$rs
)

# Find overlaps between SNPs and genes
overlaps <- findOverlaps(snps_gr, genes_gr)

# Create a vector to store gene names
data$gene <- NA
data$gene[queryHits(overlaps)] <- genes_gr$gene_name[subjectHits(overlaps)]

# Identify significant hits (e.g., p-value < 5e-8)
significant_hits <- data[data$p_lrt < 5e-8]


manhattan(data, chr = "chr", bp = "ps", snp = "rs", p = "p_lrt", main = "ReD-Lat AMR AD Standardized AF-0.005",
          annotatePval = 5e-8, annotateTop = TRUE)

manhattan(data, chr = "chr", bp = "ps", snp = "gene", p = "p_lrt", main = "ReD-Lat AMR AD Standardized AF-0.005",
          annotatePval = 5e-8, annotateTop = TRUE)

