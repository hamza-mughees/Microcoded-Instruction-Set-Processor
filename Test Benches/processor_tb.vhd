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
	
	-- signal declaration and initialisation
	signal Clk : std_logic := '0';
	signal reset : std_logic := '1';
	
	constant delay : time := 100ns;
begin
	-- signals mapped to ports
	the_processor: processor port map (
		Clk => Clk,
		reset => reset
	);
	
	clock: process
	begin
		wait for delay/2;
		Clk <= not Clk;
		-- this will make sure it tests each 
		-- condition for when Clk is 1 and 
		-- when its 0
	end process;
	
	simulation: process
	begin
		wait for delay;
		reset <= '0';		-- reset disabled (runs processor)
		wait;
	end process;
end dataflow;