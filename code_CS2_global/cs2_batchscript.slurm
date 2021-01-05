#!/bin/bash
 
#SBATCH -p carl.p
#SBATCH --time=04-00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=sinikka.lennartz@uol.de

#SBATCH --output=slurm-%A.out
#SBATCH --error=slurm-%A.err


# load modules
module load hpc-env/6.4


module load MATLAB

# quit after error happened
set -e

# run matlab script

matlab -nodisplay -r "BMOCSmainloop_alone, exit"

exit
