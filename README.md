# A Formal Analysis of the SecureDrop Protocol

This repository contains the Tamarin models for the SecureDrop protocol.
The models were developed by Luca Maier and Felix Linker.
Work on the formal models begun as part of Luca's Master thesis, which is linked below.

The proofs have been constructed using `Tamarin 1.10.0`.
The GUI can be started on your local machine with the command `make interactive` if Tamarin is installed.

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
tamarin-prover --derivcheck-timeout=0 proof/FILE
```

## Resources

- Repository with protocol specification: https://github.com/freedomofpress/securedrop-protocol/
- Maier, Luca. "A Formal Analysis of the SecureDrop Protocol." Thesis. 2025. ([ETHZ Research Collection](https://www.research-collection.ethz.ch/entities/publication/6a03f3ca-d705-4382-a650-8f07ff549fa7))
