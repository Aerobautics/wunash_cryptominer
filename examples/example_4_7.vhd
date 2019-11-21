-- 2-to-4-Line Decoder with Enable: Structural VHDL Description
-- (From Mano and Kime, requires lcdf_vhdl.func_prims library)
library ieee, lcdf_vhdl;
use ieee.std_logic_1164.all, lcdf_vdhl.func_prims.all;
entity decoder_2_to_4_w_enable is
	port (EN, A0, A1: in std_logic;
		D0, D1, D2, D3: out std_logic);
end decoder_2_to_4_w_enable;

architecture structural_1 of decoder_2_to_4_w_enable is
	component NOT1
		port(in1: in std_logic;
			out1: out std_logic);
	end component;
	component AND2
		port(in1, in2: in std_logic;
			out1: out std_logic);
	end component;
	signal A0_n, A1_n, N0, N1, N2, N3: std_logic;
	begin
		g0: NOT1 port map (in1 => A0, out1 => A0_n);
		g1: NOT1 port map (in1 => A1, out1 => A1_n);
		g2: AND2 port map (in1 => A0_n, in2 => A1_n, out1 => N0);
		g3: AND2 port map (in1 => A0, in2 => A1_N, out1 => N1);
		g4: AND2 port map (in1 => A0_n, in2 => A1, out1 => N2);
		g5: AND2 port map (in1 => A0, in2 => A1, out1 => N3);
		g6: AND2 port map (in1 => EN, in2 => N0, out1 => D0);
		g7: AND2 port map (in1 => EN, in2 => N1, out1 => D1);
		g8: AND2 port map (in1 => EN, in2 => N2, out1 => D2);
		g9: AND2 port map (in1 => EN, in2 => N3, out1 => D3);
end structural_1;
