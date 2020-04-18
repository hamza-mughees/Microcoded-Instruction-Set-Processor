library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity processor is
	port (
		Clk, reset : in std_logic
	);
end processor;

architecture dataflow of processor is
	component data_path is
		port (
			data_in, const_in : in std_logic_vector (15 downto 0);
			dest_sel, a_sel, b_sel : in std_logic_vector (3 downto 0);
			load_enable, mb_sel, md_sel : in std_logic;
			addr_out, data_out : out std_logic_vector (15 downto 0);
			fs : in std_logic_vector (4 downto 0);
			Clk, v, c, n, z : out std_logic
		);
	end component;
	
	component mux2_16bit is
		port (
			s : in std_logic;
			in0 : in std_logic_vector (15 downto 0);
			in1 : in std_logic_vector (15 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component external_memory is
		port (
			address, data_to_write : in std_logic_vector (15 downto 0);
			write_to_mem, Clk : in std_logic;
			data_to_read : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component sign_extend is
		port (
			dr_sb : in std_logic_vector (5 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component pc is
		port (
			pl, pi, Clk, reset : in std_logic;
			disp : in std_logic_vector (15 downto 0);
			instruction : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component mux8to1_flags is
		port (
			s : in std_logic_vector (2 downto 0);
			c, v, z, n : in std_logic;
			flag_out : out std_logic
		);
	end component;
	
	component instruction_reg is
		port (
			instruction : in std_logic_vector (15 downto 0);
			il, reset, Clk : in std_logic;
			opcode : out std_logic_vector (7 downto 0);
			sb, sa, dr : out std_logic_vector (2 downto 0)
		);
	end component;
	
	component zero_fill is
		port (
			a : in std_logic_vector (2 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component mux2_8bit is
		port (
			s : in std_logic;
			in0 : in std_logic_vector (7 downto 0);
			in1 : in std_logic_vector (7 downto 0);
			z : out std_logic_vector (7 downto 0)
		);
	end component;
	
	component car is
		port (
			opcode : in std_logic_vector (7 downto 0);
			s, Clk, reset : in std_logic;
			next_inst : out std_logic_vector (7 downto 0)
		);
	end component;
	
	component control_memory is
		port (
			in_car : in std_logic_vector (7 downto 0);
			mw, mm, rw, md : out std_logic;
			fs : out std_logic_vector (4 downto 0);
			mb, tb, ta, td, pl, pi, il, mc : out std_logic;
			ms : out std_logic_vector (2 downto 0);
			na : out std_logic_vector (7 downto 0)
		);
	end component;
	
	signal zero_filled_sb, extend_out, pc_disp, pc_out : std_logic_vector (15 downto 0);
	signal mux_m_out, dp_data_out, dp_addr_out, mem_m_data_out : std_logic_vector (15 downto 0);
	signal na, opcode, mux_c_out, car_out : std_logic_vector (7 downto 0);
	signal dr_sb : std_logic_vector (5 downto 0);
	signal fs : std_logic_vector (4 downto 0);
	signal nzvc, td_dr, ta_sa, tb_sb : std_logic_vector (3 downto 0);
	signal dr, sa, sb, ms_sel : std_logic_vector (2 downto 0);
	signal md_sel, mb_sel, load_enable, mm_sel, pl, pi, mw, mux_s_out, il, mc_sel : std_logic;
begin
	datapath: data_path port map (
		data_in => mem_m_data_out,
		const_in => zero_filled_sb,
		dest_sel => td_dr,
		a_sel => ta_sa,
		b_sel => tb_sb,
		load_enable => load_enable,
		mb_sel => mb_sel,
		md_sel => md_sel,
		addr_out => dp_addr_out,
		data_out => dp_data_out,
		fs => fs,
		Clk => Clk,
		v => nzvc(1),
		c => nzvc(0),
		n => nzvc(3),
		z => nzvc(2)
	);
	
	mux_m: mux2_16bit port map (
		s => mm_sel,
		in0 => dp_addr_out,
		in1 => pc_out,
		z => mux_m_out
	);
	
	memory_m: external_memory port map (
		address => mux_m_out,
		data_to_write => dp_data_out,
		write_to_mem => mw,
		Clk => Clk,
		data_to_read => mem_m_data_out
	);
	
	extend: sign_extend port map (
		dr_sb => dr_sb,
		z => extend_out
	);
	
	program_c: pc port map (
		pl => pl, 
		pi => pi, 
		Clk => Clk, 
		reset => reset,
		disp => pc_disp,
		instruction => pc_out
	);
	
	flag_mux: mux8to1_flags port map (
		s => ms_sel,
		c => nzvc(0),
		v => nzvc(1),
		z => nzvc(2),
		n => nzvc(3),
		flag_out => mux_s_out
	);
	
	ir: instruction_reg port map (
		instruction => mem_m_data_out,
		il => il,
		reset => reset,
		Clk => Clk,
		opcode => opcode,
		sb => sb,
		sa => sa,
		dr => dr
	);
	
	zf: zero_fill port map (
		a => sb,
		z => zero_filled_sb
	);
	
	mux_c: mux2_8bit port map (
		s => mc_sel,
		in0 => na,
		in1 => opcode,
		z => mux_c_out
	);
	
	control_ar: car port map (
		opcode => opcode,
		s => mux_s_out,
		Clk => Clk,
		reset => reset,
		next_inst => car_out
	);
	
	cm: control_memory port map (
		in_car => car_out,
		mw => mw,
		mm => mm_sel,
		rw => load_enable,
		md => md_sel,
		fs => fs,
		mb => mb_sel,
		tb => tb_sb(3),
		ta => ta_sa(3),
		td => td_dr(3),
		pl => pl,
		pi => pi,
		il => il,
		mc => mc_sel,
		ms => ms_sel,
		na => na
	);
	
	dr_sb (2 downto 0) <= sb;
	dr_sb (5 downto 3) <= dr;
	tb_sb (2 downto 0) <= sb;
	ta_sa (2 downto 0) <= sa;
	td_dr (2 downto 0) <= dr;
end dataflow;