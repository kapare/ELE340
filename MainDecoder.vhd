--========================= MainDecoder.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: MainDecoder        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;

ENTITY MainDecoder IS
  PORT (
    OPCode: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump: OUT STD_LOGIC;
    ALUOperation: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
  ); 
END MainDecoder;

ARCHITECTURE MainDecoderArchitecture OF MainDecoder IS
  -- Signaux représentant tout les valeurs de control en output.
  SIGNAL s_Control: STD_LOGIC_VECTOR (11 DOWNTO 0);

BEGIN
  
  PROCESS (OPCode)
    BEGIN  
      -- Analyseur du OPCode et assignation des valeurs de control. 
      CASE OPCode IS
        WHEN "000000" => s_Control <= X"304";
        WHEN "100011" => s_Control <= X"2A8";
        WHEN "101011" => s_Control <= X"090";
        WHEN "000100" => s_Control <= X"042";
        WHEN "001000" => s_Control <= X"280";
        WHEN "000010" => s_Control <= X"001";
        WHEN OTHERS => s_Control <= X"000";
      END CASE;
  END PROCESS;  
  
  -- Assignation de chaque signaux avec sa valeur de sortie.
  Jump <= s_Control(0);
  ALUOperation(0) <= s_Control(1);
  ALUOperation(1) <= s_Control(2);
  MemToReg <= s_Control(3);
  MemWrite <= s_Control(4);
  MemRead <= s_Control(5);
  Branch <= s_Control(6);
  ALUSrc <= s_Control(7);
  RegDst <= s_Control(8);
  RegWrite <= s_Control(9);      
  
END MainDecoderArchitecture;