#vsim Top
#add wave -h *


#force clock  1,0 15ns -r 30ns
#force reset 1  
#run 200ns
#force reset 0
#run 100ns 


vsim LogicRegister

add wave -h *

force clock  1,0 15ns -r 30ns

force RegWrite 1
force ALUSrc 0
force RegDst 0
force Instr25_21 00001
force Instr20_16 00001
force Instr15_11 00010
force Instr15_0 1111111111111111
force Result 00000000000000000000000000000000

run 100 ns
  
force RegWrite 1
force ALUSrc 0
force RegDst 0
force Instr25_21 00001
force Instr20_16 00001
force Instr15_11 00010
force Instr15_0 0000000000000000
force Result 11000000111111111110111000000000

run 100 ns  

force RegWrite 0
force ALUSrc 0
force RegDst 0
force Instr25_21 00001
force Instr20_16 00001
force Instr15_11 00010
force Instr15_0 1111111111111111
force Result 00000000000000000000000000000000

run 100 ns

force RegWrite 0
force ALUSrc 1
force RegDst 1
force Instr25_21 00000
force Instr20_16 00000
force Instr15_11 00000
force Instr15_0 1111111111111111
force Result 00000000000000000000000000000000
  
run 200ns
