

#  -t      TMPDIR where files will be written during runtime
#  -e      Expression file
#  -p      Base of the project_dir where config files will be written
#  -c      Dir with configuration template files
#  -o      Output directory where results will be written
#  -j      Location of eqtl-mapping-pipeline.jar
#  -s      File with samples to include
#  -g      Github GeneNetwork directory
#  -v      Number of threads to use in correlation and PCA step
#  -a      GTF

bash /groups/umcg-biogen/tmp03/tools/brain_eQTL/GeneNetwork/step1-PCA-outlier-detection.sh \
    -t tmp/ \
    -e kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt.gz \
    -p $PWD \
    -o $PWD/output/ \
    -j $PWD/eqtl-mapping-pipeline-1.4.7-SNAPSHOT/ \
    -g /groups/umcg-biogen/tmp03/tools/brain_eQTL/ \
    -a gencode.v32.primary_assembly.annotation.gtf \
    -m 10g \
    -s kallisto_output/list_of_samples.txt


# select samples where Comp1 > 0.274
awk '$2 >= 0.274 {print $1}' output/3_quantileNormalized/pc1_2.txt > output/3_quantileNormalized/samples_after_PC_filter.txt
