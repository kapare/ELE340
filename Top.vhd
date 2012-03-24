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


ENTITY Top IS
   PORT (
        Reset, Clock : IN STD_LOGIC;
        MemRead, MemWrite: OUT STD_LOGIC;
        PC, WriteData, DataAddr : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END Top;

ARCHITECTURE TOPArchitechture OF Top is 

SIGNAL s_ImemToMIPS, s_WriteData, s_DataAddr, s_ReadData, s_PC :STD_LOGIC_VECTOR (31 DOWNTO 0); 
SIGNAL s_MemRead, s_MemWrite : STD_LOGIC;

BEGIN


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
 
 
 port_assign_IMEM : IMEM PORT MAP(
   aa => s_PC (31 DOWNTO 26),
   rd => s_ImemToMIPS
 );
 
 port_assign_DMEM: DMEM PORT MAP (
   clk =>Clock,
   MemWrite =>s_MemWrite,
   MemRead =>s_MemRead,
   a =>s_DataAddr,
   WriteData =>s_WriteData,
   ReadData =>s_ReadData
);

PC <= s_PC;
WriteData <= s_WriteData;
DataAddr <= s_DataAddr;
MemRead <= s_MemRead;
MemWrite <= s_MemWrite;

END TOPArchitechture ; 




