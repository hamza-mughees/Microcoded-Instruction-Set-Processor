library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_16bit is
	port (
		a, b : in std_logic_vector(15 downto 0);
		c_in, s0, s1, s2 : in std_logic;
		c_out : out std_logic;
		sum : out std_logic_vector(15 downto 0)
	);
end alu_16bit;

architecture dataflow of alu_16bit is
	component slice_1bit_alu is
		port (
			c_in, a, b, s0, s1, s2 : in std_logic;
			c_out, g : out std_logic
		);
	end component;
	
	signal c_out00, c_out01, c_out02, c_out03, c_out04, c_out05, c_out06, c_out07 : std_logic; 
	signal c_out08, c_out09, c_out10, c_out11, c_out12, c_out13, c_out14 : std_logic;
begin
	alu00: slice_1bit_alu port map (
		c_in => c_in,
		a => a(0),
		b => b(0),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out00,
		g => sum(0)
	);
	alu01: slice_1bit_alu port map (
		c_in => c_out00,
		a => a(1),
		b => b(1),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out01,
		g => sum(1)
	);
	alu02: slice_1bit_alu port map (
		c_in => c_out01,
		a => a(2),
		b => b(2),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out02,
		g => sum(2)
	);
	alu03: slice_1bit_alu port map (
		c_in => c_out02,
		a => a(3),
		b => b(3),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out03,
		g => sum(3)
	);
	alu04: slice_1bit_alu port map (
		c_in => c_out03,
		a => a(4),
		b => b(4),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out04,
		g => sum(4)
	);
	alu05: slice_1bit_alu port map (
		c_in => c_out04,
		a => a(5),
		b => b(5),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out05,
		g => sum(5)
	);
	alu06: slice_1bit_alu port map (
		c_in => c_out05,
		a => a(6),
		b => b(6),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out06,
		g => sum(6)
	);
	alu07: slice_1bit_alu port map (
		c_in => c_out06,
		a => a(7),
		b => b(7),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out07,
		g => sum(7)
	);
	alu08: slice_1bit_alu port map (
		c_in => c_out07,
		a => a(8),
		b => b(8),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out08,
		g => sum(8)
	);
	alu09: slice_1bit_alu port map (
		c_in => c_out08,
		a => a(9),
		b => b(9),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out09,
		g => sum(9)
	);
	alu10: slice_1bit_alu port map (
		c_in => c_out09,
		a => a(10),
		b => b(10),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out10,
		g => sum(10)
	);
	alu11: slice_1bit_alu port map (
		c_in => c_out10,
		a => a(11),
		b => b(11),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out11,
		g => sum(11)
	);
	alu12: slice_1bit_alu port map (
		c_in => c_out11,
		a => a(12),
		b => b(12),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out12,
		g => sum(12)
	);
	alu13: slice_1bit_alu port map (
		c_in => c_out12,
		a => a(13),
		b => b(13),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out13,
		g => sum(13)
	);
	alu14: slice_1bit_alu port map (
		c_in => c_out13,
		a => a(14),
		b => b(14),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out14,
		g => sum(14)
	);
	alu15: slice_1bit_alu port map (
		c_in => c_out14,
		a => a(15),
		b => b(15),
		s0 => s0,
		s1 => s1,
		s2 => s2,
		c_out => c_out,
		g => sum(15)
	);
end dataflow;