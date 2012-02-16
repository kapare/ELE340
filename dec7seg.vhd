--================ controller.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- hiver 2010, Ecole de technologie supérieure
-- Vincent Trudel-Lapierre
-- =============================================================
-- Description: Décodeur 7-segment Alpha-numérique pour DE-2
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;

ENTITY dec7seg IS

--Configuration des entrées et sortie du controller
PORT (sortie:            OUT std_logic_vector(0 to 6);
      entree:   IN std_logic_vector(3 downto 0));
end dec7seg;

ARCHITECTURE dec7seg_archi OF dec7seg IS

BEGIN

	process(entree)
	BEGIN 

	   case entree is
		  when "0000" =>
			  sortie <= "0000001"; -- 0
		  when "0001" =>
			  sortie <= "1001111"; -- 1
		  when "0010" =>
			  sortie <= "0010010"; -- 2
		  when "0011" =>
			  sortie <= "0000110"; -- 3
		  when "0100" =>
			  sortie <= "1001100"; -- 4
		  when "0101" =>
			  sortie <= "0100100"; -- 5
		  when "0110" =>
			  sortie <= "0100000"; -- 6
		  when "0111" =>
			  sortie <= "0001111"; -- 7
		  when "1000" =>
			  sortie <= "0000000"; -- 8
		  when "1001" =>
			  sortie <= "0000100"; -- 9
		  when "1010" =>
			  sortie <= "0001000"; -- A
		  when "1011" =>
			  sortie <= "1100000"; -- b
		  when "1100" =>
			  sortie <= "0110001"; -- C
		  when "1101" =>
			  sortie <= "1000010"; -- d
		  when "1110" =>
			  sortie <= "0110000"; -- E
		  when "1111" =>
			  sortie <= "0111000"; -- F   
			when others =>
			sortie<=    "1111111";
	   END case;
   END process;

END dec7seg_archi;
