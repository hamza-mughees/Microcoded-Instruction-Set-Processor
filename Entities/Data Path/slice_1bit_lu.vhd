library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slice_1bit_lu is
	port (
		s0, s1, a, b : in std_logic;
		g : out std_logic
	);
end slice_1bit_lu;

architecture dataflow of slice_1bit_lu is
	component mux4to1 is
		port (
			s0, s1, in0, in1, in2, in3 : in std_logic;
			out1 : out std_logic
		);
	end component;
	
	signal and_out, or_out, xor_out, not_out : std_logic;
begin
	and_out <= a and b after 5ns;
	or_out <= a or b after 5ns;
	xor_out <= a xor b after 5ns;
	not_out <= not a after 5ns;

	multiplexer: mux4to1 port map (
		s0 => s0,
		s1 => s1,
		in0 => and_out,
		in1 => or_out,
		in2 => xor_out,
		in3 => not_out,
		out1 => g
	);
end dataflow;