-- Generate a new library called lcdf_vhdl in your VHDL project directory.
-- Compile the VHDL package file func_prims.vhd using lcdf_vhdl as the work directory

-- Functional VHDL Components Package
-- This package contains primitive gates
-- without delay for use in structural VHDL designs.

library ieee;
use ieee.std_logic_1164.all;

package func_prims is

component and2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;
 
component and3
   port(in1, in2, in3 : in std_logic;
        out1: out std_logic);
end component;
 	
component and4
   port(in1, in2, in3, in4 : in std_logic;
        out1: out std_logic);
end component; 

component and5
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1: out std_logic);
end component;

component inverter
   port(in1: in std_logic; out1: out std_logic);
end component;
 
component or2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;
 
component or3
   port(in1, in2, in3 : in std_logic;
        out1: out std_logic);
end component;
 	
component or4
   port(in1, in2, in3, in4 : in std_logic;
        out1: out std_logic);
end component; 

component or5
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1: out std_logic);
end component;

component nand2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;
  
component nand3
   port(in1, in2, in3 : in std_logic;
        out1: out std_logic);
end component;
 	
component nand4
   port(in1, in2, in3, in4 : in std_logic;
        out1: out std_logic);
end component;
 
component nand5
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1: out std_logic);
end component;

component nand6
   port(in1, in2, in3, in4, in5, in6: in std_logic;
        out1: out std_logic);
end component;
 
component nor2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;
 
component nor3
   port(in1, in2, in3 : in std_logic;
        out1: out std_logic);
end component; 
	
component nor4
   port(in1, in2, in3, in4 : in std_logic;
        out1: out std_logic);
end component; 

component nor5
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1: out std_logic);
end component;

component not1
   port(in1: in std_logic; out1: out std_logic);
end component;

component xor2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;

component xnor2
   port(in1, in2: in std_logic;
        out1: out std_logic);
end component;
 
end func_prims;

library ieee;
use ieee.std_logic_1164.all;
entity and2 is
   port(in1, in2 : in std_logic;
        out1 : out std_logic);
end and2;

architecture concurrent of and2 is
begin
   out1 <= in1 and in2;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity and3 is
   port(in1, in2, in3 : in std_logic;
        out1 : out std_logic);
end and3;

architecture concurrent of and3 is
begin
   out1 <= in1 and in2 and in3;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity and4 is
   port(in1, in2, in3, in4: in std_logic;
        out1 : out std_logic);
end and4;

architecture concurrent of and4 is
begin
   out1 <= in1 and in2 and in3 and in4;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity and5 is
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1 : out std_logic);
end and5;

architecture concurrent of and5 is
begin
   out1 <= in1 and in2 and in3 and in4 and in5;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity or2 is
   port(in1, in2: in std_logic;
        out1 : out std_logic);
end or2;

architecture concurrent of or2 is
begin
   out1 <= in1 or in2;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity or3 is
   port(in1, in2, in3 : in std_logic;
        out1 : out std_logic);
end or3;

architecture concurrent of or3 is
begin
   out1 <= in1 or in2 or in3;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity or4 is
   port(in1, in2, in3, in4: in std_logic;
        out1 : out std_logic);
end or4;

architecture concurrent of or4 is
begin
   out1 <= in1 or in2 or in3 or in4;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity or5 is
   port(in1, in2, in3, in4, in5 : in std_logic;
        out1 : out std_logic);
end or5;

architecture concurrent of or5 is
begin
   out1 <= in1 or in2 or in3 or in4 or in5;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity inverter is
   port(in1 : in std_logic;
        out1 : out std_logic);
end inverter;

architecture concurrent of inverter is
begin
   out1 <= not in1;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nand2 is
   port(in1, in2: in std_logic;
        out1 : out std_logic);
end nand2;

architecture concurrent of nand2 is
begin
   out1 <= not (in1 and in2);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nand3 is
   port(in1, in2, in3 : in std_logic;
        out1 : out std_logic);
end nand3;

architecture concurrent of nand3 is
begin
   out1 <= not (in1 and in2 and in3);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nand4 is
   port(in1, in2, in3, in4: in std_logic;
        out1 : out std_logic);
end nand4;

architecture concurrent of nand4 is
begin
   out1 <= not (in1 and in2 and in3 and in4);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nand5 is
   port (in1, in2, in3, in4, in5 : in std_logic;
        out1 : out std_logic);
end nand5;

architecture concurrent of nand5 is
begin
   out1 <= not (in1 and in2 and in3 and in4 and in5);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nor2 is
   port(in1, in2: in std_logic;
        out1 : out std_logic);
end nor2;

architecture concurrent of nor2 is
begin
   out1 <= in1 nor in2;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nor3 is
   port(in1, in2, in3 : in std_logic;
        out1 : out std_logic);
end nor3;

architecture concurrent of nor3 is
begin
   out1 <= not (in1 or in2 or in3);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nor4 is
   port(in1, in2, in3, in4: in std_logic;
        out1 : out std_logic);
end nor4;

architecture concurrent of nor4 is
begin
   out1 <= not (in1 or in2 or in3 or in4);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity nor5 is
   port (in1, in2, in3, in4, in5 : in std_logic;
        out1 : out std_logic);
end nor5;

architecture concurrent of nor5 is
begin
   out1 <= not (in1 or in2 or in3 or in4 or in5);
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity not1 is
   port(in1 : in std_logic;
        out1 : out std_logic);
end not1;

architecture concurrent of not1 is
begin
   out1 <= not in1;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity not1 is
   port(in1 : in std_logic;
        out1 : out std_logic);
end not1;

architecture concurrent of not1 is
begin
   out1 <= not in1;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity xor2 is
   port(in1, in2 : in std_logic;
        out1 : out std_logic);
end xor2;

architecture concurrent of xor2 is
begin
   out1 <= in1 xor in2;
end concurrent;

library ieee;
use ieee.std_logic_1164.all;
entity xnor2 is
   port(in1, in2 : in std_logic;
        out1 : out std_logic);
end xnor2;

architecture concurrent of xnor2 is
begin
   out1 <= not (in1 xor in2);
end concurrent;
