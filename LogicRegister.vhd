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
USE WORK.MIPSPackage.ALL;

ENTITY LogicRegister IS 
PORT (
  RegWrite, ALUSrc, Clock, RegDst: IN STD_LOGIC;
  Instr25_21, Instr20_16, Instr15_11: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
  Instr15_0: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
  Result: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
  SrcA, SrcB, rd2, SignExtend: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
); END LogicRegister ;

ARCHITECTURE LogicRegisterArchitecture OF LogicRegister IS
  SIGNAL s_WriteReg: STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL s_SignImm, s_rd2: STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
  
  MUXInput: MUX21_5 PORT MAP( 
  MUXInput0 => Instr20_16,
  MUXInput1 => Instr15_11,
  MUXSel => RegDst,
  MUXOutput => s_WriteReg
  );  
  
  MUXOutput: MUX21_32 PORT MAP( 
  MUXInput0 => s_rd2,
  MUXInput1 => s_SignImm,
  MUXSel => ALUSrc,
  MUXOutput => SrcB
  );
  
  -- Sign Extend 0 TO 15 bits
  SignExtendFOR_0_15: FOR idx IN 0 TO 15 GENERATE
    s_SignImm(idx) <= Instr15_0(idx);
  END GENERATE SignExtendFOR_0_15;
  
  -- Sign Extend 16 TO 31 bits
  SignExtendFOR_16_32: FOR idx IN 15 TO 31 GENERATE
    s_SignImm(idx) <= Instr15_0(15);
  END GENERATE SignExtendFOR_16_32;
  
  -- Sign Extend output
  SignExtend <= s_SignImm;
  
END LogicRegisterArchitecture;