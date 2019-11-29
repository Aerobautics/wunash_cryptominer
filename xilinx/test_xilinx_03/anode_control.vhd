----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 01:39:38 PM
-- Design Name: 
-- Module Name: anode_control - behavioral_2
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

ENTITY anode_control IS
    PORT    (refresh_counter : IN std_logic_vector (1 DOWNTO 0);
             anode : OUT std_logic_vector (3 DOWNTO 0));
END anode_control;

ARCHITECTURE behavioral_2 OF anode_control IS

BEGIN
    WITH refresh_counter SELECT
        anode <=    "1110" WHEN "00", -- digit 1 on (right digit)
                    "1101" WHEN "01", -- digit 2 on
                    "1011" WHEN "10", -- digit 3 on
                    "0111" WHEN "11", -- digit 4 on (left digit)
                    "0000" WHEN OTHERS;
END behavioral_2;
