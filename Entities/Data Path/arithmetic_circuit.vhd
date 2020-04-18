library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity arithmetic_circuit is
	port (
		s0, s1, c_in, a, b : in std_logic;
		c_out, g : out std_logic
	);
end arithmetic_circuit;

architecture dataflow of arithmetic_circuit is
	component B_input_logic_adder is
		port (
			b, s0, s1 : in std_logic;
			z : out std_logic
		);
	end component;
	
	component full_adder is
		port (
			in1, in2, c_in : in std_logic;
			sum, c_out : out std_logic
		);
	end component;
	
	signal b_logic_out : std_logic;
begin
	b_logic_adder: B_input_logic_adder port map (
		b => b,
		s0 => s0,
		s1 => s1,
		z => b_logic_out
	);
	
	adder: full_adder port map (
		in1 => a,
		in2 => b_logic_out,
		c_in => c_in,
		sum => g,
		c_out => c_out
	);
end dataflow;