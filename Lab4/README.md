# Lab 4: More RStudio and the tidyverse

One of the things that can be difficult about data science is that sometimes you have data in two different dataframes and you need to merge or join those data together so that you can draw conclusions about your samples or sequencing information.

Today's lab will introduce methods to tidy up data naming, create new variables, aggregate, reorder, transpose, filter, select, and alter text programatically.

For today's exercise you will be using real data corresponding to the taxonomy table that you used in the last lab session. This is the mapping file that identifies all of the samples in the study. By the end of today's lab you will create a smaller mapping file that identifies each of the subjects in the study.

## Step 1: Download and tidy your metadata file

Create a new R script following the instructions from Lab 2. Store this within your existing project data organizational structure. Hint: this should go in lib.

Load the metadata file into R using what you have already learned. A good short name for this file in your code is "map". Note for metadata it's sometimes helpful to keep your sample identifier (in this case #SampleID) in a column, not in rownames. So unlike our previous commands for taxonomy data, you should not use the row.names = 1 command within read.delim().

Take a look at your metadata file to make sure it was read in correctly using the following commands:

**Lab report Q1 and 2 refer to this code chunk**
```R
# Take a look at your rownames
# Remember, these should just be a numeric row number, not any sample identifier
rownames(map)

# Take a look at your column names
colnames(map) # Lab report Q1 refers to this line of code

# Change the name of you first column so that it's more human readable
# This will improve your code readibility in the future

# There are multiple ways to change the name of a column in R
# Some are better (safer) than others
# Lets try a dangerous way first

# You can change the name using base R like this
colnames(map)[colnames(map) == "X.SampleID"] <- "NEWNAME"

# Check that your name was changed 
colnames(map)

# Another way to change the column name is to use a package like tidyverse

# Install the tidyverse
install.packages("tidyverse")

# Load the tidyverse
library(tidyverse)

# Now we can change the name with tidyverse
# This uses a 'pipe' that's specific to the tidyverse '%>%'
map <- map %>% rename(SampleID = NEWNAME) # Lab report Q2 refers to this line of code

# Check that the column is called SampleID again
colnames(map)

```

## Step 2: Create a per-subject metadata file

```R
# Some of the variables in this dataframe are repeated for a subject, so our data is currently "LONG"
# It's useful to create metadata on a per-subject basis for plotting and later analysis.

# Lets do that using the tidyverse!

# First, we should limit to just the samples, not the blanks,
# Then we need to identify the columns that we want to keep for this new data table.
# For this exercise lets keep Subject, Gender, Age, Weight, Height and Waist.Circumference
# Then we want to drop duplicates from this table to end up with one row per person

subject_map <- map %>%                  # start with the long table
  filter(SampleType == "Sample") %>%    # filter acts on rows
  select(Subject,                       # name the columns you want to keep
         Gender, 
         Age, 
         Weight, 
         Height, 
         Waist.Circumference) %>% 
  distinct()                            # remove duplicated rows 


```



## Step 3: Create a new variable "BMI"


```R
# Another common task you need to complete frequenlty is to calculate new variables
# In this dataset it would be helpful to have BMI for these people
# BMI is calcuated from weight and height as (kg/m^2)
# Use the following framework to create a new variable
# Note: in this data height is in cm and weight is in kg

subject_map <- subject_map %>% 
  mutate(BMI = putyourformulahere)
  
# Take a quick look at your new variable
subject$BMI


```
## Step 4: Find the subset of individuals who have at least 6 samples

