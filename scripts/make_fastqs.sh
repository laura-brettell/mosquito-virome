## script to use the alignment files to determine unmapped reads then extract these in fastq formats
# using samtools

# pt 2 extract unmapped reads in bam and sort, then convert to fastq


for sample in $(cat ./temp_sample_list.txt)
do
	bamToFastq \
    -i ../unmapped_reads/"$sample"_both_ends_unmapped_sorted.bam  \
    -fq ./unmapped_reads/"$sample"_host_removed_R1.fastq \
    -fq2 ./unmapped_reads/ "$sample"_host_removed_R2.fastq
    
done

