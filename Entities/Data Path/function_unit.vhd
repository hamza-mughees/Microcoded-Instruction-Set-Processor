library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity function_unit is
	port (
		a, b : in std_logic_vector (15 downto 0);
		fs : in std_logic_vector (4 downto 0);
		g : out std_logic_vector (15 downto 0);
		v, c, n, z : out std_logic
	);
end function_unit;

architecture dataflow of function_unit is
	component alu_16bit is
		port (
			a, b : in std_logic_vector(15 downto 0);
			c_in, s0, s1, s2 : in std_logic;
			c_out : out std_logic;
			sum : out std_logic_vector(15 downto 0)
		);
	end component;

	component shifter_16bit is
		port (
			b : in std_logic_vector (15 downto 0);
			h : out std_logic_vector (15 downto 0);
			s : in std_logic_vector (1 downto 0);
			constL, constR : in std_logic;
			outL, outR : out std_logic
		);
	end component;
	
	component mux2to1 is
		port (
			s, in0, in1 : in std_logic;
			out1 : out std_logic
		);
	end component;
	
	signal alu_out, shifter_out, fu_out : std_logic_vector (15 downto 0);
	constant delay : time := 5ns;
begin
	alu: alu_16bit port map (
		a => a,
		b => b,
		c_in => fs(0),
		s0 => fs(1),
		s1 => fs(2),
		s2 => fs(3),
		c_out => c,
		sum => alu_out
	);
	shifter: shifter_16bit port map (
		b => b,
		h => shifter_out,
		s => fs(3 downto 2),
		constL => '0',
		constR => '0'
		-- outL and outR irrelevent
		-- for this implementation
	);
	multiplexer: mux2to1 port map (
		s => fs(4),
		in0 => alu_out,
		in1 => shifter_out,
		out1 => fu_out
	);
	
	-- Overflow flag
	v <= '1' after delay when (a(15)='0' and b(15)='0' and fu_out(15)='1') or
		 (a(15)='1' and b(15)='1' and fu_out(15)='0') or
		 (a(15)='0' and b(15)='1' and fu_out(15)='1' and fs="00101") or
		 (a(15)='1' and b(15)='0' and fu_out(15)='0' and fs="00101") else
		 '0' after delay;
	
	-- negative flag
	n <= '1' after delay when fu_out(15)='1' else
		 '0' after delay;
	
	-- Zero flag (zero detect)
	z <= '1' after delay when fu_out="0000000000000000" else
		 '0' after delay;
	
	g <= fu_out;
end dataflow;