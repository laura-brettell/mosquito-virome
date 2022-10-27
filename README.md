# mosquito-virome
Project using mosquito transcriptome data to look for RNA viruses

This is a project in progress....

The workflow takes Illumina short read sequence data and performs:
  - QC and trimming
  - removal of host reads
  - assembly of remaining non-host fraction
  - determination of viral contigs





## Workflow


### Download sequence data and set up directory structure 

``` 
mkdir ./working
mkdir ./results
mkdir ./data
mkdir ./data/raw_data
# download R1 and R2 files here 

cd ./working
```



### Make sample list

``` 
sh ./scripts/make_sample_list.sh
```

### Quality control and trimming 

**Use fastp to perform QC, detect and remove adapters and additional trimming of poor quality bases**
https://github.com/OpenGene/fastp
``` 
conda activate fastp
sh ./scripts/run_fastp.sh
conda deactivate
```
Then look at outputs to check before and after QC metrics


### Host read removal

**Map to the host genome and remove matching reads** 
This isn't optimal as my Aedes samples are from species without ref genomes, and the Culex species hadn't been determined (although possibly pipiens). But using hte Aedes aegypti and Culex pipiens genomes should remove a large amount of host reads.\

For this I will use bowtie2 to map (https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml)

**> Aedes aegypti reference genome GCF_002204515.2**

1a. download and index reference genome 
``` 
mkdir ./Aeg_ref
cd ./Aeg_ref
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v1/genome/accession/GCF_002204515.2/download?include_annotation_type=GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA&filename=GCF_002204515.2.zip" -H "Accept: application/zip"

unzip ./Aeg_ref/GCF_002204515.2.zip
```
(this code was from NCBI)

2a. build bowtie2 index file
For bowtie2 to run, the reference genome needs to be indexed
``` 
/opt/miniconda/bin/bowtie2-build ./Aeg_ref/data/GCF_002204515.2/GCF_002204515.2_AaegL5.0_genomic.fna .Aeg_ref/GCF_002204515.2
```

3a. map Aedes samples to reference genome 
I have manually subset the sample list to retain only Aedes samples for the mapping to the Aedes aegypti genome
```
sh ./scripts/map_to_host.sh
```

**> Culex pipiens reference genome GCA_016801865.2**

1b. download and index reference genome 
``` 
mkdir ./Cxp_ref
cd ./Cxp_ref
#download ref 

unzip ./Aeg_ref/GCF_002204515.2.zip
```
(this code was from NCBI)

2b. build bowtie2 index file 
For bowtie2 to run, the reference genome needs to be indexed
``` 
/opt/miniconda/bin/bowtie2-build ./ncbi_dataset/data/GCA_016801865.2/GCA_016801865.2_TS_CPP_V2_genomic.fna ./GCA_016801865.2
```

3b. map Aedes samples to reference genome 
I have manually subset the sample list to retain only Culex samples for the mapping to the Culex pipiens genome
```
sh ./scripts/map_to_host2.sh
```

**Extract the non-host reads**

Put all the alignemts to different genomes into one folder
```
mkdir ./unmapped_reads
cp ./bowtie_*/alignments/*.pe.sam ./unmapped_reads/
```

use samtools to extract the reads which didn't map to the host and extract them as fastq files
```
sh ./scripts/sam_to_bam.sh
sh ./scripts/extract_unmapped_bam.sh
sh ./make_fastqs.sh
```

### Assembly

Use spades https://github.com/ablab/spades

```
sh ./scripts/assemble_unmapped_reads.sh
```

also perform a big assembly of all unmapped reads from all samples

