-- 4-bit Adder: Heirarchical Dataflow w/ Structural
-- (From Mano and Kime)
library ieee;
use ieee.std_logic_1164.all;
entity half_adder is
	port	(x, y : in std_logic;
		 s, c : out std_logic);
end half_adder;

architecture dataflow_3 of half_adder is
	begin
		s <= x xor y;
		c <= x and y;
end dataflow_3;

library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
	port	(x, y, z : in std_logic;
		 s, c : out std_logic);
end full_adder;

architecture struc_dataflow_3 of full_adder is
	component half_adder
		port	(x, y : in std_logic;
			 s, c : out std_logic);
	end component;
	signal hs, hc,  tc: std_logic;
	begin
		HA1: half_adder
			port map (x, y, hs, hc);
		HA2: half_adder
			port map (hs, z, s, tc);
		c <= tc or hc;
	end struc_dataflow_3;

library ieee;
use ieee.std_logic_1164.all;
entity adder_4 is
	port	(B, A : in std_logic_vector(3 downto 0);
		 C0 : in std_logic;
		 S : out std_logic_vector(3 downto 0);
		 C4 : out std_logic);
end adder_4;

architecture structural_4 of adder_4 is
	component full_adder
		port	(x, y, z : in std_logic;
			 s, c : out std_logic);
	end component;
	signal C: std_logic_vector(4 downto 0);
	begin
		Bit0: full_adder
			port map (B(0), A(0), C(0), S(0), C(1));
		Bit1: full_adder
			port map (B(1), A(1), C(1), S(1), C(2));
		Bit2: full_adder
			port map (B(2), A(2), C(2), S(2), C(3));
		Bit3: full_adder
			port map (B(3), A(3), C(3), S(3), C(4));
		C(0) <= C0;
		C4 <= C(4);
end structural_4;
