vsim Cunit

add wave -h *

force clk 1,0 10ns -r 20ns
force Reset 1
run 20ns
force Reset 0
run 20ns



#------test de Sub------#

force OP	000000
force Funct 100010
force Zero 0

run 80ns

#------test de Add------#

force OP	000000
force Funct 100000
force Zero 0

run 80ns

#------test de ADDI------#

force OP	001000
#force Funct  
force Zero 0

run 80ns


#------test de Jump------#

force OP	000010
#force Funct 
force Zero 0

run 60ns

#------test de Beq------#

force OP	000100
#force Funct 
force Zero 0

run 60ns

#------test de LW------#

force OP	100011
#force Funct 
force Zero 1

run 100ns


#------test de SW------#

force OP	101011
#force Funct 
force Zero 0

run 80ns


#------test de Slt------#

force OP	000000
force Funct 101010
force Zero 0

run 80ns







