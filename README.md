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

**Map to the Ades aegypti genome and remove matching reads** \
This isn't optimal as my data is from Ae. detritus and Ae. caspius, but should remove a large amount of host reads.
(I also have Culex spp. so I will look at the most suitable reference genome for those). I will use bowtie2 for this (https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml)

**1. download and index reference genome** \
``` 
mkdir ./Aeg_ref
cd ./Aeg_ref
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v1/genome/accession/GCF_002204515.2/download?include_annotation_type=GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA&filename=GCF_002204515.2.zip" -H "Accept: application/zip"

unzip ./Aeg_ref/GCF_002204515.2.zip
```
(this code was from NCBI)

**2. build bowtie2 index file** \
For bowtie2 to run, the reference genome needs to be indexed
``` 
/opt/miniconda/bin/bowtie2-build ./Aeg_ref/data/GCF_002204515.2/GCF_002204515.2_AaegL5.0_genomic.fna .Aeg_ref/GCF_002204515.2
```

**3. map Aedes samples to reference genome** \
I have manually subset the sample list to retain only Aedes samples for the mappint to the Aedes aegypti genome
```
sh ./scripts/map_to_host.sh
```

