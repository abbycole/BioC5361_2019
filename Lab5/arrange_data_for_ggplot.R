library(tidyverse)
library(reshape2)

# setwd
setwd("~/Documents/Projects/Teaching/BioC5361/")

# load your data
# these are genus level taxonomy counts for each person in the study
# Set the rownames to taxonomy
# Important becuase we need to convert all the numbers to percents
# It's easier to do that if we don't have any character variables in the dataframe
tax <- read.delim("Data/Taxonomy_counts_genus.txt", row.names = 1) 

# convert to relative abundance (like a percentage)
tax_ra <- sweep(tax, 2, colSums(tax), "/")

# check the conversion worked (cols should sum to 1)
colSums(tax_ra)

# now look at the row sums
# conviently our data are already sorted s
# so the most abundant species on average is first in the table
rowSums(tax_ra)

# for plotting, we would like shorter names for taxonomy
# lets keep the lowest taxonomy level we have for each row
# we will change the rownames using gsub fix labeling for plotting
# this code could be functionized, but for now it's ok
rownames(tax_ra) <- gsub("?.*g__", "", rownames(tax_ra)) 
rownames(tax_ra) <- gsub("?.*f__", "Uncl. Family ", rownames(tax_ra))
rownames(tax_ra) <- gsub("?.*o__", "Uncl. Order ", rownames(tax_ra))
rownames(tax_ra) <- gsub("?.*p__", "Uncl. Phylum ", rownames(tax_ra))
rownames(tax_ra) <- gsub("?.*k__", "Uncl. Kingdom ", rownames(tax_ra))
rownames(tax_ra) <- gsub(";NA", "", rownames(tax_ra))
rownames(tax_ra)

# look at how many different genus annotations are in the data
dim(tax_ra)[1]

# 81 is too many to visually inspect, so lets reduce the number to ~20
# for plotting, limit to top ~20 bugs
tax_ra = tax_ra[rowMeans(tax_ra) >= 0.0047,] # we could do this with dplyr, but this is the base R way

# reverse the order, plots look better with big bars at the bottom
tax_ra <- tax_ra[order(rowMeans(tax_ra), decreasing = F),]

# make an oordering factor for ggplot to use 
tax_ord_factor <- as.character(rownames(tax_ra))
# add "Other" which we will create in a minute
tax_ord_factor <- c("Other", tax_ord_factor)
tax_ord_factor
write(tax_ord_factor, "tax_order.txt")

# now lets make the dataframe we will use for plotting
# ggplot needs long data, but our data is wide
# first we need to transpose the dataframe
# currently columns are people, but we want columns to be speices 
# t() will transpose, but it also converts data to a matrix
# so we nest t() within as.data.frame() to return it to a dataframe
plot <- as.data.frame(t(tax_ra))

# for plotting we want a variable called "Subject" 
# since subject is currently a rowname we can use a neat tidyverse package to move this to a column
plot <- rownames_to_column(plot, var = "Subject")

# Lets clean up those names to, to make our plot cleaner 
plot$Subject <- gsub("MCTs", "", plot$Subject) 

# now the big step, we will "melt" the data, to make it long
# this uses a new package called reshape2
plot <- melt(plot, id = "Subject", variable.name = "Genus")

# now take a look at your data
# notice that your data is completely contained in 3 columns now
glimpse(plot)

# finally before we plot, we need to create an "other" category
# this will make each bar the same height
# this time, I'm showing you how to do this with tidyverse
# calcuate "other" for each person
other <- plot %>% 
  group_by(Subject) %>% 
  summarise(value = 1-sum(value))

# make a column called genus and call every row "Other"
other$Genus <- "Other"

# now we can join the two dataframes plot and other
# before we can join the two dfs we have to clean up the class of the other dataframe
other <- as.data.frame(other)

# join for plotting
plot <- as.data.frame(rbind(plot,other))

# finally, lets get the metadata added to this table
map <- read.delim("Subject_metadata.txt", sep = "\t")

# remember we changed the name of subject, so fix that in map
map$Subject <- gsub("MCTs", "", map$Subject)


plot <- merge(plot, map)

# PHEW! Ok, now we can plot
# Just incase you didn't make it through all these steps I'm going to export this data
# That way if you struggle you can simply download the clean data for plotting
write.table(plot, file = "/lib/data_for_plotting.txt", quote = F, sep = "\t", row.names = F, col.names = T)
