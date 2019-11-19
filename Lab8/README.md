# Lab 8: Getting and exploring new data from the command line

## Downloading a genome with wget

Firstly, today we will learn how to download sequence data from NCBI using a command called wget.

Open a connection to MSI and navigate to your directory within our class directory.

```
cd ~/home/bioc5361/<yourX500>
```

We will download a genome file from the internet using the NCBI ftp site and a command called wget.
Notice that this command will connect to the location of the genomic file directly and put it into a new directory that will be named "my_dir".

```
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/026/345/GCA_000026345.1_ASM2634v1/GCA_000026345.1_ASM2634v1_genomic.fna.gz -P my_dir/
```

The file you have downloaded is compressed, so we need to unzip it. Do that with gunzip.

```
cd my_dir
gunzip GCA_000026345.1_ASM2634v1_genomic.fna.gz
```

Use head to take a look at the first few lines of the file. 

```
head GCA_000026345.1_ASM2634v1_genomic.fna.gz
```

What genome have you downloaded?

Using your internet browswer take a look at the ftp site. [What other information about this organism is avaliable to you at the ftp site?]((ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/026/345/GCA_000026345.1_ASM2634v1))

Can you find another genome and sucessfully download it as well? Start at the refseq ftp site and see if you can work out how to find the correct file to download for your favorite bug of interest. [Refseq/bacteria]((ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/bacteria/))

Compare the new genome you've downloaded to the genome I directed you to using wc. 

How do their file sizes differ?








