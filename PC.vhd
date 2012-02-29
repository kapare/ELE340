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


SIGNAL s_SignImm_sl2, s_PcNext, s_BascOut, s_PcNextPlus4
SIGNAL s_Instr_sl2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
SIGNAL 

BEGIN








