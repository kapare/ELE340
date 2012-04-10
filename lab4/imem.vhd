--========================= imem.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Chakib Tadj, Vincent Trudel-Lapierre
-- =============================================================
-- Description: imem        
-- =============================================================

library ieee;
library std;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_UNSIGNED.all; --for conv_integer
use ieee.std_logic_ARITH.all;


entity imem is --single cycle MIPS processor
PORT (aa: in std_logic_vector(5 downto 0);
   rd: out std_logic_vector(31 downto 0));
end; -- imem;

architecture imem_arch of imem is

  constant TAILLE_ROM : positive :=17; -- taille de la rom
  type romtype is array ( 0 to TAILLE_ROM) of std_logic_vector(31 downto 0);
  
  constant Rom : romtype := (
  
    0  => x"20020005", 
	1  => x"2003000C",
	2  => x"2067FFF7",
	3  => x"00E22025",
	4  => x"00642824",
	5  => x"00A42820",
	6  => x"10A7000A",
	7  => x"0064202A",
	8  => x"10800001",
	9  => x"20050000",
	10  => x"00E2202A",
	11  => x"00853820",
	12  => x"00E23822",
	13  => x"AC670044",
	14  => x"8C020050",
	15  => x"08000011",
	16  => x"20020001",
	17  => x"AC020054");
	
	
begin
   process (aa)
   begin
   
	rd <= Rom(conv_integer(aa));

  end process; 

end imem_arch;

