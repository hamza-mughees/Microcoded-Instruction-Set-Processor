library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity shifter_16bit is
	port (
		b : in std_logic_vector (15 downto 0);
		h : out std_logic_vector (15 downto 0);
		s : in std_logic_vector (1 downto 0);
		constL, constR : in std_logic;
		outL, outR : out std_logic
	);
end shifter_16bit;

architecture dataflow of shifter_16bit is
	component shifter_4bit is
		port (
			b0, b1, b2, b3, lR, lL : in std_logic;
			s : in std_logic (1 downto 0);
			outL, outR, h0, h1, h2, h3 : out std_logic
		);
	end component;
	
	signal L0, L1, L2, R1, R2, R3 : std_logic;
begin
	shifter0: shifter_4bit port map (
		b0 => b(0),
		b1 => b(1),
		b2 => b(2),
		b3 => b(3),
		lR => R1,
		lL => constR,
		s => s,
		h0 => h(0),
		h1 => h(1),
		h2 => h(2),
		h3 => h(3),
		outL => L0,
		outR => outR
	);
	shifter1: shifter_4bit port map (
		b0 => b(4),
		b1 => b(5),
		b2 => b(6),
		b3 => b(7),
		lR => R2,
		lL => L0,
		s => s,
		h0 => h(4),
		h1 => h(5),
		h2 => h(6),
		h3 => h(7),
		outL => L1,
		outR => R1
	);
	shifter2: shifter_4bit port map (
		b0 => b(8),
		b1 => b(9),
		b2 => b(10),
		b3 => b(11),
		lR => R3,
		lL => L1,
		s => s,
		h0 => h(8),
		h1 => h(9),
		h2 => h(10),
		h3 => h(11),
		outL => L2,
		outR => R2
	);
	shifter3: shifter_4bit port map (
		b0 => b(12),
		b1 => b(13),
		b2 => b(14),
		b3 => b(15),
		lR => constL,
		lL => L2,
		s => s,
		h0 => h(12),
		h1 => h(13),
		h2 => h(14),
		h3 => h(15),
		outL => outL,
		outR => R3
	);
end dataflow;