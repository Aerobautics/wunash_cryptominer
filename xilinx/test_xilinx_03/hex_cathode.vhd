----------------------------------------------------------------------------------
-- Company: Aerobotics 
-- Engineer: Stewart Nash
-- 
-- Create Date: 11/28/2019 03:47:46 PM
-- Design Name: 
-- Module Name: hex_cathode - behavioral_4
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

ENTITY hex_cathode IS
    PORT    (digit : IN std_logic_vector (3 DOWNTO 0);
             cathode : OUT std_logic_vector (7 DOWNTO 0));
END hex_cathode;

ARCHITECTURE behavioral_4 OF hex_cathode IS

BEGIN
    WITH digit SELECT
        cathode <=  "11000000" WHEN "0000", -- zero
                    "11111001" WHEN "0001", -- one
                    "10100100" WHEN "0010", -- two
                    "10110000" WHEN "0011", -- three
                    "10011001" WHEN "0100", -- four
                    "10010010" WHEN "0101", -- five
                    "10000010" WHEN "0110", -- six
                    "11111000" WHEN "0111", -- seven
                    "10000000" WHEN "1000", -- eight
                    "10010000" WHEN "1001", -- nine
                    "10001000" WHEN "1010", -- ten
                    "10000011" WHEN "1011", -- eleven
                    "10100111" WHEN "1100", -- twelve
                    "10100001" WHEN "1101", -- thirteen
                    "10000110" WHEN "1110", -- fourteen
                    "10001110" WHEN "1111", -- fifteen                    
                    "11000000" WHEN OTHERS;
END behavioral_4;
