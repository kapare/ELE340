 --========================= Controller.vhd ============================
-- ELE-340 Conception des syst�mes ordin�s
-- HIVER 2010, Ecole de technologie sup�rieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: Controller        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
USE WORK.MIPSPackage.ALL;

-- L'entit� qui va determiner les instructions qui seront envoyer au modules individuels
ENTITY Controller IS
  PORT (OPCodeController, FunctController: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
        Zero: IN STD_LOGIC;
        PCSrc, MemToRegController, MemReadController, MemWriteController, 
        ALUSrcController, RegDstController, RegWriteController, 
        JumpController: OUT STD_LOGIC;
        ALUControlController: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)); 
END Controller;

ARCHITECTURE ControllerArchitecture OF Controller IS 
-- Signaux pour les interconnections entre module
SIGNAL s_ALUOperation: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL s_Branch: STD_LOGIC;

BEGIN
  -- Connexion entre les pins du MainDecoder et les signaux du controller.
  MD: MainDecoder PORT MAP( 
    OPCode => OPCodeController,
    MemToReg => MemToRegController,
    MemRead => MemReadController,
    MemWrite => MemWriteController,
    Branch => s_Branch,
    ALUSrc => ALUSrcController,
    RegDst => RegDstController,
    RegWrite => RegWriteController,
    Jump => JumpController,
    ALUOperation => s_ALUOperation
  );

  -- Connexion entre les pins du ALUDecoder et les signaux du controller.
  ALUD: ALUDecoder PORT MAP( 
    Funct => FunctController,
    ALUOperation => s_ALUOperation,
    ALUControl => ALUControlController
  );
  
  -- Operation AND logique utilis� dans la commnande branch
  PCSrc <= Zero AND s_Branch;  
  
END ControllerArchitecture;