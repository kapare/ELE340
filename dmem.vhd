--========================= dmem.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- hiver 2010, Ecole de technologie supérieure
--Auteur: Chakib Tadj, Vincent Normand Joseph Trudel-Lapierre
-- =============================================================
-- Description: DATA MEMORY     
-- =============================================================

library ieee;
library std;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_UNSIGNED.all; --for conv_integer
use ieee.std_logic_ARITH.all;

entity dmem is --single cycle MIPS processor
PORT (clk, MemWrite, MemRead: in std_logic;  
   a, WriteData: in std_logic_vector(31 downto 0); 
   ReadData: out std_logic_vector(31 downto 0));
end; -- dmem;

-- =====================================================
architecture dmem_arch of dmem is
CONSTANT MEM_SIZE: integer := 127;
type ramtype is array (MEM_SIZE downto 0) of std_logic_vector (31 downto 0);
signal mem: ramtype;
	
-- =====================================================
begin
		
    process(clk,a) is
      begin
          
        if (clk'event and clk = '1') then
		--si memwrite=1, ecriture dans la memoire			  
			if (memwrite = '1' and a /= "0") then
				mem(conv_integer(a)) <= WriteData;
			end if;
		end if;

--si memread=1, lecture de la memoire				  
		if (MemRead = '1') then			    
		   ReadData <= mem(conv_integer(a));
		end if;
   end process;
end dmem_arch;