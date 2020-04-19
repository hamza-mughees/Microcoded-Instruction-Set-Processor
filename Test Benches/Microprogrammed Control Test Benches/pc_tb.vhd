library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc_tb is
end pc_tb;

architecture dataflow of pc_tb is
	component pc
		port (
			pl, pi, Clk, reset : in std_logic;
			disp : in std_logic_vector (15 downto 0);
			instruction : out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal pl, pi, Clk : std_logic_vector := '0';
	signal reset : std_logic := '1';
	signal disp : std_logic_vector (15 downto 0) := x"0b65";
	signal instruction : std_logic_vector (15 downto 0);
	
	constant delay : time := 100ns;
begin
	the_pc: pc port map (
		pl => pl,
		pi => pi,
		Clk => Clk,
		reset => reset,
		disp => disp,
		instruction => instruction
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
		pl <= '1';
		wait for delay;
		pi <= '1';
		wait for delay;
		pl <= '0';
		wait for delay;
		reset <= '1';
		wait;
	end process;
end dataflow;