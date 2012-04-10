--========================= mainDec.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- Automne 2008, Ecole de technologie supérieure
--
-- Description: MainDec pour processeur mips multicycle
--
-- Dans ce qui suit, on assume que (et donc ne pas les redefinir):
--   ALUOp(1 downto 0) <= Controls(17 downto 16);   
--   ALUSrcA <= Controls(15);
--   ALUSrcB (1 downto 0) <= Controls(14 downto 13);
--   RegWrite  <= Controls(12);
--   RegDst <= Controls(11);
--   MemtoReg  <= Controls(10);
--   IorD <= Controls(9); 	MemRead <= Controls(8);   
--   MemWrite  <= Controls(7);  
--   IRWrite <= Controls(6); 
--   PCSource(1 downto 0) <= Controls(5 downto 4);
--   PCWrite <= Controls(3);   
--   PCWriteCond <= Controls(2);  
--   Seq(1 downto 0) <= Controls(1 downto 0); 
-- =============================================================

library ieee;
library std;
use ieee.std_logic_1164.all;

entity MainDec is --multicycle Main Control Decoder
Port (clk, Reset, Zero: in std_logic;
  OP : in std_logic_vector(5 downto 0);
  PCEnable  : out std_logic;
  Controls : out std_logic_vector(17 downto 0);
  State : out std_logic_vector(3 downto 0)
); end; -- MainDec;


-- ======================================================================================
architecture MainDec_arch of MainDec is

CONSTANT FETCH   : std_logic_vector(3 downto 0):="0000"; --State 0
CONSTANT DECODE  : std_logic_vector(3 downto 0):="0001"; --State 1
CONSTANT MEMADR  : std_logic_vector(3 downto 0):="0010"; --State 2
CONSTANT MEMRD   : std_logic_vector(3 downto 0):="0011"; --State 3
CONSTANT MEMWB   : std_logic_vector(3 downto 0):="0100"; --State 4
CONSTANT MEMWR   : std_logic_vector(3 downto 0):="0101"; --State 5
CONSTANT RTYPEEX : std_logic_vector(3 downto 0):="0110"; --State 6
CONSTANT RTYPEWB : std_logic_vector(3 downto 0):="0111"; --State 7
CONSTANT BEQEX   : std_logic_vector(3 downto 0):="1000"; --State 8
CONSTANT JEX     : std_logic_vector(3 downto 0):="1001"; --State 9
CONSTANT ADDIEX  : std_logic_vector(3 downto 0):="1010"; --state 10:A
CONSTANT ADDIWB  : std_logic_vector(3 downto 0):="1011"; --State 11:B

CONSTANT RTYPE : std_logic_vector(5 downto 0):="000000";
CONSTANT Addi  : std_logic_vector(5 downto 0):="001000";
CONSTANT Lw    : std_logic_vector(5 downto 0):="100011";
CONSTANT Sw    : std_logic_vector(5 downto 0):="101011";
CONSTANT Beq   : std_logic_vector(5 downto 0):="000100";
CONSTANT Jump  : std_logic_vector(5 downto 0):="000010";

signal state_tempo: std_logic_vector(3 downto 0);
signal Controls_tempo: std_logic_vector(17 downto 0);

signal nextstate   : std_logic_vector(3 downto 0); --:="0000"; --integer;  

signal PCWrite     : std_logic; --PCWrite
signal PCWriteCond :std_logic;  --PCWriteCond

--Definition du type matrix
Type matrix is array (0 to 12) of std_logic_vector(17 downto 0);
signal State_Ctrl_Mat : matrix; 

-- ==================================================================
begin
State       <= State_tempo;
Controls    <= Controls_tempo;
PCWrite    	<= Controls_tempo(3);  
PCWriteCond	<= Controls_tempo(2);

-- Initialisation des valeur pour chaque états. 
State_Ctrl_Mat(0) <= "00"&X"214B";--"000010000101001011";--State 0
State_Ctrl_Mat(1) <= "00"&X"6001";--"000110000000000001";--State 1
State_Ctrl_Mat(2) <= "00"&X"C002";--"001100000000000010";--State 2
State_Ctrl_Mat(3) <= "00"&X"0303";--"000000001100000010";--State 3
State_Ctrl_Mat(4) <= "00"&X"1400";--"000001010000000000";--State 4
State_Ctrl_Mat(5) <= "00"&X"0280";--"000000001010000000";--State 5
State_Ctrl_Mat(6) <= "10"&X"8003";--"101000000000000011";--State 6
State_Ctrl_Mat(7) <= "00"&X"1800";--"000001100000000000";--State 7
State_Ctrl_Mat(8) <= "01"&X"8014";--"011000000000010100";--State 8
State_Ctrl_Mat(9) <= "00"&X"0028";--"000000000000101000";--State 9
State_Ctrl_Mat(10)<= "00"&X"C003";--"001100000000000011";--State 10
State_Ctrl_Mat(11)<= "00"&X"1000";--"000001000000000000";--State 11

