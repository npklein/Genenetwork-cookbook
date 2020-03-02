

#  -t      TMPDIR where files will be written during runtime
#  -e      Expression file
#  -p      Base of the project_dir where config files will be written
#  -c      Dir with configuration template files
#  -o      Output directory where results will be written
#  -j      Location of RunV13.jar
#  -s      File with samples to include
#  -g      Github GeneNetwork directory
#  -v      Number of threads to use in correlation and PCA step
#  -a      GTF
bash /groups/umcg-biogen/tmp03/tools/brain_eQTL/GeneNetwork/step1-PCA-outlier-detection.sh \
    -t tmp/ \
    -e kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt.gz \
    -p $PWD \
    -o $PWD/output/ \
    -j $PWD \
    -g /groups/umcg-biogen/tmp03/tools/brain_eQTL/ \
    -a gencode.v32.primary_assembly.annotation.gtf \
    -v 1 \
    -s kallisto_output/list_of_samples.txt
