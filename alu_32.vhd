--================ alu_32.vhd =================================
-- ELE-340 Conception des systèmes ordinés
-- ETE 2007, Ecole de technologie supérieure
-- Chakib Tadj
-- =============================================================
-- Description: 
--	alu_32 realise une ALU 32-bit
--	En faisant appel a ALU 1-bit
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;
USE WORK.mipspackage.ALL;

ENTITY alu_32 IS 
  
   GENERIC (ALU_SIZE: integer := 31); 
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
   ALUControl_32 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
   c_out: OUT STD_LOGIC;
   Result_32: OUT STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
   zero: OUT std_logic
); END alu_32 ;

ARCHITECTURE alu_32_archi OF alu_32 IS
  
-- Signaux representant les 32 carry out.
SIGNAL s_c_out : STD_LOGIC_VECTOR ((ALU_SIZE + 1) DOWNTO 0);
-- Signaux representant les 32 resultat de chaque ALU 1 bit.
SIGNAL s_result : STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0) := (others =>'0');     
-- Signaux representant les 32 set de chaque ALU 1 bit.
SIGNAL s_set : STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
-- Signaux representant les 32 less de chaque ALU 1 bit.
SIGNAL s_less: STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
-- Signaux representant les 32 zero de chaque ALU 1 bit.
SIGNAL s_zero : STD_LOGIC_vector (ALU_SIZE DOWNTO 0) := X"00000000";

BEGIN

-- Port map pour toutes les connexions entre chaque composant ALU de 1 bit.
port_assign_alu : FOR i IN 0 TO (ALU_SIZE) generate
  ALU : alu_1 PORT MAP( 
  alu_a => SrcA(i),
  alu_b => SrcB(i),
  alu_c_in => s_c_out(i),
  alu_c_out => s_c_out(i+1),
  less => s_less(i),
  set => s_set(i),
  ALUControl => ALUcontrol_32,
  result => s_result(i)
  );
END GENERATE port_assign_alu;

-- Processus pour gerer les boucles pour les assignations des vector less et zero.

    ZEROFOR : FOR z IN 1 TO (ALU_SIZE) generate
      s_zero(z) <= (s_result(z) OR s_zero(z-1));  
    end generate ZEROFOR;
    zero <= NOT s_zero(ALU_SIZE); 

-- Assignation des connexions uniques.
s_less(0) <= s_set(31);
result_32 <=s_result;
s_less (31 downto 1) <= "0000000000000000000000000000000";

-- premier c_in connecté a b_inv
s_c_out(0) <= ALUcontrol_32(2);

c_out <= s_c_out(32);


END alu_32_archi;
