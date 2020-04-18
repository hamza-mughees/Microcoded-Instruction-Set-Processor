library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2to1 is
	port (
		s, in0, in1 : in std_logic;
		out1 : out std_logic
	);
end mux2to1;

architecture dataflow of mux2to1 is
begin
	out1 <= in0 after 5ns when s='0' else
			in1 after 5ns when s='1' else
			'0' after 5ns;
end dataflow;