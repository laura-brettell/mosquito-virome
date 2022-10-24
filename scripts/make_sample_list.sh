echo "Creating fastq_samples.txt file..."
	ls ../data/fastp_trimmed_reads/"$sample"*.fq.gz | cut -f4 -d "/" | cut -d "_" -f1,2 | uniq > sample_list.txt
	echo "DONE"


