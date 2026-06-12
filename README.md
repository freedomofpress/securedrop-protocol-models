# A Formal Analysis of the SecureDrop Protocol

This repository contains the Tamarin models for the [SecureDrop Protocol], based on [prior work by Luca Maier](https://github.com/lumaier/securedrop-formalanalysis).  For background on this project, see the [`freedomofpress/securedrop-protocol`][SecureDrop Protocol] repository.

The proofs have been constructed using the Tamarin prover, version 1.12, and Maude version 3.5.
The GUI can be started on your local machine with the command `make interactive` if Tamarin is installed.

[SecureDrop Protocol]: https://github.com/freedomofpress/securedrop-protocol


## Setup

To verify constructed proofs, you must install Tamarin at version 1.12.
We refer to the [official documentation](https://tamarin-prover.com/manual/master/book/002_installation.html) for installation instructions.
Add `tamarin-prover` to your `PATH`, or provide its path to `make` using the `TAMARIN_RELEASE` environment variable.

If you want to explore the model in interactive mode or construct proofs, you must also install [python 3](https://www.python.org/downloads/).

## Repository Structure

| File | Description |
|------|-------------|
| `parts/` | Models for cryptographic primitives and the secure channel. |
| `proof/*` | Proofs for each lemma that has a prefix matching the respective file name.
| `oracle.py` | Custom heuristics for proof search.  You may need to make this executable with `chmod +x oracle.py`. |
| `securedrop.spthy` | Protocol model file. |

## Proof Construction and Verification

To construct proofs, run `make proof/PREFIX.spthy`.
The file will contain proofs for all lemmas that have a prefix `PREFIX`.
You can verify stored proofs, run `make proof/PREFIX.log`.
This will verify the proof stored in `proof/PREFIX.spthy`, and store the Tamarin log in `proof/PREFIX.log`.

### Computation Cost

Constructing and verifying proofs is computationally quite expensive.
We note approximate computation cost below, which were obtained by timing proof verification on two machines:

- Machine A: Ubuntu 24.04, with 252 GB of memory, and two Intel Xeon E5-2650 v4 CPUs (48 threads).
- Machine B: Ubuntu 26.04, 32 GB of memory, a 200 GB swap file, and an 8-core virtual CPU.

Time format is `HH:MM:SS`.
Note that a large swap file is required as Tamarin can be quite inefficient in its use of virtual memory.
Tamarin traverses proofs using depth-first search and thus typically only needs access to the current proof path, but will store also all previous proofs and paths of lemmas already constructed.

| Machine | File | User | System | Elapsed | Max Resident Set Size |
| ------- | ---- | ---- | ------ | ------- | --------------------- |
| A | `proof/Agreement_.spthy` | 04:30:08 | 01:13:10 | 01:38:39 | 102.6 GB |
| A | `proof/Auto_.spthy` | 12:18:53 | 03:25:39 | 05:17:23 | 165.8 GB |
| A | `proof/Easy_.spthy` | 08:25:13 | 02:10:56 | 03:12:20 | 126.5  GB |
| A | `proof/Executability.spthy` | 05:01:33 | 01:20:19 | 01:59:56 | 107.4 GB |
| A | `proof/Secrecy_.spthy` | 04:44:56 | 01:18:35 | 01:44:26 | 112.1 GB |
| B | `proof/Agreement_.spthy` | 01:49:00 | 00:28:34 | 01:06:07 | 30 GB |
| B | `proof/Auto_.spthy` | 05:08:43 | 02:42:43 | 07:22:20 | 30 GB |
| B | `proof/Easy_.spthy` | 03:37:03 | 01:46:27 | 04:39:35 | 30 GB |
| B | `proof/Executability.spthy` | 01:55:26 | 00:37:20 | 01:27:26 | 30 GB |
| B | `proof/Secrecy_.spthy` | 01:49:26 | 00:28:22 | 01:06:19 | 30 GB |

### Running on HPC

If you have access to an HPC cluster, you can construct and verify proofs inside
an Apptainer container.  For example, from the root of this repository, via
Slurm:

1. Build the container:
    ```bash
    apptainer build --fakeroot tamarin.sif hpc/tamarin.def
    ```

2. Run the well-formedness checks:
    ```bash
    salloc --nodes 1 --ntasks 1 --mem=10G --time=1:00:00 apptainer exec tamarin.sif bash -c 'ulimit -Sn $(ulimit -Hn); make well-formed'
    ```

3. Verify a proof:
    ```bash
    salloc --nodes=1 --ntasks=1 --cpus-per-task=10 --mem=192G --time=12:00:00 apptainer exec tamarin.sif bash -c 'ulimit -Sn $(ulimit -Hn); make proof/Auto_.log'
    ```

You can also run batch jobs to:

- Verify all proofs: `sbatch hpc/verify.sbatch`
- Reconstruct all proofs: `sbatch hpc/prove.sbatch`