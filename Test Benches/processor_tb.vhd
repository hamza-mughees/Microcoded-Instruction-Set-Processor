library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity processor_tb is
end processor_tb;

architecture dataflow of processor_tb is
	component processor
		port (
			Clk, reset : in std_logic
		);
	end component;
	
	signal Clk : std_logic := '0';
	signal reset : std_logic := '1';
	
	constant delay : time := 100ns;
begin
	the_processor: processor port map (
		Clk => Clk,
		reset => reset
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
		wait;
	end process;
end dataflow;