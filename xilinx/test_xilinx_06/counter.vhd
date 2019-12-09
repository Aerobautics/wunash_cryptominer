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


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

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
                 memory_clock : IN std_logic;
                 stored_value : OUT std_logic_vector(15 DOWNTO 0));
        END COMPONENT;
    SIGNAL clock_output_1 : std_logic; -- 2 kHz
    SIGNAL clock_output_2 : std_logic; -- 1 Hz
    SIGNAL clock_output_3 : std_logic; -- 0.2 Hz = 12 cpm
    SIGNAL counter_output : std_logic_vector(1 DOWNTO 0);
    SIGNAL display : std_logic_vector(3 DOWNTO 0);
    SIGNAL memory_value :  std_logic_vector(15 DOWNTO 0);
    SIGNAL counter_value_1 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_2 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_3 : std_logic_vector(3 DOWNTO 0);
    SIGNAL counter_value_4 : std_logic_vector(3 DOWNTO 0);
BEGIN
        clock_1: clock_divider
            PORT MAP(clock, "1100001101010000", clock_output_1); -- 50,0000 = 0b 1100 0011 0101 0000
        clock_2: clock_divider
            PORT MAP(clock_output_1,"0000011111010000", clock_output_2);  -- 2,0000 = 0b 0000 0111 1101 0000
        clock_3: clock_divider
            PORT MAP(clock_output_2,"0000000000000101", clock_output_3);  -- 5 = 0b 0000 0000 0000 0101
        memory_control: memory_controller
            PORT MAP(clock_output_3, clock_output_2, memory_value);
            counter_value_1 <= memory_value(3 DOWNTO 0);
            counter_value_2 <= memory_value(7 DOWNTO 4);
            counter_value_3 <= memory_value(11 DOWNTO 8);
            counter_value_4 <= memory_value(15 DOWNTO 12);                        
        refresher: refresh_counter
            PORT MAP(clock_output_1, counter_output);
        hex_controller: hex_control
            PORT MAP(counter_value_4, counter_value_3, counter_value_2, counter_value_1, counter_output, display);
        anode_controller: anode_control
            PORT MAP (counter_output, anode);
        cathode_controller: hex_cathode
            PORT MAP(display, cathode);
END behavioral_2;
