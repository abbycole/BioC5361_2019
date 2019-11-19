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

Using your internet browswer take a look at the ftp site. [What other information about this organism is avaliable to you at the ftp site?](ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/026/345/GCA_000026345.1_ASM2634v1)

## Search for a 16S primer sequence in your genome using blast from the command line

First get on to an isub node, the default settings are fine for this.

```
isub
```

Load the blast module on MSI. 

```
module load ncbi_blast+
```
Make a file that will become your query sequence. And open the empty file

```
touch myquery.fna
nano myquery.fna
```
Paste a query sequence into the file with the following format, but replace the seuqence information line with the sequence you want to search for. 

```
> Your query name
SEQUENCEINFORMATION

```

Exit the nano session using ctrl + x then follow the prompts.


```
blastn -db nt -query myquery.fna -out results.out
```







