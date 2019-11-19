# Example script to generate beta-diversity
# Key here is that this is simplified, doesn't require a tree
# Note: this wouldn't be how you do it most of the time for a publication
# but for our classes purposes this is sufficient and will allow you to 
# make decent visualizations.

# If you have already figured out how to generate alpha or beta diversity 
# using a different method - great! Go ahead and use that method. 
# If you are struggling or stuck, hopefully this helps.

# use package vegan and ape
# install thse with install.packages if you haven't used these before.
library(vegan)
library(ape)

# load your data
tax <- read.delim("Desktop/taxatable.txt", row.names = 1)

# drop low read samples
# here I've automated to drop the lowest quantile, but this is conservative
# you might want to pick a less strigent cutoff for your data
tax <- tax[colSums(tax)>quantile(colSums(tax))[2]]

# convert to relative abundance
norm.tax <- sweep(tax, 2, colSums(tax), FUN = "/")

# drop low abundance taxa
norm.tax <- norm.tax[rowMeans(norm.tax) > 0.001,]

# calcuate distances between samples
# this uses a method called bray curtis - it's not the same as unifrac, but it works alright
dist.tax <- vegdist(t(norm.tax), method = "bray" )

# get principal coordinates for plotting
pcs.tax <- pcoa(dist.tax)$vectors

# convert to a format that will be more usable for plotting and data manipulation
pcs.tax <- as.data.frame(pcs.tax)

# now pcs.tax contains the principal coordinates you can use for plotting
# We can do this crudely using base R, but you should use ggplot
plot(pcs.tax$Axis.1, pcs.tax$Axis.2)
