# dx login
vi b1.sh

#!/bin/sh

#output directory - this should also be where the files in 02-step1-qc-filter.sh end up
pheno_file_dir="project-GFv8ZJQJGgfVjGjpJ7vB2X1p:/whitelist_strict/PartA"
geno_file_dir="project-GFv8ZJQJGgfVjGjpJ7vB2X1p:/T1geno_PartA/Liftover Data_step1_step2"
qc_file_dir="project-GFv8ZJQJGgfVjGjpJ7vB2X1p:/whitelist_strict/PartA"

# --keep the whitenames used for this step needs to be uploaded 
run_regenie_step1="regenie \
--step 1 --out FIRST_results \
--lowmem --bed ukb_c1-22_GRCh38_full_analysis_set_plus_decoy_hla_merged \
--bsize 1000 \
--extract '/mnt/project/whitelist_strict/PartA/FIRST_array_snps_qc_pass.snplist' \
--keep '/mnt/project/whitelist_strict/PartA/FIRST_array_snps_qc_pass.id' \
--phenoFile FIRSTtable.phe \
--phenoColList pheno25011,pheno25012,pheno25013,pheno25014,pheno25015,pheno25016,pheno25017,pheno25018,pheno25019,pheno25020,pheno25021,pheno25022,pheno25023,pheno25024 \
--covarFile FIRSTtable.phe \
--covarColList sex,deprivation_index,age,pc{1:10} \
--qt --loocv --gz --threads 16"

dx run swiss-army-knife -iin="${geno_file_dir}/ukb_c1-22_GRCh38_full_analysis_set_plus_decoy_hla_merged.bed" \
   -iin="${geno_file_dir}/ukb_c1-22_GRCh38_full_analysis_set_plus_decoy_hla_merged.bim" \
   -iin="${geno_file_dir}/ukb_c1-22_GRCh38_full_analysis_set_plus_decoy_hla_merged.fam" \
   -iin="${pheno_file_dir}/FIRSTtable.phe" \
   -icmd="${run_regenie_step1}" --tag="Step1" --instance-type "mem1_ssd1_v2_x16" \
   --destination="/whitelist_strict/PartB/" --brief --yes

# run
sh b1.sh
