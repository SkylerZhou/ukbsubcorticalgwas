vi d3.sh

#!/bin/sh
merge_cmd='out_file="assoc.regenie.merged.txt"
gunzip *.regenie.gz
echo -e "CHROM\tGENPOS\tID\tALLELE0\tALLELE1\tA1FREQ\tN\tTEST\tBETA\tSE\tCHISQ\tLOG10P\tEXTRA" > $out_file
files="./*.regenie"
for f in $files
do
   tail -n+2 $f | tr " " "\t" >> $out_file
done
rm *.regenie'

data_file_dir="/whitelist_strict/PartD"

for FIRST in {25011..25024}; do 
  dx run swiss-army-knife -iin="${data_file_dir}/assoc.c1_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c2_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c3_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c4_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c5_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c6_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c7_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c8_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c9_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c10_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c11_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c12_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c13_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c14_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c15_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c16_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c17_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c18_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c19_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c20_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c21_pheno${FIRST}.regenie.gz" \
    -iin="${data_file_dir}/assoc.c22_pheno${FIRST}.regenie.gz" \
    -icmd="${merge_cmd}" --tag="Step2" --instance-type "mem1_ssd1_v2_x16"\
    --destination="/whitelist_strict/PartD/pheno${FIRST}/" --brief --yes 
done


# run
chmod +x d3.sh
bash d3.sh

# to rename all assoc.regenie.merged.txt
for FIRST in {25011..25024}; do 
  dx rename "/whitelist_strict/result/pheno${FIRST}/assoc.regenie.merged.txt" "${FIRST}.assoc.regenie.merged.txt"
done

# to download all the renamed to local explorer.exe .
for FIRST in {25011..25024}; do 
  dx download "/whitelist_strict/result/pheno${FIRST}/${FIRST}.assoc.regenie.merged.txt" 
done
