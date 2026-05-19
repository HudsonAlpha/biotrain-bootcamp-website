
# Load the necessary libraries
library(qqman)
library(data.table)

### Edit below to the path on your computer
file_path <- "/Users/nickcochran/Downloads/redlat_genotools_4-23-25-25_AMR_ad_GEMMA_gwas_sex_age_country.assoc_no-nan_0.05-Head.txt"

data <- fread(file_path)

manhattan(data, chr = "chr", bp = "ps", snp = "rs", p = "p_lrt", main = "ReD-Lat AMR AD Standardized AF-0.005",
          annotatePval = 5e-8, annotateTop = TRUE)
