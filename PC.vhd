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

ENTITY PC IS
   PORT (
        Instr : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
        Clock, Reset, PCSrc, Jump : IN STD_LOGIC;
        SignImm : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END PC;
   
ARCHITECTURE PCArchitechture OF PC is

SIGNAL s_SignImm_sl2, s_PcNext, s_BascOut, s_MuxAddOut, s_PcPlus4, s_PCBranch: STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL s_plus4 :  STD_LOGIC_VECTOR (31 DOWNTO 0):= "00000000000000000000000000000100";
SIGNAL s_Instr_sl2 :  STD_LOGIC_VECTOR (27 DOWNTO 0);
SIGNAL s_NotConnected : STD_LOGIC_VECTOR (31 DOWNTO 0):= "00000000000000000000000000000000";


BEGIN
--component mux x 2

--port_assign_mux_add : mux2_1 PORT MAP(
 --m2_i0 =>   , 
 --m2_i1 =>   ,  
 --m2_sel  => PCSrc  , 
 --m2_q =>   s_MuxAddOut
  
  
--);

--port_assign_mux_pcnext : mux2_1 PORT MAP(
 --m2_i0 =>   , 
 --m2_i1 =>   ,  --which one is activated by `1`?
-- m2_sel  =>   Jump, 
-- m2_q => s_PcNext 
  
  
--);


--component adders x 2

--add_plus4 : full_adder_32 PORT MAP(
--a => s_BascOut, 
--b => s_plus4, 
--c_in => s_NotConnected,
--sum => s_PcPlus4, 
--c_out => s_NotConnected
--);


--add_PC_SignImm : full_adder_32 PORT MAP(
--a => s_PcPlus4, 
--b => s_SignImm_sl2, 
--c_in => s_NotConnected,
--sum => s_PCBranch, 
--c_out =>s_NotConnected 
--);


--component bascules x 1
--bascule : DFlipFlop PORT MAP (
--  
--  D =>  s_PcNext, 
--  Clock =>  Clock, 
--  Reset =>  Reset,
--  Q =>  s_BascOut
--  
--);




--lines of code for  &

--lines of code for sl x 2

--lines for the other interconnections

PC <= s_BascOut;


END PCArchitechture;








