--========================= RegisterBank.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Jonathan Riel-Landry, Kevyn-Alexandre Pare, Sean Beitz
-- =============================================================
-- Description: RegisterBank        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
--USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;
USE WORK.MIPSPackage.ALL;

ENTITY RegisterBank IS
  PORT (
    ra1, ra2, wa3: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    wd3: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    RegWrite, Clock: IN STD_LOGIC;
    rd1, rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)--TODO Clock Signal
  ); 
END RegisterBank;

ARCHITECTURE RegisterBankArchitecture OF RegisterBank IS
  
-- Initialisation de nos 32 registres de 32 bits (32 * 32 = 1024).
CONSTANT VECTOR_WIDTH: INTEGER := 1024;
CONSTANT ELEMENT_SIZE: INTEGER := 32;
CONSTANT ARRAY_ELEMENT_WIDTH: INTEGER := 32;

SIGNAL s_RegisterMemory: STD_LOGIC_VECTOR((VECTOR_WIDTH - 1) DOWNTO 0) :=  (others =>'0');
SIGNAL s_TempValue1, s_TempValue2 : INTEGER;
BEGIN

  PROCESS (Clock)
  BEGIN  

    IF (Rising_Edge(Clock))  THEN
      IF (RegWrite = '1') THEN
        s_TempValue1 <= conv_integer(wa3);
        FOR idx IN 0 TO (ELEMENT_SIZE-1) LOOP   
          s_RegisterMemory((s_TempValue1 * (ELEMENT_SIZE)) + idx) <= wd3(idx);
        END LOOP;  
         
      END IF;
      
      s_TempValue1 <= conv_integer(ra1);
      s_TempValue2 <= conv_integer(ra2);
      FOR idx IN 0 TO (ELEMENT_SIZE-1) LOOP
        rd1(idx) <= s_RegisterMemory((s_TempValue1 * (ELEMENT_SIZE)) + idx);
        rd2(idx) <= s_RegisterMemory((s_TempValue2 * (ELEMENT_SIZE)) + idx);
      END LOOP;
   END IF;
  END PROCESS;

END RegisterBankArchitecture;