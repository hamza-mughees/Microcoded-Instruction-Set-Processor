library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity B_input_logic_adder is
	port (
		b, s0, s1 : in std_logic;
		z : out std_logic
	);
end B_input_logic_adder;

architecture dataflow of B_input_logic_adder is
begin
	z <= '0' after 5ns when s1='0' and s0='0' else
		 b after 5ns when s1='0' and s0='1' else
		 not b after 5ns when s1='1' and s0='0' else
		 '1' after 5ns when s1='1' and s0='1' else
		 '0' after 5ns;
end dataflow;