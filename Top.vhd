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

-- L'entité qui est le niveau le plus haut qui inclus la mémoire d'instructions et la mémoire de donnée.
ENTITY Top IS
  PORT (Reset, Clock: IN STD_LOGIC;
        MemRead, MemWrite: OUT STD_LOGIC;
        PC, WriteData, DataAddr: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END Top;

ARCHITECTURE TOPArchitechture OF Top is 
-- Signaux pour les connexions inter composantes.
SIGNAL s_ImemToMIPS, s_WriteData, s_DataAddr, s_ReadData, s_PC :STD_LOGIC_VECTOR (31 DOWNTO 0) := x"00000000";
SIGNAL s_MemRead, s_MemWrite : STD_LOGIC;

BEGIN

-- Port map du processeur MIPS interconnecté avec les signaux internes.
portAssignMIPS : MIPS PORT MAP(
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
 
 -- Port map de la mémoire d'intruction interconnecté avec les signaux internes. 
 port_assign_IMEM : IMEM PORT MAP(
   aa => s_PC (7 DOWNTO 2),
   rd => s_ImemToMIPS
 );
 
 -- Port map pour la memoire du data interconnecté avec les signaux interne.
 port_assign_DMEM: DMEM PORT MAP (
   clk =>Clock,
   MemWrite =>s_MemWrite,
   MemRead =>s_MemRead,
   a =>s_DataAddr,
   WriteData =>s_WriteData,
   ReadData =>s_ReadData
);

-- Connections entre les signaux internes et les sorties.
PC <= s_PC;
WriteData <= s_WriteData;
DataAddr <= s_DataAddr;
MemRead <= s_MemRead;
MemWrite <= s_MemWrite;

END TOPArchitechture ; 




