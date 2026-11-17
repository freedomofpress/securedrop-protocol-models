#!/bin/bash
# Construct Tamarin proofs, via either:
#
# 1. Docker (Podman, default): specify an image reference to pull, e.g.:
#
#       sbatch --export=ALL,IMAGE=ghcr.io/<user>/tamarin@sha256:<digest> hpc/prove.sbatch
#
# 2. Apptainer: specify the path to the ".sif" image file, e.g.:
#
#       sbatch --export=ALL,SIF=$HOME/tamarin.sif hpc/prove.sbatch

#SBATCH --job-name=prove-securedrop-protocol-models
#SBATCH --array=0-4
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=512G
#SBATCH --time=24:00:00
#SBATCH --requeue
#SBATCH --output=slurm-%x-%A_%a.out

set -euo pipefail

PREFIXES=(Agreement_ Auto_ Easy_ Executability Secrecy_)
PREFIX="${PREFIXES[$SLURM_ARRAY_TASK_ID]}"

cd "$(git -C "$SLURM_SUBMIT_DIR" rev-parse --show-toplevel)"
echo "Constructing proof/${PREFIX}.spthy on $(hostname) with ${SLURM_CPUS_PER_TASK} threads"
exec hpc/run.sh N_THREADS="${SLURM_CPUS_PER_TASK}" -B "proof/${PREFIX}.spthy"
