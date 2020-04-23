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
	
	-- signal declaration and initialisation
	signal dr_sb : std_logic_vector (5 downto 0);
	signal z : std_logic_vector (15 downto 0);
	
	constant delay : time := 100ns;
begin
	-- signals mapped to ports
	the_extender: sign_extend port map (
		dr_sb => dr_sb,
		z => z
	);
	
	simulation: process
	begin
		dr_sb <= "010101";		-- msb is '0' -> extension is "00..."
		wait for delay;
		dr_sb <= "101010";		-- msb is '1' -> extension is "11..."
		wait for delay;
		dr_sb <= "010011";		-- msb is '0' -> extension is "00..."
		wait;
	end process;
end dataflow;