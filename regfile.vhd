--========================= regfile.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- hiver 2010, Ecole de technologie supérieure
-- =============================================================
--1 cycle
--==============================================================
-- Description: 
-- regfile prend en entrée les adresses ra1, ra2, wa3 et la donnée wd3. 
-- Fait la lecture en mémoire. Il retourne en sortie rd1, rd2. 
-- Le banc de registre est contrôlé par we3 (ie. RegWrite)
-- =============================================================

library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity RegFile is --is a 3 port Register File
PORT (clk: in std_logic;
   we3 : in std_logic;
   ra1, ra2, wa3 : in std_logic_vector(4 downto 0);
   wd3 : in std_logic_vector(31 downto 0);
   rd1, rd2 : out std_logic_vector(31 downto 0));
END;

architecture RegFile_arch of RegFile is

type RamType is Array (31 downto 0) of std_logic_vector(31 downto 0);
signal mem : RamType;

begin

--three-ported register file
-- read two port combinationaly
--write third port on rising edge of clock

Process (clk, mem)
Begin
 if clk'event and clk ='1' then
   if we3 = '1' then mem(CONV_INTEGER(wa3)) <= wd3;
   end if;
 end if;
End Process;

Process (ra1, ra2, clk, mem)
Begin
   if (conv_integer (ra1) = 0) then rd1 <= X"00000000"; --reg 0 contient 0
   else rd1 <= mem(conv_integer(ra1));
   end if;

   if (conv_integer (ra2) = 0) then rd2 <= X"00000000"; --reg 0 contient 0
   else rd2 <= mem(conv_integer(ra2));
   end if;   
End Process; 

end RegFile_arch;