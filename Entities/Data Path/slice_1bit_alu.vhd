library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity slice_1bit_alu is
	port (
		c_in, a, b, s0, s1, s2 : in std_logic;
		c_out, g : out std_logic
	);
end slice_1bit_alu;

architecture dataflow of slice_1bit_alu is
	component arithmetic_circuit is
		port (
			s0, s1, c_in, a, b : in std_logic;
			c_out, g : out std_logic
		);
	end component;
	
	component slice_1bit_lu is
		port (
			s0, s1, a, b : in std_logic;
			g : out std_logic
		);
	end component;
	
	component mux2to1 is
		port (
			s, in0, in1 : in std_logic;
			out1 : out std_logic
		);
	end component;
	
	signal arith_out, logic_out : std_logic;
begin
	arith_circ: arithmetic_circuit port map (
		s0 => s0,
		s1 => s1,
		c_in => c_in,
		a => a,
		b => b,
		c_out => c_out,
		g => arith_out
	);
	
	logic_unit: slice_1bit_lu port map (
		s0 => s0,
		s1 => s1,
		a => a,
		b => b,
		g => logic_out
	);
	
	multiplexer: mux2to1 port map (
		s => s2,
		in0 => arith_out,
		in1 => logic_out,
		out1 => g
	);
end dataflow;