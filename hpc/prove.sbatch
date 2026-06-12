#!/bin/bash
#SBATCH --job-name=prove-securedrop-protocol-models
#SBATCH --array=0-4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=192G
#SBATCH --time=24:00:00
#SBATCH --requeue
#SBATCH --output=slurm-%x-%A_%a.out

set -euo pipefail

# Path to the Apptainer image (override with: sbatch --export=SIF=$HOME/tamarin.sif ...)
SIF="${SIF:-tamarin.sif}"

PREFIXES=(Agreement_ Auto_ Easy_ Executability Secrecy_)
PREFIX="${PREFIXES[$SLURM_ARRAY_TASK_ID]}"

cd "$SLURM_SUBMIT_DIR"

echo "Constructing proof/${PREFIX}.spthy on $(hostname) with ${SLURM_CPUS_PER_TASK} threads"

apptainer exec "$SIF" bash -c \
    "ulimit -Sn \$(ulimit -Hn); make N_THREADS=${SLURM_CPUS_PER_TASK} -B proof/${PREFIX}.spthy"