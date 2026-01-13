# A Formal Analysis of the SecureDrop Protocol

This repository contains the Tamarin models for the SecureDrop protocol.
The proofs have been constructed using `Tamarin 1.10.0`.
The GUI can be started on your local machine with the command `make interactive` if Tamarin is installed.

## Setup

We provide a command to install all required binaries for Linux (tested with Ubuntu 24.04).
To install Tamarin in the `./tools` directory, run:

```sh
make setup
```

## Repository Structure

| File | Description |
|------|-------------|
| `parts/` | Models for cryptographic primitives and the secure channel. |
| `proof/*` | Proofs for each lemma that has a prefix matching the respective file name.
| `oracle.py` | Custom heuristics for proof search. |
| `securedrop.spthy` | Protocol model file. |

To construct proofs, run `make proof/PREFIX.spthy`.
The file will contain proofs for all lemmas that have a prefix `PREFIX`.
You can verify constructed or stored proofs by executing:

```sh
./check proof/FILE
```
