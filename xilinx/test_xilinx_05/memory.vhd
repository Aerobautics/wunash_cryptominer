----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 12/01/2019 04:19:48 PM
-- Design Name: 
-- Module Name: memory - behavioral_1
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-- assymetric port RAM
-- true dual port read first

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY memory IS
    GENERIC(
        WIDTHA : INTEGER := 4;
        SIZEA : INTEGER := 1024;
        ADDRWIDTHA : INTEGER := 10;
        WIDTHB : INTEGER := 16;
        SIZEB : INTEGER := 256;
        ADDRWIDTHB : INTEGER := 8
    );
    PORT(
        clkA : IN std_logic;
        clkB : IN std_logic;
        enA : IN std_logic;
        enB : IN std_logic;
        weA : IN std_logic;
        weB : IN std_logic;
        addrA : IN std_logic_vector(ADDRWIDTHA - 1 DOWNTO 0);
        addrB : IN std_logic_vector(ADDRWIDTHB - 1 DOWNTO 0);
        diA : IN std_logic_vector(WIDTHA - 1 DOWNTO 0);
        diB : IN std_logic_vector(WIDTHB - 1 DOWNTO 0);
        doA : OUT std_logic_vector(WIDTHA - 1 DOWNTO 0);
        doB : OUT std_logic_vector(WIDTHB - 1 DOWNTO 0)    
    );
END ENTITY;

ARCHITECTURE behavioral_1 OF memory IS
    FUNCTION max(L, R : INTEGER) RETURN INTEGER IS
    BEGIN
        IF L > R THEN
            RETURN L;
        ELSE
            RETURN R;
        END IF;
    END;
    
    FUNCTION min(L, R : INTEGER) RETURN INTEGER IS
    BEGIN
        IF L < R THEN
            RETURN L;
        ELSE
            RETURN R;
        END IF;
    END;
         
    FUNCTION log2(val : INTEGER) RETURN NATURAL IS
    VARIABLE res : NATURAL;
    BEGIN
        FOR i IN 0 TO 31 LOOP
            IF (val <= (2 ** i)) THEN
                res := i;
                EXIT;
            END IF;
        END LOOP;
        RETURN res;
    END FUNCTION log2;
    
    CONSTANT minWidth : INTEGER := min(WIDTHA, WIDTHB);
    CONSTANT maxWidth : INTEGER := max(WIDTHA, WIDTHB);
    CONSTANT maxSize : INTEGER := max(SIZEA, SIZEB);
    CONSTANT ratio : INTEGER := maxWidth / minWidth;
    -- An asymmetric RAM is modeled in a similar way as a symmetric RAM,
    -- with an array of arrays object. Its aspect ratio corresponds to
    -- the port with the lower data width (larger depth).
    TYPE ramType IS ARRAY (0 TO maxSize - 1) OF std_logic_vector(minWidth - 1 DOWNTO 0);
    SIGNAL my_ram : ramType := (OTHERS => (OTHERS => '0'));
    SIGNAL readA : std_logic_vector(WIDTHA - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL readB : std_logic_vector(WIDTHB - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL regA : std_logic_vector(WIDTHA - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL regB : std_logic_vector(WIDTHB - 1 DOWNTO 0) := (OTHERS => '0');
    
BEGIN
    PROCESS(clkA)
    BEGIN
        IF rising_edge(clkA) THEN
            IF enA = '1' THEN
                readA <= my_ram(conv_integer(addrA));
                IF weA = '1' THEN
                    my_ram(conv_integer(addrA)) <= diA;
                END IF;
            END IF;
            regA <= readA;
        END IF;
    END PROCESS;
    
    PROCESS(clkB)
    BEGIN
        IF rising_edge(clkB) THEN
            FOR i IN 0 TO ratio - 1 LOOP
                IF enB = '1' THEN
                    readB((i + 1) * minWidth - 1 DOWNTO i * minWidth) <= my_ram(conv_integer(addrB & conv_std_logic_vector(i, log2(ratio))));
                    IF weB = '1' THEN
                        my_ram(conv_integer(addrB & conv_std_logic_vector(i, log2(ratio)))) <= diB((i + 1) * minWidth - 1 DOWNTO i * minWidth);
                    END IF;               
                END IF;
            END LOOP;
            regB <= readB;
        END IF;
    END PROCESS;
    
    doA <= regA;
    doB <= regB;
END behavioral_1;
