#The following command must be run in command line once before being able to use the program
# chmod +x blastList.sh
#This makes the program an executable (a file that can be run instead of just read or written to)

#Afterwards, the program can be run with ./blastList.sh


input="Genes.txt" #File with list of gene names in starting organism (Aedes Ae, Culex Q, etc) with one gene name on each line. These must be the names used in the bed file.
#This is gene1234 for Culex
#MAKE SURE THIS LIST DOES NOT HAVE WINDOWS STYLE LINE ENDINGS, USE A MAC/LINUX MACHINE TO MAKE IT OR A PROGRAM LIKE ATOM
output="Blast.txt" #Name of the file in which the blast output will be stored
bed="CulexT.bed" #File with a list of gene names and locations on the genome in the starting organism
genome="Culex-tarsalis_knwr_CONTIGS_CtarK1.fa" #Fasta file containing the genome, NOT TRANSCRIPTOME, of the starting organism

while IFS= read -r line
do
  echo $line
  grep "${line}\s" $bed | grep "ID=gene" > $line.bed
  bedtools getfasta -fi $genome -bed $line.bed -fo $line.fa
  echo $line >> $output
  tblastx -query $line.fa -db CTarsalis -evalue 1e-50 | grep "Query=" -A 7 >> $output
#-db is the name of the database for the organism you which to blast against (Culex Tarsalis in this case)
#The above line can be modified based on the desired blast search parameters, but the >> $output must always remain at the end
#To add additional blast results for each sequence (if there are additional matches), add 3 to the 7 for each additional result desired
#For example, -A 13 would add two additional results
  rm $line.fa
  rm $line.bed
#These remove the temporary files used by the program.
done < "$input"

#To make a bed file from a gff, use the following command in the command line:
#gff2bed < AedesA.gff > AedesA.bed
#Where AedesA.gff is the name of the gff file you have and AedesA.bed is the name of the
#You will need to install bedops for this command to work
