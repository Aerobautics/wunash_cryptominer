----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/02/2020 09:55:32 AM
-- Design Name: 
-- Module Name: rom_memory - Behavioral
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

ENTITY rom_memory IS
    PORT (clock : IN std_logic;
          enable : IN std_logic;
          address : IN std_logic_vector(7 DOWNTO 0);
          data : OUT std_logic_vector(31 DOWNTO 0));
END rom_memory;

ARCHITECTURE behavioral_6 OF rom_memory IS

BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            CASE address IS
                WHEN X"00" => data <= X"6a09e667"; -- Hash value 0
                WHEN X"01" => data <= X"bb67ae85"; -- Hash value 1
                WHEN X"02" => data <= X"3c6ef372"; -- Hash value 2
                WHEN X"03" => data <= X"a54ff53a"; -- Hash value 3
                WHEN X"04" => data <= X"510e527f"; -- Hash value 4
                WHEN X"05" => data <= X"9b05688c"; -- Hash value 5
                WHEN X"06" => data <= X"1f83d9ab"; -- Hash value 6
                WHEN X"07" => data <= X"5be0cd19"; -- Hash value 7
                
                WHEN X"08" => data <= X"428a2f98"; -- Round constant 0
                WHEN X"09" => data <= X"71374491"; -- Round constant 1
                WHEN X"0a" => data <= X"b5c0fbcf"; -- Round constant 2
                WHEN X"0b" => data <= X"e9b5dba5"; -- Round constant 3
                WHEN X"0c" => data <= X"3956c25b"; -- Round constant 4
                WHEN X"0d" => data <= X"59f111f1"; -- Round constant 5
                WHEN X"0e" => data <= X"923f82a4"; -- Round constant 6
                WHEN X"0f" => data <= X"ab1c5ed5"; -- Round constant 7
                
                WHEN X"10" => data <= X"d807aa98"; -- Round constant 8
                WHEN X"11" => data <= X"12835b01"; -- Round constant 9
                WHEN X"12" => data <= X"243185be"; -- Round constant 10
                WHEN X"13" => data <= X"550c7dc3"; -- Round constant 11
                WHEN X"14" => data <= X"72be5d74"; -- Round constant 12
                WHEN X"15" => data <= X"80deb1fe"; -- Round constant 13
                WHEN X"16" => data <= X"9bdc06a7"; -- Round constant 14
                WHEN X"17" => data <= X"c19bf174"; -- Round constant 15
                
                WHEN X"18" => data <= X"e49b69c1"; -- Round constant 16
                WHEN X"19" => data <= X"efbe4786"; -- Round constant 17
                WHEN X"1a" => data <= X"0fc19dc6"; -- Round constant 18
                WHEN X"1b" => data <= X"240ca1cc"; -- Round constant 19
                WHEN X"1c" => data <= X"2de92c6f"; -- Round constant 20
                WHEN X"1d" => data <= X"4a7484aa"; -- Round constant 21
                WHEN X"1e" => data <= X"5cb0a9dc"; -- Round constant 22
                WHEN X"1f" => data <= X"76f988da"; -- Round constant 23
                
                WHEN X"20" => data <= X"983e5152"; -- Round constant 24
                WHEN X"21" => data <= X"a831c66d"; -- Round constant 25
                WHEN X"22" => data <= X"b00327c8"; -- Round constant 26
                WHEN X"23" => data <= X"bf597fc7"; -- Round constant 27
                WHEN X"24" => data <= X"c6e00bf3"; -- Round constant 28
                WHEN X"25" => data <= X"d5a79147"; -- Round constant 29
                WHEN X"26" => data <= X"06ca6351"; -- Round constant 30
                WHEN X"27" => data <= X"14292967"; -- Round constant 31
                
                WHEN X"28" => data <= X"27b70a85"; -- Round constant 32
                WHEN X"29" => data <= X"2e1b2138"; -- Round constant 33
                WHEN X"2a" => data <= X"4d2c6dfc"; -- Round constant 34
                WHEN X"2b" => data <= X"53380d13"; -- Round constant 35
                WHEN X"2c" => data <= X"650a7354"; -- Round constant 36
                WHEN X"2d" => data <= X"766a0abb"; -- Round constant 37
                WHEN X"2e" => data <= X"81c2c92e"; -- Round constant 38
                WHEN X"2f" => data <= X"92722c85"; -- Round constant 39
                
                WHEN X"30" => data <= X"a2bfe8a1"; -- Round constant 40
                WHEN X"31" => data <= X"a81a664b"; -- Round constant 41
                WHEN X"32" => data <= X"c24b8b70"; -- Round constant 42
                WHEN X"33" => data <= X"c76c51a3"; -- Round constant 43
                WHEN X"34" => data <= X"d192e819"; -- Round constant 44
                WHEN X"35" => data <= X"d6990624"; -- Round constant 45
                WHEN X"36" => data <= X"f40e3585"; -- Round constant 46
                WHEN X"37" => data <= X"106aa070"; -- Round constant 47
                
                WHEN X"38" => data <= X"19a4c116"; -- Round constant 48
                WHEN X"39" => data <= X"1e376c08"; -- Round constant 49
                WHEN X"3a" => data <= X"2748774c"; -- Round constant 50
                WHEN X"3b" => data <= X"34b0bcb5"; -- Round constant 51
                WHEN X"3c" => data <= X"391c0cb3"; -- Round constant 52
                WHEN X"3d" => data <= X"4ed8aa4a"; -- Round constant 53
                WHEN X"3e" => data <= X"5b9cca4f"; -- Round constant 54
                WHEN X"3f" => data <= X"682e6ff3"; -- Round constant 55
                
                WHEN X"40" => data <= X"748f82ee"; -- Round constant 56
                WHEN X"41" => data <= X"78a5636f"; -- Round constant 57
                WHEN X"42" => data <= X"84c87814"; -- Round constant 58
                WHEN X"43" => data <= X"8cc70208"; -- Round constant 59
                WHEN X"44" => data <= X"90befffa"; -- Round constant 60
                WHEN X"45" => data <= X"a4506ceb"; -- Round constant 61
                WHEN X"46" => data <= X"bef9a3f7"; -- Round constant 62
                WHEN X"47" => data <= X"c67178f2"; -- Round constant 63
                
                WHEN OTHERS => data <= X"00000000";
            END CASE;
        END IF;    
    END PROCESS;


END behavioral_6;
