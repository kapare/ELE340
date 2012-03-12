--========================= DFlipFlop.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: DFlipFlop      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY DFlipFlop IS
  PORT(
       D : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
       Clock, Reset : IN  STD_LOGIC;
       Q        : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
       );
END DFlipFlop;

ARCHITECTURE DFlipFlopArchitecture OF DFlipFlop IS
BEGIN
  PROCESS(Clock, Reset)
  BEGIN
    IF (Reset = '1') then
	    Q <= "0000000000000000000000000000000";
    ELSIF (RISING_EDGE(clock)) THEN
      Q <= D;
    end if;
  end process;

END DFlipFlopArchitecture;