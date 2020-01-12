----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 01/02/2020 05:26:01 PM
-- Design Name: 
-- Module Name: display_buffer - behavioral_8
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

ENTITY display_buffer IS
    PORT    (clock : IN std_logic;
             message : IN std_logic_vector(31 DOWNTO 0);
             anode : OUT std_logic_vector(3 DOWNTO 0);
             cathode : OUT std_logic_vector(7 DOWNTO 0));
END display_buffer;

ARCHITECTURE behavioral_8 OF display_buffer IS
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
    SHARED VARIABLE message_offset : unsigned(2 DOWNTO 0) := to_unsigned(0, 3);    
        
    SIGNAL clock_output_1 : std_logic := '0'; -- ?? kHz
    SIGNAL clock_output_2 : std_logic := '0'; -- ?? kHz
    SIGNAL clock_output_3 : std_logic := '0'; -- ?? Hz
    SIGNAL counter_output : std_logic_vector(1 DOWNTO 0);
    SIGNAL display : std_logic_vector(3 DOWNTO 0);
    SIGNAL display_1 : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL display_2 : std_logic_vector(3 DOWNTO 0) := "0000";               
    SIGNAL display_3 : std_logic_vector(3 DOWNTO 0) := "0000";
    SIGNAL display_4 : std_logic_vector(3 DOWNTO 0) := "0000";
BEGIN
    PROCESS(clock_output_3)
    BEGIN
        IF rising_edge(clock_output_3) THEN
            IF (message_offset = "000") THEN
                display_1 <= message(3 DOWNTO 0);
                display_2 <= message(7 DOWNTO 4);                
                display_3 <= message(11 DOWNTO 8);
                display_4 <= message(15 DOWNTO 12);                            
            ELSIF (message_offset = "001") THEN
                display_1 <= message(7 DOWNTO 4);                
                display_2 <= message(11 DOWNTO 8);
                display_3 <= message(15 DOWNTO 12);
                display_4 <= message(19 DOWNTO 16);                              
            ELSIF (message_offset = "010") THEN               
                display_1 <= message(11 DOWNTO 8);
                display_2 <= message(15 DOWNTO 12);
                display_3 <= message(19 DOWNTO 16);
                display_4 <= message(23 DOWNTO 20);             
            ELSIF (message_offset = "011") THEN
                display_1 <= message(15 DOWNTO 12);
                display_2 <= message(19 DOWNTO 16);
                display_3 <= message(23 DOWNTO 20);               
                display_4 <= message(27 DOWNTO 24);            
            ELSIF (message_offset = "100") THEN
                display_1 <= message(19 DOWNTO 16);
                display_2 <= message(23 DOWNTO 20);               
                display_3 <= message(27 DOWNTO 24);
                display_4 <= message(31 DOWNTO 28);            
            ELSE
                display_1 <= message(3 DOWNTO 0);
                display_2 <= message(7 DOWNTO 4);                
                display_3 <= message(11 DOWNTO 8);
                display_4 <= message(15 DOWNTO 12);
                message_offset := to_unsigned(0, 3);            
            END IF;
            message_offset := message_offset + 1;
        END IF;    
    END PROCESS;
    clock_1: clock_divider
        PORT MAP(clock, "0000001111101000", clock_output_1); -- 1,000 = 0b 0000 0011 1110 1000
    clock_2: clock_divider
        PORT MAP(clock_output_1,"0000000011111010", clock_output_2);  -- 250 = 0b 0000 0000 1111 1010
    clock_3: clock_divider
        PORT MAP(clock_output_2,"0000000000110010", clock_output_3);  -- 50 = 0b 0000 0000 0011 0010
--    clock_3: clock_divider
--        PORT MAP(clock_output_2,"0000000000000101", clock_output_3);  -- 5 = 0b 0000 0000 0110 0100    
    refresher: refresh_counter
       PORT MAP(refresh_clock => clock_output_1, refresh_count => counter_output);
    hex_controller: hex_control
        PORT MAP(display_4, display_3, display_2, display_1, counter_output, display);
    anode_controller: anode_control
       PORT MAP (counter_output, anode);
    cathode_controller: hex_cathode
        PORT MAP(display, cathode);    
END behavioral_8;
