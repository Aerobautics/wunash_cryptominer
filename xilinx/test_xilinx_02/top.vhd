----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 04:56:42 PM
-- Design Name: 
-- Module Name: top - structural_1
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clock : in STD_LOGIC;
           led : out STD_LOGIC);
end top;

architecture structural_1 of top is
    component clock_divider
        Port ( clock : in STD_LOGIC;
               divided_clock : out STD_LOGIC);
    end component;
    begin
        CD0: clock_divider
            port map (clock, led);
end structural_1;
