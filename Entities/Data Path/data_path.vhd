library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_path is
	port (
		data_in, const_in : in std_logic_vector (15 downto 0);
		dest_sel, a_sel, b_sel : in std_logic_vector (3 downto 0);
		load_enable, mb_sel, md_sel : in std_logic;
		addr_out, data_out : out std_logic_vector (15 downto 0);
		fs : in std_logic_vector (4 downto 0);
		Clk, v, c, n, z : out std_logic
	);
end data_path;

architecture dataflow of data_path is
	component mux2_16bit is
		port (
			s : in std_logic;
			in0 : in std_logic_vector (15 downto 0);
			in1 : in std_logic_vector (15 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;

	component register_file is
		port (
			data : in std_logic_vector (15 downto 0);
			dest_sel : in std_logic_vector (3 downto 0);
			load_enable, Clk : in std_logic;
			a_sel, b_sel : in std_logic_vector (3 downto 0);
			a_data, b_data : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component function_unit is
		port (
			a, b : in std_logic_vector (15 downto 0);
			fs : in std_logic_vector (4 downto 0);
			g : out std_logic_vector (15 downto 0);
			v, c, n, z : out std_logic
		);
	end component;
	
	signal md_out, mb_out, fu_out, a_data, b_data : std_logic_vector (15 downto 0);
begin
	md: mux2_16bit port map (
		s => md_sel,
		in0 => fu_out,
		in1 => data_in,
		z => md_out
	);
	
	rf: register_file port map (
		data => md_out,
		dest_sel => dest_sel,
		load_enable => load_enable,
		Clk => Clk,
		a_sel => a_sel,
		b_sel => b_sel,
		a_data => a_data,
		b_data => b_data
	);
	
	mb: mux2_16bit port map (
		s => mb_sel,
		in0 => b_data,
		in1 => const_in,
		z => mb_out
	);
	
	fu: function_unit port map (
		a => const_in,
		b => mb_out,
		fs => fs,
		g => fu_out,
		v => v,
		c => c,
		n => n,
		z => z
	);
	
	addr_out <= a_data after 15ns;
	data_out <= b_data after 15ns;
end dataflow;