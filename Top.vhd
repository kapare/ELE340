--========================= Top.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: Top      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;
USE WORK.MIPSPackage.ALL;

-- l'entité du plus haut niveau qui incorpore la mémoire d'instructions et la mémoire du data
ENTITY Top IS
   PORT (
        Reset, Clock : IN STD_LOGIC;
        MemRead, MemWrite: OUT STD_LOGIC;
        PC, WriteData, DataAddr : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END Top;

ARCHITECTURE TOPArchitechture OF Top is 
-- signaux 32 bits pour les connexions inter composantes, nommé après leur fonctions
SIGNAL s_ImemToMIPS, s_WriteData, s_DataAddr, s_ReadData, s_PC :STD_LOGIC_VECTOR (31 DOWNTO 0) := x"00000000";
-- signaux 1 bit pour memread et memqrite
SIGNAL s_MemRead, s_MemWrite : STD_LOGIC;

BEGIN

-- le port map du processeur
portAssignMIPs : MIPS PORT MAP(
    Clock =>Clock,
    Reset =>Reset,
    Instruction => s_ImemToMIPS,
    Data =>s_ReadData,
    PC =>s_PC,
    Result => s_DataAddr,
    Rd2 =>s_WriteData,
    MemWrite => s_MemWrite,
    MemRead => s_MemRead
  
 );
 
 -- le port map du intruction memory 
 port_assign_IMEM : IMEM PORT MAP(
   aa => s_PC (7 DOWNTO 2),
   rd => s_ImemToMIPS
 );
 
 -- le port map pour la memoire du data
 port_assign_DMEM: DMEM PORT MAP (
   clk =>Clock,
   MemWrite =>s_MemWrite,
   MemRead =>s_MemRead,
   a =>s_DataAddr,
   WriteData =>s_WriteData,
   ReadData =>s_ReadData
);

-- les connections au sorties
PC <= s_PC;
WriteData <= s_WriteData;
DataAddr <= s_DataAddr;
MemRead <= s_MemRead;
MemWrite <= s_MemWrite;

END TOPArchitechture ; 




