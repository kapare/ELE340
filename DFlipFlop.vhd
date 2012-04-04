--========================= DFlipFlop.vhd ============================
-- ELE-340 Conception des syst�mes ordin�s
-- HIVER 2010, Ecole de technologie sup�rieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: DFlipFlop      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Entit� de la bascule D a 32 bits
ENTITY DFlipFlop IS
  PORT(D: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
       Clock, Reset: IN  STD_LOGIC;
       Q: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END DFlipFlop;

ARCHITECTURE DFlipFlopArchitecture OF DFlipFlop IS
BEGIN

  -- La logique doit etre s�quentielle donc elle est plac�e dans un process actifs sur le front montant de l'horloge
  PROCESS(Clock, Reset)
  BEGIN
    -- Quand reset est vrai et il y a un front montant sur l'horloge, la sortie est remise a 0	
    IF (RISING_EDGE(clock) and (Reset = '1')) then
      Q <= X"00000000";
      -- Autrement, la sortie est �gal a l'entr�e quand il y a un front montant de l'horloge	
    ELSIF (RISING_EDGE(clock)) THEN
      Q <= D;
    end if;
  end process;

END DFlipFlopArchitecture;