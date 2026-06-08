TAMARIN_RELEASE ?= tamarin-prover
N_THREADS ?= 10
PORT ?= 3001

.PHONY: well-formed
well-formed:
	@$(TAMARIN_RELEASE) --quit-on-warning --derivcheck-timeout=-1 "securedrop.spthy"

.PHONY: interactive
interactive:
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS interactive --image-format=SVG --derivcheck-timeout=0 --port=$(PORT) "./"

proof/%.spthy: securedrop.spthy oracle.py parts/*.spthy
	mkdir -p proof
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --derivcheck-timeout=0 --prove="$**" --output="$@" "securedrop.spthy"

proof/%.log: proof/*.spthy
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --derivcheck-timeout=0 "proof/$*.spthy" > "proof/$*.log" 2>&1

debug/%.spthy: securedrop.spthy oracle.py parts/*.spthy
	mkdir -p debug
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --derivcheck-timeout=0 --oracle-only --stop-on-trace=sorry --prove="$**" --output="$@" "securedrop.spthy"
