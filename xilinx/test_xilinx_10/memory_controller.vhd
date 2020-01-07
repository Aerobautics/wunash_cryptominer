----------------------------------------------------------------------------------
-- Company: Pervigilent
-- Engineer: Stewart Nash
-- 
-- Create Date: 12/06/2019 09:21:52 PM
-- Design Name: 
-- Module Name: memory_controller - behavioral_5
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

ENTITY memory_controller IS
    PORT    (clock : IN std_logic;
             stored_value : OUT std_logic_vector(15 DOWNTO 0);
             memory_address : OUT std_logic_vector(9 DOWNTO 0));
END memory_controller;

ARCHITECTURE behavioral_5 OF memory_controller IS
    --SHARED VARIABLE memory_buffer : std_logic_vector(15 DOWNTO 0) := "0000000000000000";
    SHARED VARIABLE memory_buffer : unsigned(9 DOWNTO 0) := to_unsigned(0, 10);
    --SIGNAL memory_location : std_logic_vector(9 DOWNTO 0);
    --SIGNAL data : std_logic_vector(15 DOWNTO 0);
BEGIN
    PROCESS(clock)
        --VARIABLE temp_memory : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);    
    BEGIN
        IF rising_edge(clock) THEN
            --memory_buffer := std_logic_vector(unsigned(memory_buffer) + 1);
            memory_buffer := memory_buffer + 1;
            memory_address <= std_logic_vector(resize(unsigned(memory_buffer), memory_address'LENGTH));
            stored_value <= std_logic_vector(resize(unsigned(memory_buffer), stored_value'LENGTH));
            --stored_value <= std_logic_vector(resize(unsigned(memory_buffer), stored_value'LENGTH));
        END IF;  
    END PROCESS;
    
END behavioral_5;
