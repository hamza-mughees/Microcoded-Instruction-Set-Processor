library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_file is
	port (
		data : in std_logic_vector (15 downto 0);
		dest_sel : in std_logic_vector (3 downto 0);
		load_enable, Clk : in std_logic;
		a_sel, b_sel : in std_logic_vector (3 downto 0);
		a_data, b_data : out std_logic_vector (15 downto 0)
	);
end register_file;

architecture dataflow of register_file is
	component decoder_4to9 is
		Port (
			A0 : in std_logic;
			A1 : in std_logic;
			A2 : in std_logic;
			A3 : in std_logic;
			Q0 : out std_logic;
			Q1 : out std_logic;
			Q2 : out std_logic;
			Q3 : out std_logic;
			Q4 : out std_logic;
			Q5 : out std_logic;
			Q6 : out std_logic;
			Q7 : out std_logic;
			Q8 : out std_logic
		);
	end component;
	
	component reg16 is
		port (
			load : in std_logic;
			Clk : in std_logic;
			D : in std_logic_vector (15 downto 0);
			Q : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component mux9to1 is
		port (
			S0 : in std_logic;
			S1 : in std_logic;
			S2 : in std_logic;
			S3 : in std_logic;
			In0 : in std_logic_vector (15 downto 0);
			In1 : in std_logic_vector (15 downto 0);
			In2 : in std_logic_vector (15 downto 0);
			In3 : in std_logic_vector (15 downto 0);
			In4 : in std_logic_vector (15 downto 0);
			In5 : in std_logic_vector (15 downto 0);
			In6 : in std_logic_vector (15 downto 0);
			In7 : in std_logic_vector (15 downto 0);
			In8 : in std_logic_vector (15 downto 0);
			Z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7, d_out8 : std_logic;
	signal load0, load1, load2, load3, load4, load5, load6, load7, load8 : std_logic;
	signal r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out, r8_out : std_logic_vector (15 downto 0);
	
	constant delay : time := 15ns;
begin
	decoder: decoder_4to9 port map (
		A0 => dest_sel(0),
		A1 => dest_sel(1),
		A2 => dest_sel(2),
		A3 => dest_sel(3),
		Q0 => d_out0,
		Q1 => d_out1,
		Q2 => d_out2,
		Q3 => d_out3,
		Q4 => d_out4,
		Q5 => d_out5,
		Q6 => d_out6,
		Q7 => d_out7,
		Q8 => d_out8
	);
	
	r0: reg16 port map (
		load => load0,
		Clk => Clk,
		D => data,
		Q => r0_out
	);
	r1: reg16 port map (
		load => load1,
		Clk => Clk,
		D => data,
		Q => r1_out
	);
	r2: reg16 port map (
		load => load2,
		Clk => Clk,
		D => data,
		Q => r2_out
	);
	r3: reg16 port map (
		load => load3,
		Clk => Clk,
		D => data,
		Q => r3_out
	);
	r4: reg16 port map (
		load => load4,
		Clk => Clk,
		D => data,
		Q => r4_out
	);
	r5: reg16 port map (
		load => load5,
		Clk => Clk,
		D => data,
		Q => r5_out
	);
	r6: reg16 port map (
		load => load6,
		Clk => Clk,
		D => data,
		Q => r6_out
	);
	r7: reg16 port map (
		load => load7,
		Clk => Clk,
		D => data,
		Q => r7_out
	);
	r8: reg16 port map (
		load => load8,
		Clk => Clk,
		D => data,
		Q => r8_out
	);
	
	a_mux: mux9to1 port map (
		s0 => a_sel(0),
		s1 => a_sel(1),
		s2 => a_sel(2),
		s3 => a_sel(3),
		In0 => r0_out,
		In1 => r1_out,
		In2 => r2_out,
		In3 => r3_out,
		In4 => r4_out,
		In5 => r5_out,
		In6 => r6_out,
		In7 => r7_out,
		In8 => r8_out,
		Z => a_data
	);
	
	b_mux: mux9to1 port map (
		s0 => b_sel(0),
		s1 => b_sel(1),
		s2 => b_sel(2),
		s3 => b_sel(3),
		In0 => r0_out,
		In1 => r1_out,
		In2 => r2_out,
		In3 => r3_out,
		In4 => r4_out,
		In5 => r5_out,
		In6 => r6_out,
		In7 => r7_out,
		In8 => r8_out,
		Z => b_data
	);
	
	load0 <= d_out0 and load_enable after delay;
	load1 <= d_out1 and load_enable after delay;
	load2 <= d_out2 and load_enable after delay;
	load3 <= d_out3 and load_enable after delay;
	load4 <= d_out4 and load_enable after delay;
	load5 <= d_out5 and load_enable after delay;
	load6 <= d_out6 and load_enable after delay;
	load7 <= d_out7 and load_enable after delay;
	load8 <= d_out8 and load_enalbe after delay;
end dataflow;