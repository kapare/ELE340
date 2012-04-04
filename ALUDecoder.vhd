--========================= ALUDecoder.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: ALUDecoder        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;

-- cette entité permet de 
ENTITY ALUDecoder IS 
PORT (
  Funct: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
  ALUOperation: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
  ALUControl: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
); END ALUDecoder ;

ARCHITECTURE ALUDecoderArchitecture OF ALUDecoder IS
BEGIN
  
  PROCESS (ALUOperation, Funct)
    BEGIN  
      -- Analyseur du OPCode et assignation des valeurs de control. 
      -- ceci va determiner l'operation fait dans le module ALU
      CASE ALUOperation IS
        WHEN "00" => ALUControl <= "0010";
        WHEN "01" => ALUControl <= "0110";
        WHEN "10" => 
          
          --quand il y a une valeur de 10 à ALUoperation, faire le procédé suivant pour la valeur de funct
          --ceci va aussi determiner l'operation fait dans le module ALU
          CASE Funct IS
            WHEN "100000" => ALUControl <= "0010";
            WHEN "100010" => ALUControl <= "0110"; 
            WHEN "100100" => ALUControl <= "0000"; 
            WHEN "100101" => ALUControl <= "0001";
            WHEN "101010" => ALUControl <= "0111";
            WHEN OTHERS => ALUControl <= "1111";
          END CASE;   
        
        WHEN OTHERS => ALUControl <= "1111";
      END CASE;
  END PROCESS;  
  
END ALUDecoderArchitecture;