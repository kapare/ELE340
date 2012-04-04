--================ full_adder_8.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- =============================================================
-- Description: additionneur ADDER_SIZE bits (par example ADDER_SIZE := 7)
-- =============================================================

LIBRARY ieee; USE ieee.std_logic_1164.all; USE ieee.std_logic_arith.all;
ENTITY full_adder_32 IS 
   GENERIC (ADDER_SIZE: integer := 31); -- Il suffit de chager la valeur 31 a 
						                            -- celle de la taille de l'ALU desiree!
PORT (a, b: IN STD_LOGIC_VECTOR (ADDER_SIZE DOWNTO 0); 
     sum : OUT STD_LOGIC_VECTOR (ADDER_SIZE DOWNTO 0)
    
     );
END full_adder_32;

ARCHITECTURE full_adder_archi OF full_adder_32 IS
  
--Signal utilisé entre les adder individuels
signal c_connect : STD_LOGIC_VECTOR (0 to (ADDER_SIZE + 1) ); 

COMPONENT full_adder PORT(
    a, b, c_in : IN STD_LOGIC;
    sum, c_out : OUT STD_LOGIC);
END COMPONENT;


BEGIN
--assignation des connections entre chaque unité du module full_adder
port_assign : for i in 0 to (ADDER_SIZE) generate
  adder : full_adder port map( 
  a => a(i),
  b => b(i),
  c_in => c_connect(i),
  c_out => c_connect(i+1),
  sum => sum(i)
  );
end generate port_assign;
  --assignation de la valeur de zero au premier "carry-in" de notre adder
  c_connect(0) <= '0'; 
  
    
    
 
END full_adder_archi;
