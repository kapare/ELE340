vsim Top
add wave -h *


force clock  1,0 15ns -r 30ns
force reset 1  
run 200ns
force reset 0
run 1000ns 
