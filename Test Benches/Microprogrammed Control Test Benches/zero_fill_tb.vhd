library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity zero_fill_tb is
end zero_fill_tb;

architecture dataflow of zero_fill_tb is
	component zero_fill
		port (
			a : in std_logic_vector (2 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal a : std_logic_vector (2 downto 0);
	signal z : std_logic_vector (15 downto 0);
	
	constant delay : time := 100ns;
begin
	the_filler: zero_fill port map (
		a => a,
		z => z
	);
	
	simulation: process
	begin
		a <= "010";
		wait for delay;
		a <= "100";
		wait;
	end process;
end dataflow;