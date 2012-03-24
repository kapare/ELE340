LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE WORK.mipspackage.ALL;

ENTITY mux4_1 IS
 PORT(
    m4_i0, m4_i1, m4_i2, m4_i3: IN std_logic;
    m4_sel: IN std_logic_vector(1 downto 0) ;
    m4_q : OUT std_logic);
END mux4_1;

ARCHITECTURE mux4_1_arch of mux4_1 IS
  
--signals du mux de 1 a 3 et du mux de 2 a 3 (dans le schema bloc)
signal mux1_3, mux2_3  : STD_LOGIC; 

BEGIN
-- trois portmaps sepraré pour les trois mux 2:1 du schéma bloc du mux 4:1
mux1 : mux2_1 port map(
  m2_i0 =>  m4_i0, 
  m2_i1 =>    m4_i1,
  m2_sel =>  m4_sel(0),
  m2_q => mux1_3
);

mux2 : mux2_1 port map(
  m2_i0 =>    m4_i2,
  m2_i1 =>    m4_i3,
  m2_sel =>  m4_sel(0),
  m2_q =>  mux2_3
 );

mux3 : mux2_1 port map(
  m2_i0 =>   mux1_3  ,
  m2_i1 =>    mux2_3 ,
  m2_sel =>  m4_sel(1),
  m2_q => m4_q
);

  
  --aucun code a écrire ici car toute les fonctions arithmetiques sont ecrite dans mux2_1
  
  
END mux4_1_arch; 
