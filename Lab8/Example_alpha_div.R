# Example script to generate alpha-diversity
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

# add a line to set your directory to where you have the taxonomy table stored

# load your data
tax <- read.delim("taxatable.txt", row.names = 1)

# drop low read samples
# here I've automated to drop the lowest quantile, but this is conservative
# you might want to pick a less strigent cutoff for your data
tax <- tax[colSums(tax)>quantile(colSums(tax))[2]]

# convert to relative abundance
norm.tax <- sweep(tax, 2, colSums(tax), FUN = "/")

# the simplest alpha diversity metric is number of species
# There is a lot of discussion in the literature about if you should
# do something called rarefraction or not.
# In this class we won't worrry about that debate.
# So starting with a normalised taxa table, one easy way to generate alpha diveristy is:

alpha <- diversity(norm.tax,index = "shannon",MARGIN = 2 )

# now we have a named number vector that contains an alpha diveristy score for each sample
alpha
