#!/bin/bash           # the shell language when run outside of the job scheduler
#                     # lines starting with #$ is an instruction to the job scheduler
#$ -S /bin/bash       # the shell language when run via the job scheduler [IMPORTANT]
#$ -cwd               # job should run in the current working directory
#$ -j y               # STDERR and STDOUT should be joined
#$ -l mem_free=1G     # job requires up to 1 GiB of RAM per slot
#$ -l scratch=2G      # job requires up to 2 GiB of local /scratch space
#$ -l h_rt=24:00:00   # job requires up to 24 hours of runtime
##$ -t 1-10           # array job with 10 tasks (remove first '#' to enable)
#$ -r y               # if job crashes, it should be restarted

module load Sali
module load conda-forge/py312-24.7.1
module load  python3/h5py/2.10.
module load python3/scipy/1.3.2

python3 /wynton/scratch/BMI206_NIC/tools/PRScsx/PRScsx.py --ref_dir=/wynton/scratch/BMI206_NIC/ref_datasets/1KG_datasets --bim_prefix=/wynton/scratch/BMI206_NIC/naracGenos-gaw16raw --sst_file=/wynton/scratch/BMI206_NIC/ipsa_project/cl_GCST90132226_buildGRCh37.tsv --n_gwas=1000 --pop=SAS --phi=1e-2 --out_dir=./ --out_name=GCST90132226_SAS


