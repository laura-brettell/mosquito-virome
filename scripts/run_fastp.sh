## Perform fastp to QC and trim raw reads 
## https://github.com/OpenGene/fastp
## this is fastp v0.12.4
## make sure the fastp conda env is activated before running script

mkdir ../data/fastp_trimmed_reads
mkdir fastp_reports


for sample in $(cat ./sample_list.txt)
do
	fastp \
    --in1 ../raw_data/"$sample"_1.fastq.gz \
    --in2 ../raw_data/"$sample"_2.fastq.gz \
    --out1 ../data/fastp_trimmed_reads/"$sample"_R1_trimmed.fq.gz \
    --out2 ../data/fastp_trimmed_reads/"$sample"_R2_trimmed.fq.gz \
    -t 8 \
    -R "$sample"_fastp_report \
    -h ./fastp_reports/"$sample"_fastp.html \
    -j ./fastp_reports/"$sample"_fastp.json

done
