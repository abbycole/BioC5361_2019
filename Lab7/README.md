## Lab 7: Using the command line and accessing MSI

### Background
In this lab exercise we will begin to learn how to use the command line to access files stored on MSI.

### Connect to MSI
- Connect to MSI using SSH. On a Mac this means opening the Terminal app and using SSH. On Windows this means using PuTTY to connect.
- Follow these instructions to configure puTTY to connect: https://www.msi.umn.edu/support/faq/how-do-i-configure-putty-connect-msi-unix-systems.

### Get your login info for MSI

  * You should already have MSI access though your x500, log in using your normal username and password, but then change into the course directory with this command:
  * If you can't log in to MSI, click on this link: https://www.msi.umn.edu/user-agreement. After you agree to the user agreement you will get your login information. 
  
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
```


