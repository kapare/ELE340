--========================= ProgramCounter.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: Program Counter      
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned. ALL;
USE WORK.MIPSPackage.ALL;

-- l'entité de la logique du program counter. elle est nommé PC1 pour éviter des conflits dans les autres fichiers
ENTITY PC1 IS
   PORT (
        Instr : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
        Clock, Reset, PCSrc, Jump : IN STD_LOGIC;
        SignImm : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
END PC1;
   
ARCHITECTURE PCArchitechture OF PC1 is
-- signal 34 bits pour la logique de shift left du sign extend 
SIGNAL s_SignImmSh2 :  STD_LOGIC_VECTOR (33 DOWNTO 0);
-- signaux 32 bits pour les connections intercomposantes, elles sont nommé par rapport au operation qui les utilises
SIGNAL s_SignImmSh, s_PcNext, s_BascOut, s_PCNextbr, s_PCBranch, s_PCJump: STD_LOGIC_VECTOR (31 DOWNTO 0):= "00000000000000000000000000000000"; --:=  (others =>'0');
SIGNAL s_PcPlus4 :STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000000";
-- signal de valeur 4 pour l'addition de 4 au pc, elle aurait aussi pu etre une constante
SIGNAL s_plus4 :  STD_LOGIC_VECTOR (31 DOWNTO 0):= X"00000004";

--signal pour la concatenation et le shift left des instructions
SIGNAL s_Instr_sl2 :  STD_LOGIC_VECTOR (27 DOWNTO 0);

-- SIGNAL s_NotConnected : STD_LOGIC_VECTOR (31 DOWNTO 0):=  (others =>'0'); --:= "00000000000000000000000000000000";

BEGIN

   
--component mux placé apres l'unité d'addition
port_assign_mux_add : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
 MUXInput0 => s_PcPlus4  , 
 MUXInput1 => s_PCBranch  ,  
 MUXSel  => PCSrc  , 
 MUXOutput =>  s_PCNextbr
 );

 --component mux placé apres l'unité de concaténation et de l'autre MUX
port_assign_mux_pcnext : MUX21Generic 
GENERIC MAP( Mux_Size => 32)
PORT MAP(
 MUXInput0 =>  s_PCNextbr , 
 MUXInput1 =>  s_PCJump ,  
 MUXSel  =>   Jump, 
 MUXOutput => s_PcNext   
);


--component adder 32 bits qui fait l'addition de 4 a pc 
add_plus4 : full_adder_32 PORT MAP(
a => s_BascOut, 
b => s_plus4, 
sum => s_PcPlus4
);

-- component adder 32 bits qui additionne le sign extend avec pcplus4
add_PC_SignImm : full_adder_32 PORT MAP(
a => s_PcPlus4, 
b => s_SignImmSh, 
sum => s_PCBranch 
);


--component bascules qui retient en memoire pcNEXT
bascule : DFlipFlop PORT MAP (
  
  D =>  s_PcNext, 
  Clock =>  Clock, 
  Reset =>  Reset,
  Q =>  s_BascOut
  
);


-- logique de concaténation et shift left pour l'entré des instructions et le pcplus4
s_PCJump <=  s_PcPlus4(31 downto 28) & (Instr & "00");

-- logique de shift left pour le sign extend
s_SignImmSh2 <= SignImm & "00";
s_SignImmSh <= s_SignImmSh2(31 DOWNTO 0);

-- logique de connection pour la sortie
PC <= s_BascOut;


END PCArchitechture;








