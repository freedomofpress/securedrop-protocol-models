#!/bin/bash
# Run "make ARGS..." inside the Tamarin container, via either:
#
# 1. Docker (Podman, default): specify an image reference to pull, e.g.:
#
#   srun --mem=10G --time=1:00:00 env IMAGE=ghcr.io/<user>/tamarin@sha256:<digest> hpc/run.sh well-formed
#
# 2. Apptainer: specify the path to the ".sif" image file, e.g.:
#
#   srun --mem=10G --time=1:00:00 env SIF=$HOME/tamarin.sif hpc/run.sh well-formed

set -euo pipefail

IMAGE="${IMAGE:-}"
SIF="${SIF:-}"

if [ -n "$SIF" ]; then
    echo "Using Apptainer image ${SIF}"
    exec apptainer exec "$SIF" bash -c \
        'ulimit -Sn "$(ulimit -Hn)"; exec make "$@"' bash "$@"
fi

if [ -z "$IMAGE" ]; then
    echo "error: set IMAGE (for Podman) or SIF (for Apptainer)" >&2
    exit 2
fi

# Rootless Podman with node-local storage, namespaced per-task for isolation:
STORAGE="$(mktemp -d "${TMPDIR:-/tmp}/tamarin-${SLURM_JOB_ID:-$$}-XXXXXX")"
PODMAN=(podman --root "$STORAGE/storage" --runroot "$STORAGE/run")
trap '"${PODMAN[@]}" unshare rm -rf "$STORAGE" 2>/dev/null || rm -rf "$STORAGE"' EXIT

ulimit -Sn "$(ulimit -Hn)"
echo "Using image ${IMAGE}"
"${PODMAN[@]}" pull "$IMAGE"
"${PODMAN[@]}" run --rm \
    --env TAMARIN_RELEASE --env N_THREADS --env PORT \
    --ulimit host \
    --volume "$PWD:/workspace" \
    --workdir /workspace \
    --entrypoint make \
    "$IMAGE" "$@"
