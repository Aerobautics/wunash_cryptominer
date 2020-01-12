----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/01/2020 03:36:15 PM
-- Design Name: 
-- Module Name: testbench - behavioral_6
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY testbench IS
--    PORT (anode : IN std_logic_vector (4 DOWNTO 0);
--          cathode : IN std_logic_vector (7 DOWNTO 0);
--          clock : OUT std_logic);
END testbench;

ARCHITECTURE behavioral_3 OF testbench IS

    -- Component declaration for UUT (unit under test)
    COMPONENT counter
    PORT    (clock : IN std_logic;
             anode : OUT std_logic_vector (3 DOWNTO 0);
             cathode : OUT std_logic_vector (7 DOWNTO 0));
    END COMPONENT;
    SIGNAL output_clock : std_logic := '0';
    SIGNAL anode : std_logic_vector (3 DOWNTO 0);
    SIGNAL cathode : std_logic_vector (7 DOWNTO 0);
BEGIN
    -- Instantiate the UUT
    test_counter: counter
        PORT MAP    (output_clock,
                     anode,
                     cathode);
    PROCESS
    BEGIN
        wait for 10 ns;
        output_clock <= NOT output_clock;
    END PROCESS;
END behavioral_3;