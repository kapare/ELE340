--========================= MIPSPackage.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: MIPSPackage        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
  
PACKAGE MIPSPackage IS

COMPONENT MainDecoder IS
  PORT (
    OPCode: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump: OUT STD_LOGIC;
    ALUOperation: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
  ); 
END COMPONENT;

COMPONENT ALUDecoder IS 
  PORT (
    Funct: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    ALUOperation: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    ALUControl: OUT STD_LOGIC_VECTOR (3 DOWNTO 0) 
  ); 
END COMPONENT;

COMPONENT MUX21_5 IS
  GENERIC ( Mux_Size : integer := 5 );
  PORT ( 
    MUXInput0, MUXInput1: IN STD_LOGIC_VECTOR (Mux_Size DOWNTO 0);
    MUXSel: IN STD_LOGIC;
    MUXOutput: OUT STD_LOGIC_VECTOR (Mux_Size DOWNTO 0)	
  );
END COMPONENT;

COMPONENT MUX21_32 IS
  GENERIC ( Mux_Size : integer := 32 );
  PORT ( 
    MUXInput0, MUXInput1: IN STD_LOGIC_VECTOR (Mux_Size DOWNTO 0);
    MUXSel: IN STD_LOGIC;
    MUXOutput: OUT STD_LOGIC_VECTOR (Mux_Size DOWNTO 0)	
  );
END COMPONENT;

END PACKAGE;