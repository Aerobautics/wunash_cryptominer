----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2020 06:17:16 PM
-- Design Name: 
-- Module Name: top - behavioral_8
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

ENTITY top IS
    PORT    (clock : IN std_logic;
             anode : OUT std_logic_vector(3 DOWNTO 0);
             cathode : OUT std_logic_vector(7 DOWNTO 0));
END top;

ARCHITECTURE behavioral_8 OF top IS
    COMPONENT display_buffer
        PORT    (clock : IN std_logic;
                 message : IN std_logic_vector(31 DOWNTO 0);
                 anode : OUT std_logic_vector(3 DOWNTO 0);
                 cathode : OUT std_logic_vector(7 DOWNTO 0));
    END COMPONENT;
    SIGNAL message : std_logic_vector (31 DOWNTO 0) := "00010010001101000101011001111000";    
BEGIN
    display: display_buffer
       PORT MAP(clock, message, anode, cathode);
END behavioral_8;
