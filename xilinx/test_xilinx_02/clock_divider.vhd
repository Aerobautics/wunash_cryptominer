----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 05:00:43 PM
-- Design Name: 
-- Module Name: clock_divider - structural_2
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

entity clock_divider is
    Port ( clock : in STD_LOGIC;
           divided_clock : out STD_LOGIC);
end clock_divider;

architecture structural_2 of clock_divider is
 shared variable counter_value : integer := 0;
 signal clock_buffer : std_logic := '0';
begin
    process(clock)
    constant clock_period : integer := 500000000; -- 1 Hz?
    begin
        if rising_edge(clock) then
            if counter_value = clock_period then
                counter_value := 0;
                clock_buffer <= not clock_buffer;
                divided_clock <= clock_buffer;
            else
                counter_value := counter_value + 1;
                clock_buffer <= clock_buffer;
                divided_clock <= clock_buffer;
            end if;                
        end if;
    end process;
end structural_2;
