--================ mypackage.vhd ===============================
-- Description: 
--	mypackage est utile pour la declaration des components
-- Utilisation:
--	1: compiler mypackage.vhd
--	2: le declarer dans tous les fichiers vhdl
---	   avec: USE WORK.mypackage.ALL;
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
  
package mypackage is

COMPONENT full_adder 
PORT (
   a, b, c_in: IN STD_LOGIC;
   sum, c_out: OUT STD_LOGIC
); 
end COMPONENT;

COMPONENT mux4_1
PORT ( m4_i0, m4_i1, m4_i2, m4_i3: IN std_logic;
    m4_sel: IN std_logic_vector(1 downto 0) ;
    m4_q : OUT std_logic);
END COMPONENT;

COMPONENT mux2_1
PORT ( m2_i0, m2_i1, m2_sel : IN std_logic;
    m2_q : OUT std_logic);
end COMPONENT;

COMPONENT alu_1 
PORT (
   alu_a, alu_b, alu_c_in, less : IN STD_LOGIC;
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   alu_c_out, result, set: OUT STD_LOGIC
); END COMPONENT;

COMPONENT alu_32                      --déclaration du composant utilisé
GENERIC (ALU_SIZE: integer := 31); -- Il suffit de chager la valeur 31 a celle de la taille de lALU desiree!
PORT (
  SrcA, SrcB: in std_logic_vector(ALU_SIZE downto 0);
  ALUControl : in std_logic_vector (3 downto 0);
  c_out: out std_logic;
  Result:out std_logic_vector (ALU_SIZE downto 0);
  zero: out std_logic
); END COMPONENT ;

end mypackage;