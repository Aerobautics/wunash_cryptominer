----------------------------------------------------------------------------------
-- Company: Aerobotics
-- Engineer: Stewart Nash
-- 
-- Create Date: 01/03/2020 02:55:32 AM
-- Design Name: 
-- Module Name: alt_rom_memory - behavioral_9
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:  ROM Inference on an array in VHDL
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
USE ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY alt_rom_memory IS
    PORT (clock : IN std_logic;
          enable : IN std_logic;
          address : IN std_logic_vector(7 DOWNTO 0);
          data : OUT std_logic_vector(31 DOWNTO 0));
END alt_rom_memory;

ARCHITECTURE behavioral_9 OF alt_rom_memory IS
    TYPE rom_type IS ARRAY (71 DOWNTO 0) OF std_logic_vector(31 DOWNTO 0);
    SIGNAL rom : rom_type := (
                X"6a09e667", -- Hash value 0
                X"bb67ae85", -- Hash value 1
                X"3c6ef372", -- Hash value 2
                X"a54ff53a", -- Hash value 3
                X"510e527f", -- Hash value 4
                X"9b05688c", -- Hash value 5
                X"1f83d9ab", -- Hash value 6
                X"5be0cd19", -- Hash value 7
                
                X"428a2f98", -- Round constant 0
                X"71374491", -- Round constant 1
                X"b5c0fbcf", -- Round constant 2
                X"e9b5dba5", -- Round constant 3
                X"3956c25b", -- Round constant 4
                X"59f111f1", -- Round constant 5
                X"923f82a4", -- Round constant 6
                X"ab1c5ed5", -- Round constant 7
                
                X"d807aa98", -- Round constant 8
                X"12835b01", -- Round constant 9
                X"243185be", -- Round constant 10
                X"550c7dc3", -- Round constant 11
                X"72be5d74", -- Round constant 12
                X"80deb1fe", -- Round constant 13
                X"9bdc06a7", -- Round constant 14
                X"c19bf174", -- Round constant 15
                
                X"e49b69c1", -- Round constant 16
                X"efbe4786", -- Round constant 17
                X"0fc19dc6", -- Round constant 18
                X"240ca1cc", -- Round constant 19
                X"2de92c6f", -- Round constant 20
                X"4a7484aa", -- Round constant 21
                X"5cb0a9dc", -- Round constant 22
                X"76f988da", -- Round constant 23
                
                X"983e5152", -- Round constant 24
                X"a831c66d", -- Round constant 25
                X"b00327c8", -- Round constant 26
                X"bf597fc7", -- Round constant 27
                X"c6e00bf3", -- Round constant 28
                X"d5a79147", -- Round constant 29
                X"06ca6351", -- Round constant 30
                X"14292967", -- Round constant 31
                
                X"27b70a85", -- Round constant 32
                X"2e1b2138", -- Round constant 33
                X"4d2c6dfc", -- Round constant 34
                X"53380d13", -- Round constant 35
                X"650a7354", -- Round constant 36
                X"766a0abb", -- Round constant 37
                X"81c2c92e", -- Round constant 38
                X"92722c85", -- Round constant 39
                
                X"a2bfe8a1", -- Round constant 40
                X"a81a664b", -- Round constant 41
                X"c24b8b70", -- Round constant 42
                X"c76c51a3", -- Round constant 43
                X"d192e819", -- Round constant 44
                X"d6990624", -- Round constant 45
                X"f40e3585", -- Round constant 46
                X"106aa070", -- Round constant 47
                
                X"19a4c116", -- Round constant 48
                X"1e376c08", -- Round constant 49
                X"2748774c", -- Round constant 50
                X"34b0bcb5", -- Round constant 51
                X"391c0cb3", -- Round constant 52
                X"4ed8aa4a", -- Round constant 53
                X"5b9cca4f", -- Round constant 54
                X"682e6ff3", -- Round constant 55
                
                X"748f82ee", -- Round constant 56
                X"78a5636f", -- Round constant 57
                X"84c87814", -- Round constant 58
                X"8cc70208", -- Round constant 59
                X"90befffa", -- Round constant 60
                X"a4506ceb", -- Round constant 61
                X"bef9a3f7", -- Round constant 62
                X"c67178f2"  -- Round constant 63    
    );
    ATTRIBUTE rom_style : string;
    ATTRIBUTE rom_style OF rom : SIGNAL IS "block";
BEGIN
    PROCESS(clock)
    BEGIN
        IF rising_edge(clock) THEN
            IF (enable = '1') THEN
                data <= rom(conv_integer(address));
            END IF;
        END IF;    
    END PROCESS;


END behavioral_9;
