echo Enter required length for promoter region

read len

echo Enter fasta file name located in working directory
echo For example: Aedes.fa

read fasta

echo Enter gff file name located in working directory
echo For example: Aedes.gff

read gff

echo Enter gene list file name located in working directory
echo For example: search.txt

read search

sort -k1 $search > temp.search

cp -f temp.search $search

echo "$(<$search)"

samtools faidx $fasta

cut -f 1,2 $fasta.fai > chrom.sizes

gff2bed < $gff > temp.bed

bedtools flank -i temp.bed -g chrom.sizes -l $len -r 0 -s > tempUp.bed

grep -f temp.search tempUp.bed | grep protein_coding_gene | cut -f 1,2,3,10 > selected.bed

sort -k4 selected.bed > sorted.bed

echo "$(<sorted.bed)"

bedtools getfasta -fi Aedes.fa -bed sorted.bed > upstream.fa

rm temp.bed
rm tempUp.bed
rm sorted.bed
rm selected.bed
