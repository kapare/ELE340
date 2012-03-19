--========================= RegisterBank.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Jonathan Riel-Landry, Kevyn-Alexandre Pare, Sean Beitz
-- =============================================================
-- Description: RegisterBank        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE WORK.MIPSPackage.ALL;

ENTITY RegisterBank IS
  PORT (
    ra1, ra2, wa3: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    wd3: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    RegWrite, Clock: IN STD_LOGIC;
    rd1, rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)	
	--TODO Clock Signal
  ); 
END RegisterBank;

ARCHITECTURE RegisterBankArchitecture OF RegisterBank IS
  
-- Initialisation de nos 32 registres de 32 bits (32 * 32 = 1024).
CONSTANT VECTOR_WIDTH: INTEGER := 1024;
CONSTANT ARRAY_SIZE: INTEGER := 32;
CONSTANT ARRAY_ELEMENT_WIDTH: INTEGER := 32;

SIGNAL s_RegisterMemory: STD_LOGIC_VECTOR((VECTOR_WIDTH - 1) DOWNTO 0);
TYPE RegisterArray IS ARRAY(0 TO (ARRAY_SIZE - 1)) OF STD_LOGIC_VECTOR((ARRAY_ELEMENT_WIDTH - 1) DOWNTO 0);
SIGNAL s_RegisterArray: RegisterArray;

BEGIN
  
  ARRAY_ASSIGN_GENERIC : FOR idx IN (ARRAY_SIZE - 1) DOWNTO 0 GENERATE
    s_RegisterArray(idx) <= s_RegisterMemory((idx + 1) * (ARRAY_ELEMENT_WIDTH - 1) DOWNTO (idx * ARRAY_ELEMENT_WIDTH));
  END GENERATE ARRAY_ASSIGN_GENERIC;
  
  rd1 <= s_RegisterArray(conv_integer(ra1));
  rd2 <= s_RegisterArray(conv_integer(ra2));
  
  PROCESS (RegWrite, Clock)
  BEGIN  
    IF (Rising_Edge(Clock))  THEN
       IF (RegWrite = '1') THEN
         s_RegisterArray(conv_integer(wa3)) <= wd3;
       END IF;
   END IF;
  END PROCESS;

END RegisterBankArchitecture;
