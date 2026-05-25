# =============================================================================
# Dotplot BioTrain Demonstration 
# by Laramie Smith-Aközbek | May 24, 2026
# =============================================================================
#
# Dotplots are a simple and intuitive way to visually compare two sequences!
# One sequence is placed along the x-axis, and the other along the y-axis.
# Then, a dot is drawn wherever the two match. The process of "matching" these
# sequences is called alignment.
#
# We can use the patterns revealed by the resulting "dotplot" to better 
# understand how the sequences differ from each other, something we term "structural variation." 
#
# Tutorial Outline:
#   Part 1 — Example of a perfect alignment
#   Part 2 — Example of an INVERSION
#   Part 3 — Example of a DELETION
#   Part 4 — Example of a TRANSLOCATION
#   Part 5 — Interactive examples from real chromosomes! 
# =============================================================================

# Before we get started, let's make sure we have the necessary packages:

# Install required packages
required_packages <- c("seqinr", "ggplot2", "plotly", "optparse", "png")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

# Load packages 
library(seqinr)
library(ggplot2)
library(plotly)
library(png)

# Let's also go ahead and define some helper functions that will be useful later on. 

# Helper: display a PNG in the RStudio Plots pane
show_png <- function(path) {
  if (file.exists(path)) {
    img <- png::readPNG(path)
    par(mar = c(0, 0, 0, 0))
    plot(NA, xlim = c(0,1), ylim = c(0,1), type = "n",
         xaxt = "n", yaxt = "n", xlab = "", ylab = "", bty = "n")
    rasterImage(img, 0, 0, 1, 1)
  }
}

# Helper: open an HTML file in RStudio Viewer (or browser)
show_html <- function(path) {
  if (file.exists(path)) {
    viewer <- getOption("viewer")
    if (!is.null(viewer)) viewer(path) else browseURL(path)
  }
}

# Before we move on, let's view a summary of the structural variants
# that we will be discussing as dotplots and in the form of a linear comparison, 
# which we call a riparian plot. 
#
# Source: Okuno, M., Yamamoto, T., & Ogura, Y. (2025). Blastn2dotplots:
#   multiple dot-plot visualizer for genome comparisons. BMC Bioinformatics,
#   26(1), 146.
show_png(file.path(getwd(), "summary_plot_examples.png"))

# Keep this PNG open throughout the demo if you find the riparian plot view more intuitive. 

# =============================================================================
# PART 1: PERFECT ALIGNMENT
# =============================================================================
# When two sequences are identical, every position matches along the main
# diagonal. This produces a clean line from bottom-left to top-right, 
# because every position is the same between each sequence.

