#The following command must be run in command line once before being able to use the program
# chmod +x get_fasta.sh
#This makes the program an executable (a file that can be run instead of just read or written to)

#Afterwards, the program can be run with ./get_fasta.sh

#THIS PROGRAM REQUIRES INSTALLATION OF BEDTOOLS BEFORE USAGE
#INSTALL IT !!!!!!

input="Genes.txt" #File with list of gene names in starting organism (Aedes Ae, Culex Q, etc) with one gene name on each line. These must be the names used in the bed file.
#This is gene1234 for Culex
#MAKE SURE THIS LIST DOES NOT HAVE WINDOWS STYLE LINE ENDINGS, USE A MAC/LINUX MACHINE TO MAKE IT OR A PROGRAM LIKE ATOM
bed="CulexT.bed" #Bed file with a list of gene names and locations on the genome
genome="Culex-tarsalis_knwr_CONTIGS_CtarK1.fa" #Fasta file containing the genome, NOT TRANSCRIPTOME, of the  organism

while IFS= read -r line
do
  echo $line
  #There are two lines: One for DNA, one for RNA. Comment out the one you do not want with a # in front of it
  #The below line is the option for DNA
  #grep -A1 "${line}\s" $bed | grep "ID=gene" > $line.bed
  #Below is the option for mRNA
  grep "${line}\s" $bed | grep "ID=mRNA" > $line.bed
  bedtools getfasta -fi $genome -bed $line.bed -fo $line.fa
  rm $line.bed
#These remove the temporary files used by the program.
done < "$input"

#To make a bed file from a gff, use the following command in the command line:
#gff2bed < AedesA.gff > AedesA.bed
#Where AedesA.gff is the name of the gff file you have and AedesA.bed is the name of the
#You will need to install bedops for this command to work
