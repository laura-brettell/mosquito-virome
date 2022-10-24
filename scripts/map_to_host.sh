## Use bowtie2 to map to the Aedes aegypti reference genome

mkdir ./bowtie_Aedes
mkdir ./bowtie_Aedes/alignments


for sample in $(cat ./Aedes_sample_list.txt)
do
	/opt/miniconda/bin/bowtie2 \
    -X 1000 \
    -x ./Aeg_ref/GCF_002204515.2 \
    -1 ../data/fastp_trimmed_reads/"$sample"_1_trimmed.fq.gz \
    -2 ../data/fastp_trimmed_reads/"$sample"_2_trimmed.fq.gz \
    -S ./bowtie_Aedes/alignments/"$sample"_aln.pe.sam
    --threads 8 \
    

done
