LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY VISUALIZADOR IS
    PORT(
        CLK, CLR : IN STD_LOGIC;
        E0: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        E1: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        DISPLAY: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
        AN: INOUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );

    ATTRIBUTE PIN_NUMBERS OF VISUALIZADOR : ENTITY IS
        "CLK:1   "          &
        "CLR:13  "          &
        "E1(2):5 "          &
        "E1(1):6 "          &
        "E1(0):7 "          &
        "E0(3):8 "          &
        "E0(2):9 "          &
        "E0(1):10 "         &
        "E0(0):11 "         &
        "AN(0):14 "         &
        "AN(1):23 "         &
        "AN(2):22 "         &
        "DISPLAY(0):15 "    &   
        "DISPLAY(1):16 "    &   
        "DISPLAY(2):17 "    &  
        "DISPLAY(3):18 "    &  
        "DISPLAY(4):19 "    &  
        "DISPLAY(5):20 "    &  
        "DISPLAY(6):21 ";   
END VISUALIZADOR;

ARCHITECTURE BEHAVE OF VISUALIZADOR IS
CONSTANT Number0 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0000001";
CONSTANT Number1 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "1001111";
CONSTANT Number2 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0010010";
CONSTANT Number3 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0000110";
CONSTANT Number4 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "1001100";
CONSTANT Number5 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0100100";
CONSTANT Number6 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0100000";
CONSTANT Number7 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0001111";
CONSTANT Number8 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0000000";
CONSTANT Number9 : STD_LOGIC_VECTOR(6 DOWNTO 0):=    "0000100";
CONSTANT BCD0 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0000";
CONSTANT BCD1 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0001";
CONSTANT BCD2 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0010";
CONSTANT BCD3 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0011";
CONSTANT BCD4 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0100";
CONSTANT BCD5 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0101";
CONSTANT BCD6 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0110";
CONSTANT BCD7 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "0111";
CONSTANT BCD8 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "1000";
CONSTANT BCD9 : STD_LOGIC_VECTOR(3 DOWNTO 0):=       "1001";
SIGNAL BCD: STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    RING: PROCESS(CLK, CLR)
    BEGIN
        IF CLR = '1' THEN
            AN<="110";
        ELSIF RISING_EDGE(CLK) THEN
            AN<=TO_STDLOGICVECTOR(TO_BITVECTOR(AN) ROL 1);
        END IF;
    END PROCESS RING;

    MUX: PROCESS(AN, E0, E1)
    BEGIN
        CASE AN IS
        WHEN "110"=>
            BCD<= E0;
        WHEN "101"=>
            BCD <= '0' & E1;
        WHEN OTHERS =>
            BCD<=(OTHERS =>'0');
        END CASE;
    END PROCESS MUX;

    CODIFIER: PROCESS(BCD)
    BEGIN
        CASE BCD IS
        WHEN BCD0=>
            DISPLAY<= Number0;
        WHEN BCD1=>
            DISPLAY<= Number1;
        WHEN BCD2=>
            DISPLAY<= Number2;
        WHEN BCD3=>
            DISPLAY<= Number3;
        WHEN BCD4=>
            DISPLAY<= Number4;
        WHEN BCD5=>
            DISPLAY<= Number5;
        WHEN BCD6=>
            DISPLAY<= Number6;
        WHEN BCD7=>
            DISPLAY<= Number7;
        WHEN BCD8=>
            DISPLAY<= Number8;
        WHEN BCD9=>
            DISPLAY<= Number9;
        WHEN OTHERS =>
            DISPLAY<= (OTHERS =>'-');
        END CASE;
    END PROCESS CODIFIER;
END BEHAVE;
