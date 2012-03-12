--========================= MUX21Generic.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: MUX21Generic        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY MUX21Generic IS
  GENERIC ( Mux_Size : integer := 32 );
  PORT ( 
    MUXInput0, MUXInput1: IN STD_LOGIC_VECTOR (Mux_Size DOWNTO 0);
    MUXSel: IN STD_LOGIC;
    MUXOutput: OUT STD_LOGIC_VECTOR (Mux_Size DOWNTO 0)	
  );
END MUX21Generic;
  
ARCHITECTURE MUX21GenericArchitecture OF MUX21Generic IS
BEGIN
    
  PROCESS (MUXSel)
  BEGIN  
    IF (MUXSel = '0') THEN
      MUXOutput <= MUXInput0;
    ELSE
      MUXOutput <= MUXInput1;
    END IF;
  END PROCESS;
END MUX21GenericArchitecture; 