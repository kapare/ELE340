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
USE WORK.MIPSPackage.ALL;



ENTITY DataPath IS
  PORT (
    Clock: IN STD_LOGIC;
    Reset: IN STD_LOGIC;
    MemToReg: IN STD_LOGIC;
    PCSrc: IN STD_LOGIC;
    AluSrc: IN STD_LOGIC;
    RegDst: IN STD_LOGIC;
    RegWrite: IN STD_LOGIC;
    Jump: IN STD_LOGIC;
    ALUControl : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    --BitsControl: IN STD_LOGIC;--STD_LOGIC_VECTOR (3 DOWNTO 0);  --@@@ combien de bits???
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Zero: OUT STD_LOGIC;
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
  ); 
END DataPath;
  
  
  
ARCHITECTURE DataPathArchitecture OF DataPath IS
  SIGNAL s_SignExImm, s_Result, s_MUXOut, s_SrcA, s_SrcB, s_Instr: STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL s_ZeroAndPCSrc, s_Zero, s_PCSrc, s_NotConnected: STD_LOGIC;
BEGIN  
  
 LogiquePC: PC1 PORT MAP(    
    Instr => Instruction(25 downto 0),
    Clock => Clock,
    Reset => Reset,
    PCSrc => PCSrc , 
    Jump => Jump,
    SignImm => s_SignExImm,
    PC => PC
  );
  
  LogiqueRegistre :  LogicRegister PORT MAP (
   RegWrite => RegWrite,
   ALUSrc  => AluSrc,
   Clock => Clock,
   RegDst => RegDst,
   Instr25_21 => Instruction(25 DOWNTO 21),
   Instr20_16 => Instruction(20 DOWNTO 16),
   Instr15_11 => Instruction(15 DOWNTO 11),
   Instr15_0 => Instruction(15 DOWNTO 0),
   Result => s_MUXOut,
   SrcA => s_SrcA,
   SrcB => s_SrcB,
   rd2 => Rd2,
   SignExtend => s_SignExImm
    
  );
  
  ALU : alu_32 PORT MAP(
   SrcA => s_SrcA,
   SrcB => s_SrcB,
   ALUControl_32  => ALUControl,
   c_out => s_NotConnected,
   Result_32 => s_Result,
   zero => Zero
 ); 
  
  
DataMUX : MUX21_GENERIC
GENERIC MAP( Mux_Size => 32)
 PORT MAP(
 MUXInput0 => Data  , 
 MUXInput1 => s_Result  ,  
 MUXSel  => MemToReg  , 
 MUXOutput =>   s_MUXOut
);
  
  
  Result <= s_Result;
 -- s_ZeroAndPCSrc <= s_Zero AND s_PCSrc;
  
  
  
END DataPathArchitecture;