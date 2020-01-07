----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2019 03:05:50 AM
-- Design Name: 
-- Module Name: single_memory - behavioral_1
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

-- Single-Port Block RAM Read-First Mode
-- Single-Port Block RAM Write-First Mode

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY single_memory IS
    PORT(
        clock : IN std_logic;
        write_enable : IN std_logic;
        enable : IN std_logic;
        address : IN std_logic_vector(9 DOWNTO 0);
        data_in : IN std_logic_vector(15 DOWNTO 0);
        data_out : OUT std_logic_vector(15 DOWNTO 0)
    );
END single_memory;

ARCHITECTURE behavioral_1 OF single_memory IS
    TYPE ram_type IS ARRAY (1023 DOWNTO 0) OF std_logic_vector(15 DOWNTO 0);
    SIGNAL ram : ram_type;
BEGIN
    PROCESS(clock)
    BEGIN
        IF clock'EVENT AND clock = '1' THEN
            -- Read-First Mode
            --IF enable = '1' THEN
            --    IF write_enable = '1' THEN
            --        ram(to_integer(unsigned(address))) <= data_in;
            --    END IF;
            --    data_out <= ram(to_integer(unsigned(address)));
            --END IF;
            -- Write-First Mode
            IF enable = '1' THEN
                IF write_enable = '1' THEN
                    ram(to_integer(unsigned(address))) <= data_in;
                    data_out <= data_in;
                ELSE
                    data_out <= ram(to_integer(unsigned(address)));
                END IF;
            END IF; 
        END IF;
    END PROCESS;
END behavioral_1;
