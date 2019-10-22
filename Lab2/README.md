# R Basics

R is a language you will want to get familiar with to improve your ability to understand, analyse, and visualize your data. 

To begin to get comfortable with R, a good resouce is a package called swirl.

Open RStudio and enter these commands in the console to get started.

## Install and load swirl
```
install.packages("swirl")
```
With swirl installed in your package library, it's time to load it so we can use it.

```
library(swirl)
```
Notice that the convention in R is to use "" around the package name with install.packages, but to omit the "" when loading a package.

Follow the prompts in the console and select "1: R Programming: The basics of programming in R".

## Complete swirl practice 1. Basic Building Blocks
To start with I reccomend you work through the first module titled "1. Basic Building Blocks". 


## Explore real data in R 
Next we will import data into R and learn how to explore our data.

Download the files taxonomy and metadata files from this repo to your computer. Take note of where you store them. 

Start by setting your R working directory with the following command (hint: use tab complete here to help you find your files locally).

```
setwd(dir = "insert/your/directory/path/here")
```

Now we will read in your files. 

First take a look at the command read.delim using the R help function run:

```
?read.delim
```

Store the file within R, lets call it map since it's a map to understand our data.

```
map <- read.delim("Subject_metadata.txt", header = T, sep = "\t")
```

Take a quick look at the number of rows and columns that you have in the file.

```
dim(map)
```
Not sure which number refers to the rows and which refers to columns? Try nrow and ncol to find out how many rows there are.

```
nrow(map)
ncol(map)
```

View the file with the interactive view in R.

```
View(map)
```

What if we just want to take a really quick peak at the data because the dataframe is large. Then just look at the first few columns:

```
head(map)
```

Take a look at the column names:

```
colnames(map)
```

What about rownames, any information there?

```
rownames(map)
```

Take a look at all the variables at once to get an idea of the information in this dataset

```
summary(map)
```





## Extra practice
If you have R on your own computer, then I recommend completing a least a few other modules, particularly 2-4 intially. These will give you a nice introduction to R and should help you to feel more confident using R for basic analysis:
 
### Recomended Modules
2. Workspace and Files    
3. Sequences of Numbers
4. Vectors
