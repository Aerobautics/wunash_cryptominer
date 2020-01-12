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
    COMPONENT ram_controller
        PORT    (clock : IN std_logic;
                 read_only : IN std_logic;
                 reset : IN std_logic;                 
                 address : IN std_logic_vector(7 DOWNTO 0);
                 data : OUT std_logic_vector(31 DOWNTO 0);
                 ready : OUT std_logic);
    END COMPONENT;    
    COMPONENT rom_controller
        PORT    (clock : IN std_logic;
                 address : IN std_logic_vector(7 DOWNTO 0);
                 reset : IN std_logic;
                 data : OUT std_logic_vector(31 DOWNTO 0);
                 ready : OUT std_logic);
    END COMPONENT;
    SHARED VARIABLE sha_state : unsigned(3 DOWNTO 0) := to_unsigned(0, 4);
    SHARED VARIABLE internal_state : unsigned(5 DOWNTO 0) := to_unsigned(0, 6);
    SIGNAL rom_address : std_logic_vector(7 DOWNTO 0);
    SIGNAL ram_address : std_logic_vector(7 DOWNTO 0);
    SIGNAL rom_reset : std_logic;
    SIGNAL ram_reset : std_logic;
    SIGNAL ram_read : std_logic;
    SIGNAL ram_buffer : std_logic_vector(31 DOWNTO 0);
    SIGNAL rom_buffer : std_logic_vector(31 DOWNTO 0);
    SIGNAL rom_ready : std_logic;
    SIGNAL ram_ready : std_logic;
    SIGNAL rom_complete : std_logic := '0';
    SIGNAL ram_complete : std_logic := '0';
BEGIN
    PROCESS(clock)
        CONSTANT working_variables : std_logic_vector(7 DOWNTO 0) := "00000000"
        CONSTANT hash_values : std_logic_vector(7 DOWNTO 0) := "00000000"
        --VARIABLE internal_state_complete : std_logic := '0';
        --VARIABLE external_state_complete : std_logic := '0';
        VARIABLE s0 : std_logic_vector(31 DOWNTO 0);
        VARIABLE s1 : std_logic_vector(31 DOWNTO 0);
        VARIABLE ch : std_logic_vector(31 DOWNTO 0);
        VARIABLE maj : std_logic_vector(31 DOWNTO 0);
        VARIABLE temp1 : std_logic_vector(31 DOWNTO 0);
        VARIABLE temp2 : std_logic_vector(31 DOWNTO 0);
        VARIABLE work_1_unsigned : unsigned(31 DOWNTO 0);
        VARIABLE work_2_unsigned : unsigned(31 DOWNTO 0);
        VARIABLE work_3_unsigned : unsigned(31 DOWNTO 0);        
    BEGIN
        IF rising_edge(clock) THEN
            IF (sha_state = "0000") THEN
                -- Initialize working variables to hash values
                IF (internal_state = "00111") THEN
                    --internal_state_complete = '1';
                    sha_state <= std_logic_vector(unsigned(sha_state) + 1);
                ELSE
                    rom_address <= std_logic_vector(unsigned(hash_values) + resize(unsigned(internal_state), hash_values'LENGTH));
                    ram_address <= std_logic_vector(unsigned(working_variables) + resize(unsigned(internal_state), working_variables'LENGTH));
                    IF (rom_ready = '1') THEN
                        rom_reset <= NOT rom_reset;
                        ram_buffer <= rom_buffer;
                    END IF;
                    IF (ram_ready = '1') THEN
                        ram_lock <= '0';
                        internal_state := internal_state + 1;
                    END IF;                    
                END IF;            
            ELSIF (sha_state = "0001") THEN
                -- Do the main loop of the compression function
                -- a(0), b(1), c(2), d(3), e(4), f(5), g(6)
                IF (internal_state = "000001") THEN
                    ram_address <= std_logic_vector(unsigned(working_variables) + 4);
                    work_1_unsigned := unsigned(ram_buffer);
                ELSIF (internal_state = "000010") THEN
                    ram_address <= std_logic_vector(unsigned(working_variables) + 5);
                    work_2_unsigned := unsigned(ram_buffer);
                ELSIF (internal_state = "000011") THEN
                    ram_address <= std_logic_vector(unsigned(working_variabels) + 6);
                    work_3_unsigned := unsigned(ram_buffer);
                ELSE
                
                END IF;            
            ELSIF (sha_state = "0010") THEN
            
            ELSIF (sha_state = "0011") THEN
            
            ELSIF (sha_state = "0100") THEN
            
            ELSIF (sha_state = "0101") THEN
            
            ELSE
            
            END IF;
        END IF;    
    END PROCESS;
    read_memory: rom_controller
        PORT MAP(clock, rom_address, rom_reset, rom_buffer, rom_ready);
    write_memory: ram_controller
        PORT MAP(clock, ram_address, ram_read, ram_reset, ram_buffer, ram_ready);

END behavioral_8;
