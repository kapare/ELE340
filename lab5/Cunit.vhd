--========================= cunit.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- Automne 2008, Ecole de technologie supérieure
--
-- Description: Unité de contrôle du MIPS multicycle - CUnit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;

ENTITY Cunit IS 
PORT (clk       : in std_logic;
	Reset     : in std_logic;
	OP	       : in std_logic_vector(5 downto 0);
	Funct     : in std_logic_vector(5 downto 0);
	Zero      : in std_logic;
	Controls  : out std_logic_vector(17 downto 0);
	ALUControl: out std_logic_vector(3 downto 0);
	PCEnable  : out std_logic
 );
end Cunit;
-- ======================================================================================
architecture cunit_archi of cunit is
signal state   : std_logic_vector(3 downto 0);
signal controls_tempo: std_logic_vector(17 downto 0);

Component MainDec --Main Decoder
Port (clk, Reset, Zero: in std_logic;
  OP: in std_logic_vector(5 downto 0);
  PCEnable  : out std_logic;
  Controls: out std_logic_vector(17 downto 0);
  state: out std_logic_vector(3 downto 0)
); END component;

Component ALUDecoder --ALU Decoder
Port (
   Funct: in std_logic_vector(5 downto 0);
   ALUOperation : in std_logic_vector(1 downto 0);
   ALUControl : out std_logic_vector(3 downto 0));
END component;
-- ==================================================================

begin

  -- Assignation des bits pour la sotie Controls.
  Controls <= controls_tempo;
   
  -- Port map pour le Main decoder. 
  CUNIT_MD: MainDec PORT MAP( 
    clk => clk,
    Reset => Reset,
    Zero => Zero,   
    OP => OP,
    PCEnable => PCEnable,
    Controls => controls_tempo,
    state => state
  );
  
  -- Port map pour le ALU decoder.
  CUNIT_AD: ALUDecoder PORT MAP(    
    Funct => Funct,
    ALUOperation => controls_tempo(17 DOWNTO 16),
    ALUControl => ALUControl
  );

end cunit_archi;
