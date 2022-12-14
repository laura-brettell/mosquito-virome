## script to use the alignment files to determine unmapped reads then extract these in fastq formats
# using samtools

# pt 2 extract unmapped reads in bam and sort, then convert to fastq



for sample in $(cat ./sample_list.txt)
do
	samtools view \
    -b \
    -f 12 \
    -F 256 \
    -h \
    ./unmapped_reads/"$sample"_mapped_and_unmapped.bam > ./unmapped_reads/"$sample"_both_ends_unmapped.bam
        
done


for sample in $(cat ./sample_list.txt)
do
	samtools sort \
    -n \
    ./unmapped_reads/"$sample"_both_ends_unmapped.bam \
    -o ./unmapped_reads/"$sample"_both_ends_unmapped_sorted.bam 
    
done


