LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;


--nous avons changé les noms des variables pour éviter toutes ambiguités
ENTITY mux2_1 IS
  PORT (
  m2_i0, m2_i1, m2_sel : IN STD_LOGIC;
    m2_q : OUT STD_LOGIC	
  );
  END mux2_1;
  
  ARCHITECTURE mux2_1_arch of mux2_1 IS
  BEGIN
    --Formule generique d'un multiplexeur 2 entrées à 1 sortie: Y = BC + AC' 
    m2_q <= (m2_i1 and m2_sel) or (m2_i0 and (not m2_sel)); 
  
  END mux2_1_arch; 