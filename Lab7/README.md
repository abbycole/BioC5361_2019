## Lab 7: Using the command line and accessing MSI

### Background
In this lab exercise we will begin to learn how to use the command line to access files stored on MSI.

### Get your login info for MSI

  * You should already have MSI access though your x500, log in using your normal username and password, but then change into the course directory with this command:
  * If you can't log in to MSI, click on this link: https://www.msi.umn.edu/user-agreement. After you agree to the user agreement you will get your login information. 
  

### Connect to MSI
- Connect to MSI using SSH. On a Mac this means opening the Terminal app and using SSH. On Windows this means using PuTTY to connect.

**Windows users**
  * Follow these instructions to configure puTTY to connect: https://www.msi.umn.edu/support/faq/how-do-i-configure-putty-connect-msi-unix-systems.
  * Alternatively, follow these instructions:
    * Install "Putty" by downloading this file and running the installer:
https://the.earth.li/~sgtatham/putty/latest/x86/putty-0.67-installer.msi
    * The lab computers alreay have putty installed
    * Open the Putty application
    * Under the "Hostname" field, enter `login.msi.umn.edu`
    * Under "Port", enter `22`
    * For "Connection type" click "SSH"
    * Click "Open"
    * Enter your MSI username and password
    * You should now be connected.

**Mac/Linux users**

  * Open the "Terminal" application. On a Mac you can click the search button (magnifying glass) and type "Terminal" to find the application.
  * Enter this command into the terminal, using your username in place of `yourusername`:

`ssh yourusername@login.msi.umn.edu`
 
 * Enter your password
  * You should now be connected.
  
  - Once you have connected to MSI navigate to your home directory for this class by running the following command:
  
  ```bash
  cd /home/bioc5361/<your username>
  ```

- When you first log in, you will be on the "login" node. You are not allowed to run computations on this node. Instead, you can get to an interactive node for running computations with this command:

- We will not run any major computational tasks today. However it's useful to practice using the interactive node. You can read more about the interactive queue here: https://www.msi.umn.edu/content/interactive-queue-use-isub
 
 ```bash
 isub -n nodes=1:ppn=4 -m 8GB -w 02:00:00
 ```

- Note: if you ever receive an error saying that you have exceeded the available memory, you can increase to 16GB.
 You can also request 8 hours instead of two as follows:
 ```bash
 isub -n nodes=1:ppn=4 -m 16GB -w 08:00:00
 ```

### Get used to navigating on the command line

```bash
# change into your “home” directory
cd

# list the contents of this directory
ls

# print out the “path” to this directory
pwd

# make a new directory (aka folder) for your programs (binaries)
mkdir bin

# make sure it got created
ls

# change into the “shared” directory
cd ../shared

# use the head command to look at the first few lines of a fna file in this directory
head mg1655_genome.fna

# now call tail to see what the end of this file looks like
tail mg1655_genome.fna

# use man to bring up the manual for the wc command
man wc

# quit the manual using q
q

# count the number of lines in the mg1655_genome.fna file using wc
# consult the manual for wc agian to work out how to run this command

# use the command grep to output any lines that contain a ">" symbol
grep ">" mg1655_genome.fna

# now get a glimpse of the first few lines of the fastq file in the shared directory using head
head 

# count the number of lines in this file and divide by 4 to determine how many reads are in this fastq

# You will notice that there is also a fasta version of this same file in the shared directory
# Remember, fastas are more "human readible" versions of genomic information
# In a fasta, each read comes afte a line that starts with ">"

# see if you can come up with a command that uses grep and wc 
# and takes advantage of the terminal pipe | to output the number of reads directly to the console
# remember the pipe | functions just like the %>% opperator from tidyverse



```




