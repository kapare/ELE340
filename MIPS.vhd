--========================= MIPS.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: MIPS Block        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;
USE WORK.MIPSPackage.ALL;

ENTITY MIPS IS
  PORT (
    Clock: IN STD_LOGIC;
    Reset: IN STD_LOGIC;
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    MemWrite, MemRead: OUT STD_LOGIC
  ); 
END MIPS;
   
ARCHITECTURE MIPSArchitecture OF MIPS IS
  SIGNAL s_ALUControl : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL s_MemToReg, s_ALUSrc, s_RegDst, s_RegWrite, s_Jump, s_Zero, s_PCSrc : STD_LOGIC;
  
  BEGIN
 

  --ASSIGN SIGNALS AND VARIOUS
  ControllerPortMap : Controller PORT MAP( 
    
    OPCodeController => Instruction(31 downto 26), 
    FunctController =>  Instruction(5 downto 0), 
    Zero => s_Zero,
    PCSrc => s_PCSrc,
    MemToRegController => s_MemToReg,
    MemReadController => MemRead,
    MemWriteController => MemWrite,
    ALUSrcController => s_ALUSrc,
    RegDstController => s_RegDst,
    RegWriteController => s_RegWrite,
    JumpController => s_Jump,
    ALUControlController => s_ALUControl
  );
    
    DataPathPortMap: DataPath PORT MAP(
  
    Clock => Clock,
    Reset => Reset,
    MemToReg => s_MemToReg,
    PCSrc => s_PCSrc,
    AluSrc => s_ALUSrc,
    RegDst => s_RegDst,
    RegWrite => s_RegWrite,
    Jump => s_Jump,
    ALUControl => s_ALUControl,
    Instruction => Instruction,
    Data => Data,
    PC => PC,
    Result => Result,
    Rd2 => Rd2,
    Zero => s_Zero
  ); 
    
END MIPSArchitecture;



