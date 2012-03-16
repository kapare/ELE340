--========================= DataPath.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: DataPath        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;

ENTITY DataPath IS
  PORT (
    Clock: IN STD_LOGIC;
    Reset: IN STD_LOGIC;
    --MemToReg: IN STD_LOGIC;
    --PCSrc: IN STD_LOGIC;
    --AluSrc: IN STD_LOGIC;
    --RegDst: IN STD_LOGIC;
    --RegWrite: IN STD_LOGIC;
    --Jump: IN STD_LOGIC;
    BitsControl: IN STD_LOGIC;--STD_LOGIC_VECTOR (3 DOWNTO 0);  --@@@ combien de bits???
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Zero: OUT STD_LOGIC;
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
  ); 
END DataPath;
  
  
  
ARCHITECTURE DataPathArchitecture OF DataPath IS
  SIGNAL s_Result, MUXOut : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN  
  
 -- LogiquePC: PC PORT MAP(    
 -- );
  
--  LogiqueRegistre :  LogicRegister PORT MAP (
--  );
  
--  ALU : alu_32 PORT MAP(
-- ); 
  
  
--DataMUX : MUX21Generic PORT MAP(
-- MUXInput0 => Data  , 
-- MUXInput1 => s_Result  ,  
-- MUXSel  => BitsControl  , 
-- MUXOutput =>   MUXOut
--);
  
  
  Result <= s_Result;
  
  
  
  
END DataPathArchitecture;