#input="Selected.bed"
bedtools getfasta -fi flyGenome.fa -bed Selected.bed
#while IFS= read -r line
#do
  #echo "$line"
  #bedtools getfasta -fi flyGenome.fa -bed $FILE
#done < "$input"


touch culexCC.txt
for FILE in xx*
do
  echo $FILE
  #tot=$(grep "NC_" ${FILE} | wc -l)
  #echo $(grep "NC_" ${FILE} | wc -l)
  #yeast=$(wc -l $FILE | cut -d " " -f1)
  echo $FILE >> culexCC.txt
  #tblastx -query $FILE -db CulexT -evalue 1e-300 -outfmt "6 qseqid sseqid slen qstart qend length" >> culexCC.txt
  tblastx -query $FILE -db CTarsalis -evalue 1e-25 | grep "Query=" -A 7 >> culexCC.txt
  #echo $yeast
  #echo $tot
done

#tblastx -query $FILE -db CulexQ -evalue 1e-300 -outfmt "6 qseqid sseqid slen qstart qend length"


input="Selected.bed"
touch sortedFlyCC.txt
######################################
# $IFS removed to allow the trimming #
#####################################
while IFS= read -r line
do
  echo $line
  ONE=$(echo $line | cut -d' ' -f2)
  echo $ONE
  TWO=$(echo $line | cut -d' ' -f3)
  echo $TWO
  FB=$(grep $ONE DMel.gtf | grep $TWO | cut -f9 | grep 'FBgn[0-9]*' -o -m1)
  echo $FB
  PHASE=$(grep $FB Drosophila_melanogaster.csv | cut -d',' -f1)
  echo $PHASE
  echo "$FB $PHASE" >> sortedFlyCC.txt
done < "$input"

while IFS= read -r line
do
  echo $line
  echo $(echo $line | cut -d' ' -f2)
done < "$input"

input="Selected.bed"
touch sortedFlyNames.txt
while IFS= read -r line
do
  echo $line
  ONE=$(echo $line | cut -d' ' -f2)
  echo $ONE
  TWO=$(echo $line | cut -d' ' -f3)
  echo $TWO
  FB=$(grep $ONE DMel.gtf | grep -m1 $TWO | cut -f9 | cut -f4 -d'"')
  echo $FB
  #PHASE=$(grep $FB Drosophila_melanogaster.csv | cut -d',' -f1)
  #echo $PHASE
  echo "$FB" >> sortedFlyNames.txt
done < "$input"
