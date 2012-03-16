--================ full_adder.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- =============================================================
-- Description: additionneur 1 bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY full_adder_32 IS 		
PORT (
  a, b, c_in : IN STD_LOGIC_VECTOR (31 downto 0);
  sum, c_out : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END full_adder_32;

ARCHITECTURE full_adder_archi OF full_adder_32 IS 
BEGIN
  c_out <= (a AND b) or (c_in AND(a XOR b));
  sum <= a XOR b XOR c_in;
END full_adder_archi;