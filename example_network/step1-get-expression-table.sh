

mkdir -p kallisto_output/

# Loop over the ftp urls for the samples of the PRJNA233428 study
# (table downloaded from https://www.ebi.ac.uk/ena/data/view/PRJNA233428)
for f in $(tail -n +3 PRJNA233428.txt | awk -F"\t" '{print $10}')
do
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
         <(curl -Ls ${f}) # This streams the fastq file from the ftp server. Can also put in a file instead
done


# After all kallisto quantification is done, merge the abundance.tsv files into a matrix


