----------------------------------------------------------------------------------
-- Company: Aerobotics 
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 08:44:32 PM
-- Design Name: 
-- Module Name: abacus - behavioral_5
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

ENTITY abacus IS
    PORT    (clock : IN std_logic;
             switch : IN std_logic_vector (15 DOWNTO 0);
             anode : OUT std_logic_vector (3 DOWNTO 0);
             cathode : OUT std_logic_vector (7 DOWNTO 0));             
END abacus;

ARCHITECTURE behavioral_5 OF abacus IS
    COMPONENT clock_divider
        PORT    (clock : IN std_logic;
                 divided_clock : OUT std_logic);
    END COMPONENT;
    COMPONENT refresh_counter
        PORT    (refresh_clock : IN std_logic;
                 refresh_count : OUT std_logic_vector (1 DOWNTO 0));
    END COMPONENT;      
    COMPONENT hex_control
        PORT    (digit_1 : IN std_logic_vector (3 DOWNTO 0);
                 digit_2 : IN std_logic_vector (3 DOWNTO 0);
                 digit_3 : IN std_logic_vector (3 DOWNTO 0);
                 digit_4 : IN std_logic_vector (3 DOWNTO 0);
                 refresh_counter : IN std_logic_vector (1 DOWNTO 0);
                 display_digit : OUT std_logic_vector (3 DOWNTO 0));
    END COMPONENT;
    COMPONENT anode_control
        PORT    (refresh_counter : IN std_logic_vector (1 DOWNTO 0);
                 anode : OUT std_logic_vector (3 DOWNTO 0));
    END COMPONENT;
    COMPONENT hex_cathode
        PORT    (digit : IN std_logic_vector (3 DOWNTO 0);
                 cathode : OUT std_logic_vector (7 DOWNTO 0));
    END COMPONENT;
    SIGNAL clock_output : std_logic;
    SIGNAL counter_output : std_logic_vector (1 DOWNTO 0);
    SIGNAL display : std_logic_vector(3 DOWNTO 0);
    SIGNAL switch_1 : std_logic_vector(3 DOWNTO 0);
    SIGNAL switch_2 : std_logic_vector(3 DOWNTO 0);
    SIGNAL switch_3 : std_logic_vector(3 DOWNTO 0);
    SIGNAL switch_4 : std_logic_vector(3 DOWNTO 0);
	--ALIAS switch_1: std_logic_vector(3 DOWNTO 0) IS switch(3 DOWNT0 0);	
	--ALIAS switch_2: std_logic_vector(3 DOWNTO 0) IS switch(7 DOWNT0 4);	
	--ALIAS switch_3 : std_logic_vector(3 DOWNTO 0) IS switch(11 DOWNT0 8);	
	--ALIAS switch_4 : std_logic_vector(3 DOWNTO 0) IS switch(15 DOWNT0 12);	              
    BEGIN 
        switch_1 <= switch(3 DOWNTO 0);
        switch_2 <= switch(7 DOWNTO 4);
        switch_3 <= switch(11 DOWNTO 8);
        switch_4 <= switch(15 DOWNTO 12);
        main_clock: clock_divider
            PORT MAP (clock, clock_output);
        refresher: refresh_counter
            PORT MAP (clock_output, counter_output);
        hex_controller: hex_control
            PORT MAP (switch_4, switch_3, switch_2, switch_1, counter_output, display);
        anode_controller: anode_control
            PORT MAP (counter_output, anode);
        cathode_controller: hex_cathode
            PORT MAP (display, cathode);
END behavioral_5;
