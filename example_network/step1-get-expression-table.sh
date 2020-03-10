

mkdir -p kallisto_output/

# Loop over the ftp urls for the samples of the PRJNA233428 study
# (table downloaded from https://www.ebi.ac.uk/ena/data/view/PRJNA233428)
for f in $(tail -n +3 PRJNA233428.txt | awk -F"\t" '{print $10}')
do
    # in case this needs to be rerun, check if the kallisto output already exists. If so, skip
    if [ -f kallisto_output/$(basename ${f%.fastq.gz})/abundance.tsv ];
    then
        echo "kallisto_output/$(basename ${f%.fastq.gz})/abundance.tsv already exists, skip"
        continue
    fi
    # For this example we use same arguments as on https://pachterlab.github.io/kallisto/manual
    # for single cell data.
    # For your data this might have to be adjusted. See kallisto manual for details.
    # Also, see kallisto manual for how to make transcriptome_v98.idx.
    # **IMPORTANT**: The reference index should not include patch and alternative chromosomes.
    kallisto quant -i transcriptome_v98.idx \
         -o kallisto_output/$(basename ${f%.fastq.gz}) \
         --single \
         -l 200 \
         -s 20 \
         --threads=1 \
         <(curl -Ls ${f}) # This streams the fastq file from the ftp server. Can also put in a file instead
done


# After all kallisto quantification is done, merge the abundance.tsv files into a matrix
# gencode.v32.primary_assembly.annotation.gtf has to be from the same genome build as was used for the kallisto index
# This will sum transcript counts to gene level counts
# Note: needs python 3.x
python /groups/umcg-biogen/tmp03/tools/brain_eQTL/utility_scripts/expression_scripts/merge_kallisto_counts.py \
    kallisto_output/ \
    gencode.v32.primary_assembly.annotation.gtf \
    kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt \
    kallisto_output/merged_kallisto_transcriptTPMs/transcriptTPMs.txt \
    kallisto_output/merged_kallisto_transcriptCounts//transcriptCounts.txt \
    --threads 1

# get a list of samples that will be used as input for next step
head -n1 kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt | sed -e 's;\t;\n;g' | tail -n +2 > kallisto_output/list_of_samples.txt

head -n1001 kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt > kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt.tmp
mv kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt.tmp kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt
gzip kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt

