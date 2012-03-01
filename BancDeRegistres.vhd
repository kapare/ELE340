--========================= Controller.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Jonathan Riel-Landry, Kevyn-Alexandre Pare, Sean Beitz
-- =============================================================
-- Description: Banc De Registres        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
USE WORK.MIPSPackage.ALL;

ENTITY BancReg IS
  PORT (
    ra1, ra2, wa3, wd3: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    RegWrite: IN STD_LOGIC ;
    rd1, rd2: OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
  ); 
END BancReg;

ARCHITECTURE BancRegArchitecture OF BancReg IS



BEGIN
  
END BancRegArchitecture;