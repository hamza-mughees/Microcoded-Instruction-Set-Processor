library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_reg_tb is
end instruction_reg_tb;

architecture dataflow of instruction_reg_tb;
	component instruction_reg
		port (
			instruction : in std_logic_vector (15 downto 0);
			il, reset, Clk : in std_logic;
			opcode : out std_logic_vector (7 downto 0);
			sb, sa, dr : out std_logic_vector (2 downto 0)
		);
	end component;
	
	signal instruction : std_logic_vector (15 downto 0) := x"ab12";
	signal il, Clk : std_logic := '0';
	signal reset : std_logic := '1';
	signal opcode : std_logic_vector (7 downto 0);
	signal sb, sa, dr : std_logic_vector (2 downto 0);
	
	constant delay : time := 100ns;
begin
	the_reg: instruction_reg port map (
		instruction => instruction,
		il => il,
		reset => reset,
		Clk => Clk,
		opcode => opcode,
		sb => sb,
		sa => sa,
		dr => dr
	);
	
	clock: process
	begin
		wait for delay/2;
		Clk <= not Clk;
	end process;
	
	simulation: process
	begin
		wait for delay;
		reset <= '0';
		wait for delay;
		il <= '1';
		wait for delay;
		reset <= '1';
		wait;
	end process;
end dataflow;