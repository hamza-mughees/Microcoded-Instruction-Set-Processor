library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sign_extend_tb is
end sign_extend_tb;

architecture dataflow of sign_extend_tb is
	component sign_extend
		port (
			dr_sb : in std_logic_vector (5 downto 0);
			z : out std_logic_vector (15 downto 0)
		);
	end component;
	
	signal dr_sb : std_logic_vector (5 downto 0);
	signal z : std_logic_vector (15 downto 0);
	
	constant delay : time := 100ns;
begin
	the_extender: sign_extend port map (
		dr_sb => dr_sb,
		z => z
	);
	
	simulation: process
	begin
		wait for delay;
		dr_sb <= "010101";
		wait for delay;
		dr_sb <= "101010";
		wait for delay;
		dr_sb <= "010011";
		wait;
	end process;
end dataflow;