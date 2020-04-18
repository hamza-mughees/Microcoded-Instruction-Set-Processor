library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shifter_4bit is
	port (
		b0, b1, b2, b3, lR, lL : in std_logic;
		s : in std_logic_vector (1 downto 0);
		outL, outR, h0, h1, h2, h3 : out std_logic
	);
end shifter_4bit;

architecture dataflow of shifter_4bit is
	component mux3to1 is
		port (
			in0, in1, in2 : in std_logic;
			s : in std_logic_vector (1 downto 0);
			z : out std_logic
		);
	end component;
begin
	mux00: mux3to1 port map (
		in0 => b0,
		in1 => b1,
		in2 => lL,
		s => s,
		z => h0
	);
	mux01: mux3to1 port map (
		in0 => b1,
		in1 => b2,
		in2 => b0,
		s => s,
		z => h1
	);
	mux02: mux3to1 port map (
		in0 => b2,
		in1 => b3,
		in2 => b1,
		s => s,
		z => h2
	);
	mux03: mux3to1 port map (
		in0 => b3,
		in1 => lR,
		in2 => b2,
		s => s,
		z => h3
	);
	
	outR <= b0;
	outL <= b3;
end dataflow;