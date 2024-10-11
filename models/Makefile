N_THREADS=10
PORT=1611 # used port for port-forwarding the GUI
DIR="v1/"
USER:=$(shell whoami)

# run for different model on the tamarin-server with:
# make run DIR="path/to/model/"
run:
	@tamarin-prover-release +RTS -N$(N_THREADS) -RTS interactive "$(DIR)" --port=$(PORT)

# run for different model on local machine with:
# make run DIR="path/to/model/"
run:
	@tamarin +RTS -N$(N_THREADS) -RTS interactive "$(DIR)" --port=$(PORT)

# runs the tamarin-prover with the "auto-sources" flag which tries to automatically generate source lemmas
# to remove partial deconstructions
run_auto:
	@tamarin-prover-release +RTS -N$(N_THREADS) -RTS interactive "$(DIR)" --port=$(PORT) --auto-sources

# cleans up the graph images from interactive mode
# (necessary to prevent disk space issues)
clean:
	@rm /tmp/tamarin-prover-cache-$(USER)/img/*