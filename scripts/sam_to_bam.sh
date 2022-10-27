## script to use the alignment files to determine unmapped reads then extract these in fastq formats
# using samtools

# pt 1 (I'll do this in multiple parts then combine when it works)



for sample in $(cat ./sample_list.txt)
do
	samtools view \
    -bS \
    ./unmapped_reads/"$sample"_aln.pe.sam > ./unmapped_reads/"$sample"_mapped_and_unmapped.bam
        
done
