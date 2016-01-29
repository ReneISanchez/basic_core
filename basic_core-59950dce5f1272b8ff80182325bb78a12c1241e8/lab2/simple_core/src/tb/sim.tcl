# TODO: Fill this out.
# Load simulation
vsim work.simple_core_tb

#                       Group Name                  Radix               Signal(s)
#add wave    -noupdate   -group {core_tb}            -radix hexadecimal  /core_tb/*
add wave    -noupdate   -group {simple_core}         -radix hexadecimal  /dut/*

# Use short names
configure wave -signalnamewidth 1