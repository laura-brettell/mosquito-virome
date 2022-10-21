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
# add code here
```


### Quality control and trimming 

**Use fastp to perform QC, detect and remove adapters and additional trimming of poor quality bases**
https://github.com/OpenGene/fastp
``` 
conda activate fastp
sh ../scripts/run_fastp.sh
conda deactivate
```
Then look at outputs to check before and after QC metrics


### Host read removal

**Map to the Ades aegypti genome and remove matching reads**
This isn't optimal as my data is from Ae. detritus and Ae. caspius, but should remove a large amount of host reads.
(I also have Culex spp. so I will look at the most suitable reference genome for those)

**1. download reference genome**
``` 
curl -OJX GET "https://api.ncbi.nlm.nih.gov/datasets/v1/genome/accession/GCF_002204515.2/download?include_annotation_type=GENOME_GFF,RNA_FASTA,CDS_FASTA,PROT_FASTA&filename=GCF_002204515.2.zip" -H "Accept: application/zip"

```
