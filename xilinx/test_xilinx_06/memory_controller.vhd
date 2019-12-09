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
             memory_clock : IN std_logic;
             stored_value : OUT std_logic_vector(15 DOWNTO 0));
END memory_controller;

ARCHITECTURE behavioral_5 OF memory_controller IS
    COMPONENT single_memory
        PORT    (clock : IN std_logic;
                 write_enable : IN std_logic;
                 enable : IN std_logic;
                 address : IN std_logic_vector(9 DOWNTO 0);
                 data_in : IN std_logic_vector(15 DOWNTO 0);
                 data_out : OUT std_logic_vector(15 DOWNTO 0));
    END COMPONENT;
    --SHARED VARIABLE memory_buffer : std_logic_vector(15 DOWNTO 0) := "0000000000000000";
    SHARED VARIABLE memory_buffer : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);
    SIGNAL memory_address : std_logic_vector(9 DOWNTO 0);
    SIGNAL data : std_logic_vector(15 DOWNTO 0);
    SIGNAL write_enabled : std_logic;
    SIGNAL enabled : std_logic;
BEGIN
    PROCESS(clock)
        --VARIABLE temp_memory : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);    
    BEGIN
        write_enabled <= '0';        
        enabled <= '0';  
        IF rising_edge(clock) THEN
            --memory_buffer := std_logic_vector(unsigned(memory_buffer) + 1);
            memory_buffer := memory_buffer + 1;
            memory_address <= std_logic_vector(resize(unsigned(memory_buffer), memory_address'LENGTH));
            data <= std_logic_vector(resize(unsigned(memory_buffer), data'LENGTH));
            write_enabled <= '1';
            enabled <= '1';
            --stored_value <= std_logic_vector(resize(unsigned(memory_buffer), stored_value'LENGTH));
        END IF;
        IF falling_edge(clock) THEN
            memory_buffer := memory_buffer;
            memory_address <= std_logic_vector(resize(unsigned(memory_buffer), memory_address'LENGTH));
            data <= std_logic_vector(resize(unsigned(memory_buffer), data'LENGTH));
            write_enabled <= '0';
            enabled <= '1';
            --stored_value <= std_logic_vector(resize(unsigned(memory_buffer), stored_value'LENGTH));      
        END IF;    
    END PROCESS;
    main_clock: single_memory
        PORT MAP(memory_clock, write_enabled, enabled, memory_address, data, stored_value);
END behavioral_5;
