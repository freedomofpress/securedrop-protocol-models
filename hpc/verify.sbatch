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

IMAGE="${IMAGE:-}"
SIF="${SIF:-}"

PREFIXES=(Agreement_ Auto_ Easy_ Executability Secrecy_)
PREFIX="${PREFIXES[$SLURM_ARRAY_TASK_ID]}"

cd "$SLURM_SUBMIT_DIR"

echo "Verifying proof/${PREFIX}.log on $(hostname) with ${SLURM_CPUS_PER_TASK} threads"

MAKE_ARGS=(N_THREADS="${SLURM_CPUS_PER_TASK}" -W "proof/${PREFIX}.spthy" "proof/${PREFIX}.log")

if [ -z "$SIF" ]; then
    if [ -z "$IMAGE" ]; then
        echo "error: set IMAGE (for Podman) or SIF (for Apptainer)" >&2
        exit 2
    fi

    # Rootless Podman with node-local storage, namespaced per-task for
    # isolation:
    STORAGE="${TMPDIR:-/tmp}/${USER}/containers-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}"
    PODMAN=(podman --root "$STORAGE/storage" --runroot "$STORAGE/run")
    trap '"${PODMAN[@]}" unshare rm -rf "$STORAGE" 2>/dev/null || rm -rf "$STORAGE"' EXIT

    echo "Using image ${IMAGE}"
    "${PODMAN[@]}" pull "$IMAGE"
    "${PODMAN[@]}" run --rm \
        --ulimit host \
        --volume "$PWD:/workspace" \
        --workdir /workspace \
        --entrypoint make \
        "$IMAGE" "${MAKE_ARGS[@]}"
else
    echo "Using Apptainer image ${SIF}"
    apptainer exec "$SIF" bash -c \
        "ulimit -Sn \$(ulimit -Hn); make ${MAKE_ARGS[*]}"
fi
