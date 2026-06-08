# Stored Proofs

This directory contains proofs for the SecureDrop protocol.
Every file is named after the prefix of lemmas for which it contains proofs.
For example, `Agreement_.spthy` contains the proof for the lemmas `Agreement_Source` and `Agreement_Journalist`.
To check proofs, run:

```
tamarin-prover --derivcheck-timeout=0 FILE
```

## Computation Cost

We note approximate computation cost below.
Proofs were timed on a machine running Ubuntu 24.04, and with 252 GB of memory and two Intel Xeon E5-2650 v4 CPUs, i.e., a 48-thread server.
Time format is `HH:MM:SS`.

| File | User | System | Elapsed | Max Resident Set Size |
| ---- | ---- | ------ | ------- | --------------------- |
proof/Agreement_.spthy | 04:30:08 | 01:13:10 | 01:38:39 | 102.6 GB |
proof/Auto_.spthy | 12:18:53 | 03:25:39 | 05:17:23 | 165.8 GB |
proof/Easy_.spthy | 08:25:13 | 02:10:56 | 03:12:20 | 126.5  GB |
proof/Executability.spthy | 05:01:33 | 01:20:19 | 01:59:56 | 107.4 GB |
proof/Secrecy_.spthy | 04:44:56 | 01:18:35 | 01:44:26 | 112.1 GB |

Note that you machine may require less physical memory than the maximum resident set size indicates as Tamarin can be quite inefficient in its use of virtual memory.
Tamarin traverses proofs using depth-first search and thus typically only needs access to the current proof path, but will store also all previous proofs and paths of lemmas already constructed.
For example, on MacOS we observed physical memory use that is 10% of the virtual memory use.
