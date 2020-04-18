library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux3to1 is
	port (
		in0, in1, in2 : in std_logic;
		s : in std_logic_vector (1 downto 0);
		z : out std_logic
	);
end mux3to1;

architecture dataflow of mux3to1 is
begin
	z <= in0 after 5ns when s="00" else
		 in1 after 5ns when s="01" else
		 in2 after 5ns when s="10" else
		 '0' after 5ns;
end dataflow;