# For this example, we will use the 26 unique letters of the alphabet: 
seq1 <- s2c("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
seq2 <- s2c("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

# View each sequence 
cat("Sequence 1:", c2s(seq1), "\n")
cat("Sequence 2:", c2s(seq2), "\n\n")

# View the alphabet "dotplot"
#   wsize  = window size (how many consecutive positions to compare)
#   nmatch = how many must match within that window to draw a dot
dotPlot(seq1, seq2, wsize = 1, nmatch = 1,
        main = "Part 1: Perfect Alignment",
        xlab = "Sequence 1", ylab = "Sequence 2")

# =============================================================================
# PART 2: INVERSION
# =============================================================================
# An inversion occurs when a segment of a sequence has been flipped (inverted)
# relative to another sequence.
#
# On a dotplot this appears as a line running in the OPPOSITE direction, in a perpendicular line.
# Note: regions that stay on the main diagonal are called "collinear."

# The sequence on the x-axis is called the "reference"
ref <- s2c("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

# The sequence on the y-axis is called the "query" 
# Let's manually invert positions 10-18 (J through R):
query_inv <- c(ref[1:9],          # A-I: unchanged
               rev(ref[10:18]),    # J-R: reversed to become R-J
               ref[19:26])        # S-Z: unchanged

# View each sequence 
cat("Reference:", c2s(ref), "\n")
cat("Query:    ", c2s(query_inv), "\n")

# Now let's view the dotplot 
dotPlot(ref, query_inv, wsize = 1, nmatch = 1,
        main = "Part 2: Inversion",
        xlab = "Reference", ylab = "Query")

# Let's develop a better intuition for what the data for something like this 
# looks like under the hood. Specifically, let's show the full grid: 

n_ref <- length(ref)
n_qry <- length(query_inv)

# Build a match matrix: TRUE wherever ref[i] == query[j]
match_mat <- outer(ref, query_inv, "==")

# Set up an empty plot with grid boxes for each cell.
old_par <- par(mar = c(2, 2, 3, 1), pty = "s")
plot(NA, xlim = c(0.5, n_ref + 0.5), ylim = c(0.5, n_qry + 0.5),
     xaxt = "n", yaxt = "n", xlab = "", ylab = "",
     main = "Annotated Grid: Inversion",
     asp = 1)

# Shade matching cells in light blue
matches <- which(match_mat, arr.ind = TRUE)
rect(matches[, 1] - 0.5, matches[, 2] - 0.5,
     matches[, 1] + 0.5, matches[, 2] + 0.5,
     col = "lightblue", border = NA)

# Draw grid lines at cell boundaries (0.5, 1.5, 2.5, ... 26.5)
abline(v = seq(0.5, n_ref + 0.5, by = 1), col = "grey70", lwd = 0.5)
abline(h = seq(0.5, n_qry + 0.5, by = 1), col = "grey70", lwd = 0.5)

# Label every cell with its Ref,Query letter pair
all_pos <- expand.grid(x = 1:n_ref, y = 1:n_qry)
pair_labels <- paste0(ref[all_pos$x], ",", query_inv[all_pos$y])
text(all_pos$x, all_pos$y, labels = pair_labels,
     col = "grey60", cex = 0.35)

# Re-label matching cells darker so they stand out
text(matches[, 1], matches[, 2],
     labels = paste0(ref[matches[, 1]], ",", query_inv[matches[, 2]]),
     col = "black", cex = 0.45, font = 2)

# Restore default par so subsequent plots aren't forced into a square
par(old_par)

# =============================================================================
# PART 3: DELETION
# =============================================================================
# Next up: deletions. This means a segment present in the reference is missing from the
# query. The diagonal continues on both sides of the gap, but there's a horizontal jump 
# where the reference axis advances while the query axis stays continuous.

# Let's define the reference again
ref <- s2c("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

# Delete positions 10-15 (J through O) in the query
query_del <- c(ref[1:9],      # A-I: present
               ref[16:26])    # P-Z: present (J-O are missing)

# View the sequences 
cat("Reference:", c2s(ref), "\n")
cat("Query:    ", c2s(query_del), "\n")

dotPlot(ref, query_del, wsize = 1, nmatch = 1,
        main = "Part 3: Deletion",
        xlab = "Reference", ylab = "Query")

# =============================================================================
# PART 4: TRANSLOCATION
# =============================================================================
# Lastly, we have translocations. 
# These occur when a block of sequence in the query is collinear with the reference, 
# but it is in a different relative location. 
# On a dotplot, each block still forms a diagonal, but the blocks are offset.

# Let's define the reference
ref <- s2c("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

# To form a translocation in the query, let's swap blocks: 
# move S-W (positions 19-23) to just after E (position 5)
query_trans <- c(ref[1:5],     # A-E: unchanged
                 ref[19:23],   # S-W: moved 
                 ref[6:18],    # F-R: shifted right 
                 ref[24:26])   # X-Z: unchanged

cat("Reference:", c2s(ref), "\n")
cat("Query:    ", c2s(query_trans), "\n")

dotPlot(ref, query_trans, wsize = 1, nmatch = 1,
        main = "Part 4: Translocation\nSwapped blocks appear as offset diagonal segments",
        xlab = "Reference", ylab = "Query")

# =============================================================================
# PART 5: Interactive dotplots with real data
# =============================================================================
# Now, we're going to move to real sequences! 
# We will visualize these with dotPlotly (github.com/tpoorten/dotPlotly). 
# This program can read alignment files (called .PAF files, generated by another program: minimap2) 
# and produces a PNG as well as a zoomable dotplot
#
# dotPlotly is a standalone Rscript (pafCoordsDotPlotly.R) included in this
# demo folder. Pre-built PAF files are in the paf_files/ directory.
#
# We have three examples:
#   5a — Two chromosomes, same individual
#   5b — Two chromosomes, different genera in the same family
#   5c — Whole-genome alignment, two related species

# pafCoordsDotPlotly.R should be in the same directory as this script
dotplotly_script <- file.path(getwd(), "pafCoordsDotPlotly.R")
paf_dir <- file.path(getwd(), "paf_files")

# --- 5a: M. cerifera Z vs W (Sex Chromosomes) -------------------------------
# Two chromosomes from the SAME individual. These are the two copies of
# Chr08 in the plant species Morella cerifera — the Z and W sex chromosomes.
# Because they are from the same individual, they will be highly similar 
# for most of the chromosome, except in the "sex-determining region" 
# of the W chromosome, which holds the genes that control the male or female phenotype.

# Let's run dotPlotly on them: 
system(paste("Rscript", shQuote(dotplotly_script),
             "-i", shQuote(file.path(paf_dir, "mcerifera_ZvsW.paf")),
             "-o", shQuote(file.path(getwd(), "mcerifera_ZvsW")),
             "-m 1000", "-q 50000", "-l"))

# Important Note: Hap1_Chr08 is the Z chromosome (reference, x-axis), 
# Hap2_Chr08 is the W chromosome (query, y-axis) 

# Now let's view the chromosomes
show_png(file.path(getwd(), "mcerifera_ZvsW.png"))
show_html(file.path(getwd(), "mcerifera_ZvsW.html"))

# --- 5b: Comptonia peregrina vs Myrica gale Chr04 ----------------------------
# These two chromosomes come from different species, however they are in the same family (Myricaceae). 
# The more distantly related two species are from each other, the more we expect 
# that collinearity will decrease. 

# Let's run dotPlotly on them: 
system(paste("Rscript", shQuote(dotplotly_script),
             "-i", shQuote(file.path(paf_dir,
                                     "comptonia_v_myrica_chr04.paf")),
             "-o", shQuote(file.path(getwd(), "comptonia_v_myrica_chr04")),
             "-m 1000", "-q 50000", "-l"))

# Important Note: Myrica gale is the reference (x-axis), Comptonia peregrina is the query (y-axis)

# Now let's view the chromosomes
show_png(file.path(getwd(), "comptonia_v_myrica_chr04.png"))
show_html(file.path(getwd(), "comptonia_v_myrica_chr04.html"))

# --- 5c: Morella inodora vs Morella rubra (full genome) -------------------------------
# Lastly, we can compare ALL the chromosomes of two Morella species (which both have 8 chromosomes).

# Let's run dotPlotly on them: 
ref_order <- paste0("Mrub_hap2_Chr0", 1:8, collapse = ",")
system(paste("Rscript", shQuote(dotplotly_script),
             "-i", shQuote(file.path(paf_dir, "minodora_v_mrubra.paf")),
             "-o", shQuote(file.path(getwd(), "minodora_v_mrubra")),
             "-m 1000", "-q 50000", "-l",
             "-r", shQuote(ref_order)))

# Important Note: M. rubra is the reference (x-axis), M. inodora is the query (y-axis)

# Now let's view the chromosomes
show_png(file.path(getwd(), "minodora_v_mrubra.png"))
show_html(file.path(getwd(), "minodora_v_mrubra.html"))
