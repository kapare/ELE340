--========================= LogicRegister.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: LogicRegister        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;

ENTITY LogicRegister IS 
PORT (
  RegWrite, ALUSrc, Clock, RegDst: IN STD_LOGIC;
  Instr25_21, Instr20_16, Instr15_11: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
  Instr15_0: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
  Result: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
  SrcA, SrcB, rd2, SignExtend: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
); END LogicRegister ;

ARCHITECTURE LogicRegisterArchitecture OF LogicRegister IS
BEGIN
  --PROCESS ()
    --BEGIN  
    -- SignExtend logic + MUX + Banc registre
      --END CASE;
  --END PROCESS;  
END LogicRegisterArchitecture;