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

-- L'entité permet de decoder le Funct, ALUOp et le ALUControl. 
ENTITY ALUDecoder IS 
PORT (Funct: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
      ALUOperation: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
      ALUControl: OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ALUDecoder ;

ARCHITECTURE ALUDecoderArchitecture OF ALUDecoder IS
CONSTANT Op_Add_i_L_S_w_J: STD_LOGIC_VECTOR(3 downto 0):="0010";
CONSTANT Op_ADD          : STD_LOGIC_VECTOR(3 downto 0):="0010";
CONSTANT Op_SUB          : STD_LOGIC_VECTOR(3 downto 0):="0110";
CONSTANT Op_AND          : STD_LOGIC_VECTOR(3 downto 0):="0000";
CONSTANT Op_OR           : STD_LOGIC_VECTOR(3 downto 0):="0001";
CONSTANT Op_SLT          : STD_LOGIC_VECTOR(3 downto 0):="0111";
CONSTANT ALUOp_i_L_S_w_J : STD_LOGIC_VECTOR(1 downto 0):="00"; 
CONSTANT ALUOp_SUB       : STD_LOGIC_VECTOR(1 downto 0):="01";
CONSTANT ALUOp_FUNCT     : STD_LOGIC_VECTOR(1 downto 0):="10";
CONSTANT Funct_ADD       : STD_LOGIC_VECTOR(5 downto 0):="100000";
CONSTANT Funct_SUB       : STD_LOGIC_VECTOR(5 downto 0):="100010";
CONSTANT Funct_AND       : STD_LOGIC_VECTOR(5 downto 0):="100100";
CONSTANT Funct_OR        : STD_LOGIC_VECTOR(5 downto 0):="100101";
CONSTANT Funct_SLT       : STD_LOGIC_VECTOR(5 downto 0):="101010";

BEGIN
    
  PROCESS (ALUOperation, Funct)
    BEGIN  
      -- Analyseur du ALU operation et assignation des valeurs de control. 
      -- Ceci va determiner l'operation fait dans le module ALU
      CASE ALUOperation IS
        WHEN ALUOp_i_L_S_w_J => ALUControl <= Op_Add_i_L_S_w_J;
        WHEN ALUOp_SUB => ALUControl <= Op_SUB;
        WHEN ALUOp_FUNCT => 
          
          -- Quand il y a une valeur de 10 à ALU operation, faire le procédé suivant pour la valeur de funct
          -- Ceci va aussi determiner l'operation fait dans le module ALU
          CASE Funct IS
            WHEN Funct_ADD => ALUControl <= Op_ADD;
            WHEN Funct_SUB => ALUControl <= Op_SUB; 
            WHEN Funct_AND => ALUControl <= Op_AND; 
            WHEN Funct_OR => ALUControl <= Op_OR;
            WHEN Funct_SLT => ALUControl <= Op_SLT;
            WHEN OTHERS => ALUControl <=(OTHERS=>'0');
          END CASE;   
        
        WHEN OTHERS => ALUControl <= (OTHERS=>'0');
      END CASE;
  END PROCESS;  
  
END ALUDecoderArchitecture;