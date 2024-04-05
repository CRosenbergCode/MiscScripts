Usage of probes_helper.sh script


This program is made for Unix based systems (Mac/Linux). For Windows computers, a virtual machine or WSL can
be used but all necessary programs will need to be reinstalled. Unless otherwise stated, all commands must be
run through command line or system equivalent.

R and three libraries (ade4, seqinr, zoo) must be installed. The following commands will do so.

sudo apt install r-base-core
sudo Rscript -e 'install.packages("ade4", repos="https://cloud.r-project.org")'
sudo Rscript -e 'install.packages("seqinr", repos="https://cloud.r-project.org")'
sudo Rscript -e 'install.packages("zoo", repos="https://cloud.r-project.org")'

Ensure the script is executable by running the following command once:
chmod +x probes_helper.sh

Modify the 12th and 28th lines of the R file with the appropriate directories (the directory containing all the files).
In future, I hope to modify this to automatically get the directory but system utils can be very OS dependent.

To use this pipeline, create a text file with one gene name on each line (gene####, the names used in the gtf file).
The text file must have Unix file endings, not Windows. NO CARRIAGE RETURNS.

Then, run the following command.

./probes_helper.sh <gene_list>

Where <gene_list> is the file you created in the previous step.
