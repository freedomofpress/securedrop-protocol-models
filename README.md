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
You can verify constructed or stored proofs by executing:

```sh
tamarin-prover --derivcheck-timeout=0 proof/FILE
```
