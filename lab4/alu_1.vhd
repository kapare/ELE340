--================ alu_1.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- Chakib Tadj
-- =============================================================
-- Description: alu_1 realise une ALU 1-bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE WORK.mipspackage.all; 

ENTITY alu_1 IS 
  PORT (alu_a, alu_b, alu_c_in, less : IN STD_LOGIC;
        ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
        alu_c_out, result, set: OUT STD_LOGIC); 
END alu_1;

ARCHITECTURE alu_1_archi OF alu_1 IS
-- Signaux sont nommés en fonction de leur tâches et leur destination 
SIGNAL or_mux, and_mux, add_mux, muxa_out, muxb_out : STD_LOGIC;
SIGNAL not_alu_a : STD_LOGIC;
SIGNAL not_alu_b : STD_LOGIC;

BEGIN
  -- MUX 4:1 pour la sortie result 
  mu4 : mux4_1 PORT MAP(
  m4_i0 => and_mux,
  m4_i1 => or_mux,
  m4_i2 => add_mux,
  m4_i3 => less,
  m4_sel(1) => ALUControl(1),
  m4_sel(0) => ALUControl(0),
  m4_q => result
  ) ;

  -- MUX 2:1 pour l'entrée a
  mu2a : mux2_1 PORT MAP(
  m2_i0 => alu_a,
  m2_i1 => not_alu_a,
  m2_sel => ALUControl(3),
  m2_q => muxa_out
  );

  -- MUX 2:1 pour l'entrée b
  mu2b : mux2_1 PORT MAP(
  m2_i0 => alu_b,
  m2_i1 => not_alu_b,
  m2_sel => ALUControl(2),
  m2_q => muxb_out
  );

  -- Le composant module additionneur 
  add : full_adder PORT MAP(
  a => muxa_out, 
  b => muxb_out, 
  c_in => alu_c_in,
  sum => add_mux, 
  c_out => alu_c_out
  );

  -- Inverseur pour l'entrée A et B de alu 1.
  not_alu_a <= not alu_a;
  not_alu_b <= not alu_b;

  -- Logique intercomposante pour le AND et le OR.
  and_mux <= (muxa_out and muxb_out);
  or_mux <= (muxa_out or muxb_out);

  -- Logique de connection pour la sortie set.
  set <= add_mux;

END alu_1_archi;






