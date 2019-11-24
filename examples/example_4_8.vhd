-- 4-to-1-Line Multiplexer: Structural VHDL Description
-- (From Mano and Kime, requires lcdf_vhdl library)
library ieee, lcdf_vhdl;
use ieee.std_logic_1164.all, lcdf_vhdl.func_prims.all;
use ieee.std_logic_1164.all, lcdf_vhdl.func_prims.all;
entity multiplexer_4_to_1_st is
	port	(S: in std_logic_vector(0 to 1);
		 I: in std_logic_vector(0 to 3);
		 Y: out std_logic);
end multiplexer_4_to_1_st;

architecture structural_2 of multiplexer_4_to_1_st is
	component NOT1
		port(in1: in std_logic;
			out1: out std_logic);
	end component;
	component AND2
		port(in1, in2: in std_logic;
			out1: out std_logic);
	end component;
	component OR4
		port(in1, in2, in3, in4: in std_logic;
			out1: out std_logic);
	end component;
	signal S_n: std_logic_vector(0 to 1);
	signal D, N: std_logic_vector(0 to 3);
	begin
		g0: NOT1 port map (S(0), S_n(0));
		g1: NOT1 port map (S(1), S_n(10));
		g2: AND2 port map (S_n(1), S_n(0), D(0));
		g3: AND2 port map (S_n(1), S(0), D(1));
		g4: AND2 port map (S(1), S_n(0), D(2));
		g5: AND2 port map (S(1), S(0), D(3));
		g6: AND2 port map (D(0), I(0), N(0));
		g7: AND2 port map (D(1), I(1), N(1));
		g8: AND2 port map (D(2), I(2), N(2));
		g9: AND2 port map (D(3), I(3), N(3));
		g10: OR4 port map (N(0), N(1), N(2), N(3), Y);
	end structural_2;
