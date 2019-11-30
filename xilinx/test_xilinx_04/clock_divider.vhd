----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 12:16:25 PM
-- Design Name:
-- Module Name: clock_divider - structural_1
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


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY clock_divider IS
    PORT    (clock : IN std_logic;
             divided_clock : OUT std_logic);
END clock_divider;

ARCHITECTURE structural_1 OF clock_divider IS
    SHARED VARIABLE counter_value : INTEGER := 0;
    SIGNAL clock_buffer : std_logic := '0';
BEGIN
    PROCESS(clock)
    CONSTANT clock_period : INTEGER := 100000; -- 1 kHz
    BEGIN
        IF rising_edge(clock) THEN
            IF counter_value = clock_period THEN
                counter_value := 0;
                clock_buffer <= NOT clock_buffer;
                divided_clock <= clock_buffer;
            ELSE
                counter_value := counter_value + 1;
                clock_buffer <= clock_buffer;
                divided_clock <= clock_buffer;
            END IF;
        END IF;
    END PROCESS;
END structural_1;
