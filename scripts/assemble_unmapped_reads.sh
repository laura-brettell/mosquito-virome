## script to assemble unmapped reads using spades


mkdir

for sample in $(cat ./sample_list.txt)
do
	/usr/bin/spades.py \
    -- rna  \
    -1 ./unmapped_reads/"$sample"_host_removed_R1.fastq \
    -2 ./unmapped_reads/"$sample"_host_removed_R2.fastq \
    -o ./assemblies/"$sample"_host_removed_assembly
    
done

