----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 02:35:51 PM
-- Design Name: 
-- Module Name: hex_control - behavioral_3
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

ENTITY hex_control IS
    PORT    (digit_1 : IN std_logic_vector (3 DOWNTO 0);
             digit_2 : IN std_logic_vector (3 DOWNTO 0);
             digit_3 : IN std_logic_vector (3 DOWNTO 0);
             digit_4 : IN std_logic_vector (3 DOWNTO 0);
             refresh_counter : IN std_logic_vector (1 DOWNTO 0);
             display_digit : OUT std_logic_vector (3 DOWNTO 0));
END hex_control;

ARCHITECTURE behavioral_3 OF hex_control IS

BEGIN
    WITH refresh_counter SELECT
        display_digit <=    digit_1 WHEN "00", -- digit 1 value (right digit)
                            digit_2 WHEN "01", -- digit 2 value
                            digit_3 WHEN "10", -- digit 3 value
                            digit_4 WHEN "11", -- digit 4 value (left digit)
                            digit_1 WHEN OTHERS;
END behavioral_3;
