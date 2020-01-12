----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Stewart Nash
-- 
-- Create Date: 01/01/2020 09:58:54 AM
-- Design Name: 
-- Module Name: ram_controller - behavioral_7
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

ENTITY ram_controller IS
    PORT    (clock : IN std_logic;
             read_only : IN std_logic;
             reset : IN std_logic;
             address : IN std_logic_vector (9 DOWNTO 0);
             data : IN std_logic_vector(15 DOWNTO 0);
             data_buffer : OUT std_logic_vector(15 DOWNTO 0);
             ready : OUT std_logic);
END ram_controller;

ARCHITECTURE behavioral_7 OF ram_controller IS
    COMPONENT ram_memory
        PORT    (clock : IN std_logic;
                 write_enable : IN std_logic;
                 enable : IN std_logic;
                 address : IN std_logic_vector(9 DOWNTO 0);
                 data_in : IN std_logic_vector(15 DOWNTO 0);
                 data_out : OUT std_logic_vector(15 DOWNTO 0));
    END COMPONENT;
    SHARED VARIABLE memory_period : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);
    SHARED VARIABLE memory_reset : std_logic := '0';
    SIGNAL enable : std_logic;
    SIGNAL write : std_logic;
    SIGNAL memory_buffer : std_logic_vector(15 DOWNTO 0);
BEGIN
    PROCESS(clock)
        VARIABLE unlock : std_logic := '0';
    BEGIN
        IF rising_edge(clock) THEN
            IF (reset /= memory_reset) THEN
                unlock := '1';
                memory_reset := reset;
                memory_period := to_unsigned(0, 4);
            ELSIF (memory_period /= "1110") THEN
                unlock := '1';
            END IF;
            IF (unlock = '1') THEN -- Unlocked
                memory_period := memory_period + 1;
                IF (read_only = '0') THEN
                    IF (memory_period = "0001") THEN
                        ready <= '0';
                        enable <= '0';
                        write <= '0';
                    ELSIF (memory_period = "0010") THEN
                        --ready <= '0';
                        enable <= '1';
                        --write <= '0';
                    ELSIF (memory_period = "0011") THEN
                        --ready <=  '0';
                        --enable <= '1';
                        write <= '1';
                    ELSIF (memory_period = "0101") THEN
                        --ready <= '0';
                        --enable <= '1';
                        write <= '0';
                    ELSIF (memory_period = "0111") THEN
                        --ready <= '0';
                        --enable <= '1';
                        data_buffer <= memory_buffer;
                    ELSIF (memory_period = "1000") THEN
                        --ready <= '0';
                        enable <= '0';
                    ELSIF (memory_period = "1001") THEN
                        ready <= '1';
                        --enable <= '0';
                    ELSIF (memory_period = "1111") THEN
                        memory_period := to_unsigned(14, 4);
                    END IF;                 
                ELSE
                    IF (memory_period = "0001") THEN
                        ready <= '0';
                        enable <= '0';
                        write <= '0';
                    ELSIF (memory_period = "0010") THEN
                        --ready <= '0';
                        enable <= '1';
                        --write <= '0';
                    ELSIF (memory_period = "0111") THEN
                        --ready <= '0';
                        --enable <= '1';
                        data_buffer <= memory_buffer;
                    ELSIF (memory_period = "1000") THEN
                        --ready <= '0';
                        enable <= '0';
                    ELSIF (memory_period = "1001") THEN
                        ready <= '1';
                        --enable <= '0';
                    ELSIF (memory_period = "1111") THEN
                        memory_period := to_unsigned(14, 4);
                    END IF;                 
                END IF;           
            ELSE -- Locked
                ready <= '1';
                enable <= '0';
                write <= '0';
                memory_period := to_unsigned(0, 4);            
            END IF; -- Lock        
        END IF; -- Rising edge
    END PROCESS;
    swpf_memory: ram_memory
        PORT MAP(clock, write, enable, address, data, memory_buffer);
END behavioral_7;