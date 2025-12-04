TAMARIN_RELEASE ?= tamarin-prover
N_THREADS ?= 10
PORT ?= 3001
DEBUG_BOUND ?= 20

.PHONY: well-formed
well-formed:
	@$(TAMARIN_RELEASE) --quit-on-warning --derivcheck-timeout=-1 "securedrop.spthy"

.PHONY: interactive
interactive:
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS interactive --image-format=SVG --derivcheck-timeout=0 --port=$(PORT) "./"

proof/%.spthy: securedrop.spthy oracle.py parts/*.spthy
	mkdir -p proof
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --derivcheck-timeout=0 --prove="$**" --output="$@" "securedrop.spthy"

debug/%.spthy: securedrop.spthy oracle.py parts/*.spthy
	mkdir -p debug
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --derivcheck-timeout=0 --bound=$(DEBUG_BOUND) --stop-on-trace=sorry --prove="$**" --output="$@" "securedrop.spthy"
