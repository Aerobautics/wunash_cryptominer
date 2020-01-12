----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 01/03/2020 01:44:06 AM
-- Design Name: 
-- Module Name: rom_controller - behavioral_9
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY rom_controller IS
    PORT    (clock : IN std_logic;
             address : IN std_logic_vector(7 DOWNTO 0);
             reset : IN std_logic;
             data : OUT std_logic_vector(31 DOWNTO 0);
             ready : OUT std_logic);
END rom_controller;

ARCHITECTURE behavioral_9 OF rom_controller IS
    COMPONENT rom_memory
        PORT    (clock : IN std_logic;
                 enable : IN std_logic;
                 address : IN std_logic_vector(7 DOWNTO 0);
                 data : OUT std_logic_vector(31 DOWNTO 0);
                 ready : OUT std_logic);                 
    END COMPONENT;
    SHARED VARIABLE read_period : unsigned(1 DOWNTO 0) := to_unsigned(0, 2);
    SHARED VARIABLE read_reset : std_logic := '0';
    SIGNAL read_buffer : std_logic_vector(31 DOWNTO 0);
    SIGNAL enable : std_logic;
BEGIN
    PROCESS(clock)
        VARIABLE unlock : std_logic := '1';
    BEGIN
        IF rising_edge(clock) THEN
            IF (unlock = '1') THEN -- Unlocked
                IF (read_period = "00") THEN
                    ready <= '0';
                    enable <= '0';                
                ELSIF (read_period = "01") THEN
                    enable <= '1';                
                ELSIF (read_period = "10") THEN
                    data <= read_buffer;                
                ELSE
                    enable <= '0';
                    ready <= '1';
                    read_period := to_unsigned(2, 2);                
                END IF;
                read_period := read_period + 1;
            ELSE -- Locked
                ready <= '1';
                enable <= '0';
                read_period := to_unsigned(0, 2);                        
            END IF;        
        END IF;    
    END PROCESS;
    roms_memory: rom_memory
        PORT MAP(clock, enable, address, read_buffer);
END behavioral_9;
