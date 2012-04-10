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

-- L'entité qui permet de relier toutes les unités de logique
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
   
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Zero: OUT STD_LOGIC;
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
  ); 
END DataPath;
  
ARCHITECTURE DataPathArchitecture OF DataPath IS
-- Signals 32 bits pour les connexions inter composantes 
SIGNAL s_SignExImm, s_Result, s_MUXOut, s_SrcA, s_SrcB, s_Instr: STD_LOGIC_VECTOR (31 DOWNTO 0);
-- Signals 1 bit pour les connections intercomposantes
SIGNAL s_ZeroAndPCSrc, s_Zero, s_PCSrc, s_NotConnected: STD_LOGIC;
 
BEGIN  
  -- Port map pour connecter la logique du program counter 
  LogiquePC: ProgramCounter PORT MAP(    
    Instr => Instruction(25 downto 0),
    Clock => Clock,
    Reset => Reset,
    PCSrc => PCSrc , 
    Jump => Jump,
    SignImm => s_SignExImm,
    PC => PC
  );
  
  
  -- Port map pour connecter la logique pour le bank de registres
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
  
  -- Port map pour connecter la logique arithmétique
  ALU : alu_32 PORT MAP(
   SrcA => s_SrcA,
   SrcB => s_SrcB,
   ALUControl_32  => ALUControl,
   c_out => s_NotConnected,
   Result_32 => s_Result,
   zero => Zero
  ); 
  
  -- Port map pour connecter le mutiplexeur qui selecte quel information sera ecrite au registre
  DataMUX : MUX21Generic
  GENERIC MAP( Mux_Size => 32)
  PORT MAP(
    MUXInput0 => s_Result, 
    MUXInput1 => Data, 
    MUXSel  => MemToReg, 
    MUXOutput => s_MUXOut
  );
  
  -- Connexion de la sortie au signal entre le mux et l'ALU
  Result <= s_Result;
  
END DataPathArchitecture;