----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 12:53:02 PM
-- Design Name: 
-- Module Name: refresh_counter - behavioral_1
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
USE IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY refresh_counter IS
    PORT    (refresh_clock : IN std_logic;
             refresh_count : OUT std_logic_vector (1 DOWNTO 0));
END refresh_counter;

ARCHITECTURE behavioral_1 OF refresh_counter IS
    --SHARED VARIABLE refresh_buffer : unsigned(1 DOWNTO 0) := (OTHERS => '0');
    SHARED VARIABLE refresh_buffer : unsigned(1 DOWNTO 0) := to_unsigned(0, 2);
    SIGNAL increment : unsigned(1 DOWNTO 0);
BEGIN
    PROCESS(refresh_clock)    
    BEGIN
        IF rising_edge(refresh_clock) THEN
            refresh_buffer := refresh_buffer + 1;                 
        END IF;    
    END PROCESS;
    refresh_count <= std_logic_vector(refresh_buffer);   
END behavioral_1;
