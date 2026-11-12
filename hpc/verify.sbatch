#!/bin/bash
# Verify saved Tamarin proofs, via either:
#
# 1. Docker (Podman, default): specify an image reference to pull, e.g.:
#
#       sbatch --export=ALL,IMAGE=ghcr.io/<user>/tamarin@sha256:<digest> hpc/verify.sbatch
#
# 2. Apptainer: specify the path to the ".sif" image file, e.g.:
#
#       sbatch --export=ALL,SIF=$HOME/tamarin.sif hpc/verify.sbatch

#SBATCH --job-name=verify-securedrop-protocol-models
#SBATCH --array=0-4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=192G
#SBATCH --time=12:00:00
#SBATCH --requeue
#SBATCH --output=slurm-%x-%A_%a.out

set -euo pipefail

PREFIXES=(Agreement_ Auto_ Easy_ Executability Secrecy_)
PREFIX="${PREFIXES[$SLURM_ARRAY_TASK_ID]}"

cd "$(git -C "$SLURM_SUBMIT_DIR" rev-parse --show-toplevel)"
echo "Verifying proof/${PREFIX}.log on $(hostname) with ${SLURM_CPUS_PER_TASK} threads"
exec hpc/run.sh N_THREADS="${SLURM_CPUS_PER_TASK}" -W "proof/${PREFIX}.spthy" "proof/${PREFIX}.log"
