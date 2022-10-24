## Use bowtie2 to map to the Aedes aegypti reference genome

mkdir ./bowtie_Culex
mkdir ./bowtie_Culex/alignments


for sample in $(cat ./Cx_sample_list.txt)
do
	/opt/miniconda/bin/bowtie2 \
    -X 1000 \
    -x ./Cxp_ref/GCA_016801865.2 \
    -1 ../data/fastp_trimmed_reads/"$sample"_1_trimmed.fq.gz \
    -2 ../data/fastp_trimmed_reads/"$sample"_2_trimmed.fq.gz \
    -S ./bowtie_Culex/alignments/"$sample"_aln.pe.sam
    --threads 8 \
    

done
