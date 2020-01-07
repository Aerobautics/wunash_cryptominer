----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 01/03/2020 01:04:35 AM
-- Design Name: 
-- Module Name: sha_algorithm - behavioral_8
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

ENTITY sha_algorithm IS
    PORT    (clock : IN std_logic;
             message: IN std_logic_vector(31 DOWNTO 0);
             encrypted: OUT std_logic_vector(31 DOWNTO 0));
END sha_algorithm;

ARCHITECTURE behavioral_8 OF sha_algorithm IS
    COMPONENT memory_control
        PORT    (clock : IN std_logic;
                 address : IN std_logic_vector(7 DOWNTO 0);
                 unlock : IN std_logic;                 
                 data : OUT std_logic_vector(31 DOWNTO 0);
                 ready : OUT std_logic);
    END COMPONENT;    
    COMPONENT memory_read
        PORT    (clock : IN std_logic;
                 unlock : IN std_logic;
                 address : IN std_logic_vector(7 DOWNTO 0);
                 data : IN std_logic_vector(31 DOWNTO 0);
                 data_buffer : OUT std_logic_vector(31 DOWNTO 0);
                 ready : OUT std_logic);
    END COMPONENT;
    SHARED VARIABLE sha_state : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);
    SHARED VARIABLE internal_state : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);
    SIGNAL rom_address : std_logic_vector(7 DOWNTO 0);
    SIGNAL ram_address : std_logic_vector(7 DOWNTO 0);
    SIGNAL rom_lock : std_logic;
    SIGNAL ram_lock : std_logic;
    SIGNAL ram_buffer : std_logic_vector(31 DOWNTO 0);
    SIGNAL rom_buffer : std_logic_vector(31 DOWNTO 0);
    SIGNAL rom_ready : std_logic;
    SIGNAL ram_ready : std_logic;
BEGIN
    PROCESS(clock)
        CONSTANT working_variables : std_logic_vector(7 DOWNTO 0) := "00000000"
        CONSTANT hash_values : std_logic_vector(7 DOWNTO 0) := "00000000"
        --VARIABLE internal_state_complete : std_logic := '0';
        --VARIABLE external_state_complete : std_logic := '0';
    BEGIN
        IF rising_edge(clock) THEN
            IF (sha_state = "0000") THEN
                -- Initialize working variables to hash values
                IF (internal_state = "111") THEN
                    --internal_state_complete = '1';
                    sha_state <= std_logic_vector(unsigned(sha_state) + 1);
                ELSE
                    rom_address <= std_logic_vector(unsigned(hash_values) + resize(unsigned(internal_state), hash_values'LENGTH));
                    ram_address <= std_logic_vector(unsigned(working_variables) + resize(unsigned(internal_state), working_variables'LENGTH));                    
                END IF;            
            ELSIF (sha_state = "0001") THEN
            
            ELSIF (sha_state = "0010") THEN
            
            ELSIF (sha_state = "0011") THEN
            
            ELSIF (sha_state = "0100") THEN
            
            ELSIF (sha_state = "0101") THEN
            
            ELSE
            
            END IF;
        END IF;    
    END PROCESS;
    read_memory: memory_read
        PORT MAP(clock, rom_address, rom_lock, rom_buffer, rom_ready);

END behavioral_8;
