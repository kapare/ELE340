--========================= ProgramCounter.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: Program Counter      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;
USE WORK.MIPSPackage.ALL;

-- L'entité de la logique du program counter:
-- pour le saut d'instruction (PC+4), le jump et le branch equal.
ENTITY ProgramCounter IS
   PORT (Instr: IN STD_LOGIC_VECTOR (25 DOWNTO 0);
        Clock, Reset, PCSrc, Jump: IN STD_LOGIC;
        SignImm: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END ProgramCounter;
   
ARCHITECTURE PCArchitechture OF ProgramCounter is
-- Signal 34 bits pour la logique de shift left du sign extend 
SIGNAL s_SignImmSh2: STD_LOGIC_VECTOR (33 DOWNTO 0);
-- Signaux 32 bits pour les connections intercomposantes.
SIGNAL s_SignImmSh, s_PcNext, s_BascOut, s_PCNextbr, s_PCBranch, s_PCJump: STD_LOGIC_VECTOR (31 DOWNTO 0) := (others =>'0');
SIGNAL s_PcPlus4: STD_LOGIC_VECTOR (31 DOWNTO 0) := (others =>'0');
-- Signal de valeur 4 pour l'addition de 4 au pc, elle aurait aussi pu etre une constante.
SIGNAL s_plus4: STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000004";
-- Signal pour la concatenation et le shift left des instructions
SIGNAL s_Instr_sl2: STD_LOGIC_VECTOR (27 DOWNTO 0);

BEGIN
-- MUX placé apres l'additionneur et controlant le saut d'instruction ou branchement. 
port_assign_mux_add : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
  MUXInput0 => s_PcPlus4, 
  MUXInput1 => s_PCBranch,  
  MUXSel  => PCSrc, 
  MUXOutput => s_PCNextbr
);

 -- MUX placé apres l'unité de concaténation et l'autre MUX controlant un jump ou le MUX précédent. 
port_assign_mux_pcnext : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
  MUXInput0 => s_PCNextbr, 
  MUXInput1 => s_PCJump,  
  MUXSel => Jump, 
  MUXOutput => s_PcNext   
);

-- Component adder 32 bits qui fait l'addition de 4 a pc 
add_plus4: full_adder_32 PORT MAP(
  a => s_BascOut, 
  b => s_plus4, 
  sum => s_PcPlus4
);

-- Component adder 32 bits qui additionne le sign extend avec pcplus4
add_PC_SignImm: full_adder_32 PORT MAP(
  a => s_PcPlus4, 
  b => s_SignImmSh, 
  sum => s_PCBranch 
);

-- Component bascules qui retient en memoire PCNext
bascule : DFlipFlop PORT MAP (
  D => s_PcNext, 
  Clock => Clock, 
  Reset => Reset,
  Q => s_BascOut
);

-- Logique de concaténation et shift left pour l'entré des instructions et le pcplus4
s_PCJump <= s_PcPlus4(31 downto 28) & (Instr & "00");

-- Logique de shift left pour le sign extend
s_SignImmSh2 <= SignImm & "00";
s_SignImmSh <= s_SignImmSh2(31 DOWNTO 0);

-- Logique de connection pour la sortie
PC <= s_BascOut;

END PCArchitechture;








