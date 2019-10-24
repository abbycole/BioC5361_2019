# Reproducible data science

Today's lab focuses on setting up reproducible data workflows for analysis.

## Set up a project directory and sub-directories on your own computer

First you should create a well structred set of directories on your computer.
Consider setting this up in google drive so you can access it across different computers if you want to work on this outside of lab.

Your file structure should be set up as follows:
```
|-- lab3_bioc5361
|   |--raw_data
|   |--clean_data
|   |--results
|   |--lib 
```

## Step 1: Data Acquisition 

Download the raw data "taxonomy_raw.txt" from this repo and save it in your raw_data directory.

Create a README.txt using a text editor on your computer and populate it with the following information:

```
Raw taxonomy counts from the "Daily Sampling Reveals Personalized Diet-Microbiome Realtionships" 
by Johnson et al. 2019. https://www.cell.com/cell-host-microbe/pdfExtended/S1931-3128(19)30250-1

Data are output from BURST alignment to custom RefSeq database.
```
Save the readme within the same directory as your data file.

## Step 2: Data Processing

The first step in using microbiome data is pre-processing to get the data into a format that is ready for statistical analysis.

Create an R script from within R studio and save it in your source code directory (lib). 
Give your script a meaningful name like "clean_taxonomy.R".

Begin your code with the folling script. 

This is a framework, you will need to edit the code to set your working directory.

```
# Example code
# Author: Add your name here

#### Remember your code should be well commented ####

# First set your working directory to the lib directory in your project
setwd("lab3_bioc5361/lib")

# First read in your data
tax_raw <- read.delim("../raw_data/taxonomy_raw.txt", 
                      sep = "\t",                 # file is tab seperated
                      row.names = "X.taxonomy")   # the first column should be rownames

```

Our data is in a very raw format. We want to do some very minimal processing before we use it downstream.

The first step is to remove low depth samples. So we want to know how many reads were assigned to a taxonomy for each sample.
In the data the columns are samples and the rows are taxa, so remember we want to know about samples.

**Lab report question 1 references this code chunk.**

```
s <- colSums(tax_raw)
s_sums <- sort(s)

mean(s_sums)
quantile(s_sums)
hist(s_sums)

tax_col_sums <- as.data.frame(s_sums)
View(tax_col_sums)

```

We don't want to keep samples that have a low number of overall reads, so we will drop them.
To do this we will use the bracket notation in R [].

**Lab report question 2 references this cut off value.**
```
# Drop samples with low read counts
# Notice that there is one blank with a high read count 
# Pick a value that will make sure that we drop that sample but keep as many other samples as possible
# Hint: this will be higher than 20000 and lower than 50000

# Replace the number 1 with your chosen value in the line of code below

tax <- tax_raw[, colSums(tax_raw) >= 1] 

```

Determine the dimensions of your new table called "tax" with the dim() function.

Now we want to repeat the process, but this time we want to drop any singletons (taxa with only 1 read in the study).

```
#Drop singletons
tax <- tax[rowSums(tax)>1,]

```
This is still a big table, but it's slightly processed now, so we can save it for later use.
```
# write this version to a file for use in your workflow
write.table(tax, 
            file="../clean_data/taxonomy_processed.txt", 
            quote=F, 
            sep="\t", 
            row.names = T, 
            col.names = T)
```

## Step 3. Analysis

The next step in the workflow should be analysis.

One important first analysis step in microbiome analysis pipelines is to assess alpha diversity from count data.

The most simplistic version of alpha diveristy is total speices per sample. Lets calculate the number of speices in each sample for this data and store it in a new file.

Create a new script called "count_species_per_sample.R" and save it in 'lib'.


```
# Load your processed taxonomy file at the start of this script and call it tax


# In the data frame taxa are rows and we want to know the number of non-zero rows for each column (sample)
# We can do this by using a feature in R
# First we convert our matrix to a dataframe of TRUE and FALSE values with tax > 0
# So if the value in the dataframe is more than 0 it gets a TRUE and less than 0 gets FALSE
# R treats TRUE and 1 and FALSE as 0, so if we sum each column of this new matrix we get a named number
# of how many species were present in that sample.

tax_counts <- colSums(tax > 0)


# covert this to a dataframe
tax_counts <- as.data.frame(tax_counts)

# write to a table and store in results
write.table(tax_counts, 
            file="../results/speices_per_sample.txt", 
            quote=F, 
            sep="\t", 
            row.names = T, 
            col.names = T)

# now calculate the quantiles for this and write this result to another file using write.csv().
# write.csv is another way to write data to a file, just like write.table().

quants <- quantile(taxa_counts$taxa_counts)
write.csv(quants, file = "../results/species_per_sample_summary.txt")

```

**Lab report question 3 is asking about the results of running the code above.**

## Step 4. Automate the workflow

Now you have two scripts that each complete part of your analysis pipeline from raw data to some output.

You can now create another script to link these tasks together.

Make another R script and call it "run_everything.R"

```
# Add some information here so you know what the script is doing

# Remember to set your working directory to lib where your scripts live


# use the function source to load and run the two script you wrote

source("clean_taxonomy.R")
source("count_species_per_sample.R")

```

## Check your work:
When you think you have everything working correctly you can delete your intermedite files and restart R.

Delete:
* ../clean_data/taxonomy_processed.txt
* ../results/speices_per_sample.txt
* ../results/species_per_sample_summary.txt


Run your "run_everything.R" script from a fresh R environment. 

Was your processed data file created again?
Were the same results files generated?

If your answers to these quetions are both 'yes', then congratulations! You just automated your workflow.

**Lab report question 4 is refers to the automation script.**