-- Processus qui controle l'état du tempo selon état du clock et/ou le reset.
PROCESS (reset,State_tempo,clk)
BEGIN
 if clk = '1' AND clk'EVENT THEN
    if(reset='1') then State_tempo <= FETCH;--nextState <= FETCH;
    else State_tempo <= nextState;
  end if;
 end if;
END PROCESS;

-- Processus qui controle le prochain état (nextState) en fonction de état présent ayant changé.
PROCESS (Controls_tempo,State_tempo,nextState)
BEGIN     
   case State_tempo is
       WHEN FETCH =>   nextState <= DECODE;
       WHEN DECODE=>                       
               case OP is
                 WHEN Lw=> nextState <= MEMADR;
                 WHEN Sw=> nextState <= MEMADR;
                 WHEN RTYPE=> nextState <= RTYPEEX;
                 WHEN Beq=> nextState <= BEQEX;
                 WHEN Addi=> nextstate <= ADDIEX;
                 WHEN Jump=> nextstate <= JEX;             
                 WHEN OTHERS=> nextState <= FETCH; -- ne devrait pas arriver
               end case;
       WHEN MEMADR=> 
               case OP is
                 WHEN LW=> nextState <= MEMRD;
                 WHEN SW=> nextState <= MEMWR;
                 WHEN OTHERS=>  nextState <= FETCH; -- ne devrais pas arriver
               end case;
       WHEN MEMRD=> nextState <= MEMWB;
       WHEN MEMWB=> nextState <= FETCH;
       WHEN MEMWR=> nextState <= FETCH;
       WHEN RTYPEEX=> nextState <= RTYPEWB;
       WHEN RTYPEWB=> nextState <= FETCH;  
       WHEN BEQEX=> nextState <= FETCH;
       WHEN ADDIEX=> nextState <= ADDIWB;
       WHEN ADDIWB=> nextState <= FETCH;
       WHEN JEX=> nextState <= FETCH;                      
       WHEN OTHERS => nextState <= FETCH;
   end case;
END PROCESS;


-- Processus qui change la valeur du Controls_tempo selon un State_Ctrl_Mat précis et un State_tempo.
PROCESS(State_tempo,nextState)
BEGIN
    case State_tempo is
      WHEN FETCH=>   Controls_tempo <= State_Ctrl_Mat(0);  --State 0
      WHEN DECODE=>  Controls_tempo <= State_Ctrl_Mat(1);  --State 1
      WHEN MEMADR=>  Controls_tempo <= State_Ctrl_Mat(2);  --State 2
      WHEN MEMRD=>   Controls_tempo <= State_Ctrl_Mat(3);  --State 3
      WHEN MEMWB=>   Controls_tempo <= State_Ctrl_Mat(4);  --State 4
      WHEN MEMWR=>   Controls_tempo <= State_Ctrl_Mat(5);  --State 5
      WHEN RTYPEEX=> Controls_tempo <= State_Ctrl_Mat(6);  --State 6
      WHEN RTYPEWB=> Controls_tempo <= State_Ctrl_Mat(7);  --State 7
      WHEN BEQEX=>   Controls_tempo <= State_Ctrl_Mat(8);  --State 8
      WHEN JEX=>     Controls_tempo <= State_Ctrl_Mat(9);  --State 9
      WHEN ADDIEX=>  Controls_tempo <= State_Ctrl_Mat(10); --State 10
      WHEN ADDIWB=>  Controls_tempo <= State_Ctrl_Mat(11); --State 11
                
      WHEN OTHERS=>  Controls_tempo <= State_Ctrl_Mat(0);  -- ne devrait pas arriver
    end case;
END PROCESS;

-- Processus controlant la valeur du PCEnable selon le changement des signaux Zero, PCWrite et PCWriteConf
PROCESS(Zero, PCWrite, PCWriteCond)
BEGIN
   PCEnable <= (Zero AND PCWriteCond) OR PCWrite;
END PROCESS;
END;