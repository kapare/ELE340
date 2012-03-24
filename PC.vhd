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

ENTITY PC1 IS
   PORT (
        Instr : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
        Clock, Reset, PCSrc, Jump : IN STD_LOGIC;
        SignImm : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END PC1;
   
ARCHITECTURE PCArchitechture OF PC1 is
SIGNAL s_SignImmSh2 :  STD_LOGIC_VECTOR (33 DOWNTO 0);
SIGNAL s_SignImmSh, s_PcNext, s_BascOut, s_PCNextbr, s_PcPlus4, s_PCBranch, s_PCJump: STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL s_plus4 :  STD_LOGIC_VECTOR (31 DOWNTO 0):= "00000000000000000000000000000100";
SIGNAL s_Instr_sl2 :  STD_LOGIC_VECTOR (27 DOWNTO 0);
SIGNAL s_NotConnected : STD_LOGIC_VECTOR (31 DOWNTO 0):= "00000000000000000000000000000000";

SIGNAL test : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL test2 : STD_LOGIC_VECTOR (7 DOWNTO 0);
CONSTANT value : integer := 1;

BEGIN

   
--component mux x 2--

port_assign_mux_add : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
 MUXInput0 => s_PcPlus4  , 
 MUXInput1 => s_PCBranch  ,  
 MUXSel  => PCSrc  , 
 MUXOutput =>   s_PCNextbr
 );

port_assign_mux_pcnext : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
 MUXInput0 =>  s_PCJump , 
 MUXInput1 =>  s_PCNextbr ,  
 MUXSel  =>   Jump, 
 MUXOutput => s_PcNext   
);


--component adders x 2

add_plus4 : full_adder_32 PORT MAP(
a => s_BascOut, 
b => s_plus4, 
c_in => s_NotConnected,
sum => s_PcPlus4, 
c_out => s_NotConnected
);


add_PC_SignImm : full_adder_32 PORT MAP(
a => s_PcPlus4, 
b => s_SignImmSh, 
c_in => s_NotConnected,
sum => s_PCBranch, 
c_out =>s_NotConnected 
);


--component bascules x 1
bascule : DFlipFlop PORT MAP (
  
  D =>  s_PcNext, 
  Clock =>  Clock, 
  Reset =>  Reset,
  Q =>  s_BascOut
  
);






s_PCJump <=  s_PcPlus4(31 downto 28) & (Instr & "00");
s_SignImmSh2 <= SignImm & "00";
s_SignImmSh <= s_SignImmSh2(31 DOWNTO 0);
PC <= s_BascOut;


END PCArchitechture;








