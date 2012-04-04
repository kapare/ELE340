--========================= DFlipFlop.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: DFlipFlop      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- entité de la bascule D a 32 bits
ENTITY DFlipFlop IS
  PORT(
       D : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
       Clock, Reset : IN  STD_LOGIC;
       Q        : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
       );
END DFlipFlop;

ARCHITECTURE DFlipFlopArchitecture OF DFlipFlop IS
BEGIN

-- la logique doit etre séquentielle donc elle est placé dans un process actifs sur le front montant de l'horloge
  PROCESS(Clock, Reset)
  BEGIN
    -- quand reset est vrai et il y a un front montant sur l'horloge, la sortie est remise a 0	
    IF (RISING_EDGE(clock) and (Reset = '1')) then
	    Q <= X"00000000";
	-- autrement, la sortie est égal a l'entrée quand il y a un front montant de l'horloge	
    ELSIF (RISING_EDGE(clock)) THEN
      Q <= D;
    end if;
  end process;

END DFlipFlopArchitecture;