TAMARIN_RELEASE=tamarin-prover
N_THREADS=10
PORT=3001

# run models on the tamarin-server with:
interactive:
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS interactive "." --port=$(PORT)

# run models on local machine with:
prove-all-traces:
	@$(TAMARIN_RELEASE) +RTS -N$(N_THREADS) -RTS --prove="Auto_*" "securedrop.spthy"
