--========================= MIPSPackage.vhd ============================
-- ELE-340 Conception des systèmes ordinés
-- HIVER 2010, Ecole de technologie supérieure
-- Auteur : Kevyn-Alexandre Pare, Sean Beitz, Jonathan Riel-Landry
-- =============================================================
-- Description: MIPSPackage        
-- =============================================================

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned. all;
  
PACKAGE MIPSPackage IS

-- ce fichier contient toutes les déclarations des composantes utilisé dans le projet du processeur mips.

COMPONENT RegFile is --is a 3 port Register File
PORT (clk: in std_logic;
   we3 : in std_logic;
   ra1, ra2, wa3 : in std_logic_vector(4 downto 0);
   wd3 : in std_logic_vector(31 downto 0);
   rd1, rd2 : out std_logic_vector(31 downto 0));
END COMPONENT;

COMPONENT dmem is --single cycle MIPS processor
PORT (clk, MemWrite, MemRead: in std_logic;  
   a, WriteData: in std_logic_vector(31 downto 0); 
   ReadData: out std_logic_vector(31 downto 0));
end COMPONENT; -- dmem;


COMPONENT imem is --single cycle MIPS processor
PORT (aa: in std_logic_vector(5 downto 0);
   rd: out std_logic_vector(31 downto 0));
end COMPONENT; -- imem;

COMPONENT MIPS IS
  PORT (
    Clock: IN STD_LOGIC;
    Reset: IN STD_LOGIC;
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    MemWrite, MemRead: OUT STD_LOGIC
  ); 
END COMPONENT;

COMPONENT MainDecoder IS
  PORT (
    OPCode: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    MemToReg, MemRead, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump: OUT STD_LOGIC;
    ALUOperation: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
  ); 
END COMPONENT;

COMPONENT ALUDecoder IS 
  PORT (
    Funct: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    ALUOperation: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
    ALUControl: OUT STD_LOGIC_VECTOR (3 DOWNTO 0) 
  ); 
END COMPONENT;

COMPONENT PC1 IS
   PORT (
        Instr : IN STD_LOGIC_VECTOR (25 DOWNTO 0);
        Clock, Reset, PCSrc, Jump : IN STD_LOGIC;
        SignImm : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
 END COMPONENT;       

COMPONENT MUX21Generic IS
  GENERIC ( Mux_Size : integer := 32 );
  PORT ( 
    MUXInput0, MUXInput1: IN STD_LOGIC_VECTOR (Mux_Size DOWNTO 0);
    MUXSel: IN STD_LOGIC;
    MUXOutput: OUT STD_LOGIC_VECTOR (Mux_Size DOWNTO 0)	
  );

END COMPONENT;

COMPONENT full_adder_32 IS 		
PORT (
  a, b : IN STD_LOGIC_VECTOR (31 downto 0);
  sum : OUT STD_LOGIC_VECTOR (31 downto 0)
);
END COMPONENT;

COMPONENT alu_32 IS 
  
   GENERIC (ALU_SIZE: integer := 31); 
PORT (
   SrcA, SrcB: IN STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
   ALUControl_32 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
   c_out: OUT STD_LOGIC;
   Result_32: OUT STD_LOGIC_VECTOR (ALU_SIZE DOWNTO 0);
   zero: OUT std_logic
); END COMPONENT ;


COMPONENT alu_1 IS PORT (
   alu_a, alu_b, alu_c_in, less : IN STD_LOGIC;
   ALUControl : IN STD_LOGIC_VECTOR (3 downto 0);
   alu_c_out, result, set: OUT STD_LOGIC
); END COMPONENT;

COMPONENT full_adder IS 		
PORT (
  a, b, c_in : IN STD_LOGIC;
  sum, c_out : OUT STD_LOGIC	
);
END COMPONENT;


COMPONENT mux4_1
PORT ( m4_i0, m4_i1, m4_i2, m4_i3: IN std_logic;
    m4_sel: IN std_logic_vector(1 downto 0) ;
    m4_q : OUT std_logic);
END COMPONENT;

COMPONENT mux2_1
PORT ( m2_i0, m2_i1, m2_sel : IN std_logic;
    m2_q : OUT std_logic);
end COMPONENT;




COMPONENT DFlipFlop IS
  PORT(
       D : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
       Clock, Reset : IN  STD_LOGIC;
       Q        : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
       );
END COMPONENT;

COMPONENT LogicRegister IS 
PORT (
  RegWrite, ALUSrc, Clock, RegDst: IN STD_LOGIC;
  Instr25_21, Instr20_16, Instr15_11: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
  Instr15_0: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
  Result: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
  SrcA, SrcB, rd2, SignExtend: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
); 
END COMPONENT ;



COMPONENT Controller IS
  PORT (
    OPCodeController, FunctController: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
    Zero: IN STD_LOGIC;
    PCSrc, MemToRegController, MemReadController, MemWriteController, 
    ALUSrcController, RegDstController, RegWriteController, 
    JumpController: OUT STD_LOGIC;
    ALUControlController: OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
  ); 
END COMPONENT;

COMPONENT DataPath IS
  PORT (
    Clock: IN STD_LOGIC;
    Reset: IN STD_LOGIC;
    MemToReg: IN STD_LOGIC;
    PCSrc: IN STD_LOGIC;
    AluSrc: IN STD_LOGIC;
    RegDst: IN STD_LOGIC;
    RegWrite: IN STD_LOGIC;
    Jump: IN STD_LOGIC;
    Zero: OUT STD_LOGIC;
    ALUControl: STD_LOGIC_VECTOR (3 DOWNTO 0);  
    Instruction: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    Data: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    PC: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Result: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    Rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
  ); 
END COMPONENT;

COMPONENT RegisterBank IS
   PORT (
    ra1, ra2, wa3: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
    wd3: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    RegWrite, Clock: IN STD_LOGIC;
    rd1, rd2: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)--TODO Clock Signal
  ); 
 END COMPONENT;
 
 
END PACKAGE;