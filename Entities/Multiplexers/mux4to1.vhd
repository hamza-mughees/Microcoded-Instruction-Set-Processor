library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux4to1 is
	port (
		s0, s1, in0, in1, in2, in3 : in std_logic;
		out1 : out std_logic
	);
end mux4to1;

architecture dataflow of mux4to1 is
begin
	out1 <= in0 after 5ns when s1='0' and s0='0' else
			in1 after 5ns when s1='0' and s0='1' else
			in2 after 5ns when s1='1' and s0='0' else
			in3 after 5ns when s1='1' and s0='1' else
			'0' after 5ns;
end dataflow;