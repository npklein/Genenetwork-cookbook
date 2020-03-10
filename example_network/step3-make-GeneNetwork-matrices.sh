#  -t      TMPDIR where files will be written during runtime
#  -e      Expression file
#  -p      Base of the project_dir where config files will be written
#  -o      Output directory where results will be written
#  -j      Location of eqtl-mapping-pipeline.jar
#  -s      File with samples to include
#  -g      Location of git cloned https://github.com/npklein/brain_eQTL/ directory
#  -z      Covariate table
#  -v      Number of threads to use in correlation and PCA step
#  -a      GTF
#  -r      cronbach alpha cut-off (0-1) for eigenvector inclusion
#  -d      GeneNetwork directory (with PathwayMatrix/ and GeneNetworkBackend-1.0.7-SNAPSHOT-jar-with-dependencies.jar)

projectdir="/groups/umcg-biogen/tmp03/tools/github/Genenetwork-cookbook/example_network/"
bash /groups/umcg-biogen/tmp03/tools/brain_eQTL/GeneNetwork/step2-GeneNetworkMatrix-creation.sh \
    -t $projectdir/tmp/ \
    -e kallisto_output/merged_kallisto_geneCounts/geneEstimatedCounts.txt.gz \
    -p $projectdir/ \
    -o $projectdir/output \
    -j eqtl-mapping-pipeline-1.4.7-SNAPSHOT/ \
    -s output/3_quantileNormalized/samples_after_PC_filter.txt \
    -g /groups/umcg-biogen/tmp03/tools//brain_eQTL/ \
    -z covariates.txt \
    -a gencode.v32.primary_assembly.annotation.gtf \
    -v 1 \
    -r 0.9 \
    -d $projectdir/GeneNetworkBackend/ \
    -m 20g \
    -q dev
