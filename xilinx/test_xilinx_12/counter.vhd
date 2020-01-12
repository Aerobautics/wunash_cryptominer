----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2019 07:59:07 PM
-- Design Name: 
-- Module Name: counter - behavioral_2
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

ENTITY counter IS
    PORT    (clock : IN std_logic;
             anode : OUT std_logic_vector(3 DOWNTO 0);
             cathode : OUT std_logic_vector(7 DOWNTO 0));
END counter;

ARCHITECTURE behavioral_2 OF counter IS
    COMPONENT clock_divider
        PORT    (clock : IN std_logic;
                 period : IN std_logic_vector(15 DOWNTO 0);
                 divided_clock : OUT std_logic);
    END COMPONENT;
    COMPONENT refresh_counter
        PORT    (refresh_clock : IN std_logic;
                 refresh_count : OUT std_logic_vector(1 DOWNTO 0));
    END COMPONENT;
    COMPONENT hex_control
        PORT    (digit_1 : IN std_logic_vector(3 DOWNTO 0);
                 digit_2 : IN std_logic_vector(3 DOWNTO 0);
                 digit_3 : IN std_logic_vector(3 DOWNTO 0);
                 digit_4 : IN std_logic_vector(3 DOWNTO 0);
                 refresh_counter : IN std_logic_vector(1 DOWNTO 0);
                 display_digit : OUT std_logic_vector(3 DOWNTO 0));
    END COMPONENT;
    COMPONENT anode_control
        PORT    (refresh_counter : IN std_logic_vector(1 DOWNTO 0);
                 anode : OUT std_logic_vector(3 DOWNTO 0));
    END COMPONENT;
    COMPONENT hex_cathode
        PORT    (digit : IN std_logic_vector(3 DOWNTO 0);
                 cathode : OUT std_logic_vector(7 DOWNTO 0));
    END COMPONENT;
    COMPONENT memory_controller
        PORT    (clock : IN std_logic;
                 stored_value : OUT std_logic_vector(15 DOWNTO 0);
                 memory_address : OUT std_logic_vector(9 DOWNTO 0));
    END COMPONENT;
    COMPONENT ram_controller
        PORT    (clock : IN std_logic;
                 read_only : IN std_logic;
                 reset : IN std_logic;
                 address : IN std_logic_vector(9 DOWNTO 0);
                 data : IN std_logic_vector(15 DOWNTO 0);
                 data_buffer : OUT std_logic_vector(15 DOWNTO 0);
                 ready : OUT std_logic);
    END COMPONENT;
--    SIGNAL clock_output_1 : std_logic; -- 2 kHz
--    SIGNAL clock_output_2 : std_logic; -- 1 Hz
--    SIGNAL clock_output_3 : std_logic; -- 0.2 Hz = 12 cpm
    SIGNAL clock_output_1 : std_logic := '0'; -- 20 kHz
    SIGNAL clock_output_2 : std_logic := '0'; -- 1 kHz
    SIGNAL clock_output_3 : std_logic := '0'; -- 10 Hz   
    SIGNAL counter_output : std_logic_vector(1 DOWNTO 0);
    SIGNAL display : std_logic_vector(3 DOWNTO 0);
    SIGNAL memory_value :  std_logic_vector(15 DOWNTO 0);
    SIGNAL counter_value_1 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_2 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_3 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_4 : std_logic_vector(3 DOWNTO 0);
    
    SHARED VARIABLE address_result : unsigned(9 DOWNTO 0) := to_unsigned(0, 10);    
    SIGNAL memory_reset : std_logic := '1';
    SIGNAL read : std_logic := '0';
    SIGNAL ready : std_logic;
    SIGNAL address_buffer : std_logic_vector(9 DOWNTO 0) := "0000000000";
--    SIGNAL switch : std_logic_vector(15 DOWNTO 0);
    SIGNAL digits : std_logic_vector(15 DOWNTO 0);
BEGIN
--        clock_1: clock_divider
--            PORT MAP(clock, "1100001101010000", clock_output_1); -- 50,000 = 0b 1100 0011 0101 0000
--        clock_2: clock_divider
--            PORT MAP(clock_output_1,"0000011111010000", clock_output_2);  -- 2,0000 = 0b 0000 0111 1101 0000
--        clock_3: clock_divider
--            PORT MAP(clock_output_2,"0000000000000101", clock_output_3);  -- 5 = 0b 0000 0000 0110 0100
        clock_1: clock_divider
            PORT MAP(clock, "0000001111101000", clock_output_1); -- 1,000 = 0b 0000 0011 1110 1000
        clock_2: clock_divider
            PORT MAP(clock_output_1,"0000000011111010", clock_output_2);  -- 250 = 0b 0000 0000 1111 1010
        clock_3: clock_divider
            PORT MAP(clock_output_2,"0000000000110010", clock_output_3);  -- 50 = 0b 0000 0000 0011 0010
--        clock_3: clock_divider
--            PORT MAP(clock_output_2,"0000000000000101", clock_output_3);  -- 5 = 0b 0000 0000 0110 0100                        
        control_memory: memory_controller
            PORT MAP(clock_output_3, memory_value, address_buffer);
--            switch <= memory_value;
        memory: ram_controller
            PORT MAP(clock_output_1, read, memory_reset, address_buffer, memory_value, digits, ready);
            counter_value_1 <= digits(3 DOWNTO 0);
            counter_value_2 <= digits(7 DOWNTO 4);
            counter_value_3 <= digits(11 DOWNTO 8);
            counter_value_4 <= digits(15 DOWNTO 12);                                            
        refresher: refresh_counter
            PORT MAP(refresh_clock => clock_output_1, refresh_count => counter_output);
        hex_controller: hex_control
            PORT MAP(counter_value_1, counter_value_2, counter_value_3, counter_value_4, counter_output, display);
        anode_controller: anode_control
            PORT MAP (counter_output, anode);
        cathode_controller: hex_cathode
            PORT MAP(display, cathode);
    PROCESS (clock_output_3)
    BEGIN
        IF rising_edge(clock_output_3) THEN
            IF (ready = '1') THEN
                memory_reset <= NOT memory_reset;
            END IF;          
        END IF;    
    END PROCESS;
END behavioral_2;
