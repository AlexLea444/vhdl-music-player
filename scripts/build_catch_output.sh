# This code was stolen from Lucas Polidori. I will ask his permission at some point
PROGRAM_NAME="speaker"
echo "Building with ${PROGRAM_NAME}"

# Clean
rm *.json *.asc *.cf *.o
set -ex

# Simulate
ghdl -a --std=08 *.vhd

# Synthesize
yosys -m ghdl -p "ghdl --std=08 top; synth_ice40 -json ${PROGRAM_NAME}.json" > synth.out 2> synth.err

# Route, generate, and flash
nextpnr-ice40 --pcf-allow-unconstrained --ignore-loops --up5k --package sg48 --pcf "${PROGRAM_NAME}.pcf" --json "${PROGRAM_NAME}.json" --asc "${PROGRAM_NAME}.asc" > pnr.out 2> pnr.err
icepack "${PROGRAM_NAME}.asc" "${PROGRAM_NAME}.bin" > icepack.out 2> icepack.err
iceprog "${PROGRAM_NAME}.bin" > iceprog.out 2> iceprog.err
