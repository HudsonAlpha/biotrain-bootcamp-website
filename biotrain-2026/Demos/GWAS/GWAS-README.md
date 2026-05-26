### This tutorial contains 3 different versions for GWAS, 1 very minimal, 1 intermediate that also brings in gene name information, and a final version that also calculates inflation factor.

gwas_plotting_example_Nick-Minimal.R  ### Minimal version, bare bones

gwas_plotting_example_Nick-v2-WithGenes.R ### Includes some other things that allow for bringing in gene names

### Most complicated version, this time in R markdown format that will also calculate inflation factor.

### The first two use the following file:

redlat_genotools_4-23-25-25_AMR_ad_GEMMA_gwas_sex_age_country.assoc_no-nan_0.05-Head.txt ### Small file, filtered to p<0.05 for ease of use

### the last one uses the following:

redlat_genotools_4-23-25-25_AMR_ad_GEMMA_gwas_sex_age_country.assoc_no-nan.txt  ### much larger file but has all p values, needed for calculating genomic inflation factor

Versions 2 and 3 use the following input: gencode.v46.annotation.gtf (available zipped from https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/gencode.v46.annotation.gtf.gz)



