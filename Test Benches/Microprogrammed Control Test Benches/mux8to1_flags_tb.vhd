library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8to1_flags_tb is
end mux8to1_flags_tb;

architecture dataflow of mux8to1_flags_tb is
	component mux8to1_flags
		port (
			s : in std_logic_vector (2 downto 0);
			c, v, z, n : in std_logic;
			flag_out : out std_logic
		);
	end component;
	
	-- signal declaration and initialisation
	signal s : std_logic_vector (2 downto 0) := "000";		-- select 0
	signal c, v, z, n, flag_out : std_logic;
	
	constant delay : time := 100ns;
begin
	-- signals mapped to ports
	the_mux: mux8to1_flags port map (
		s => s,
		c => c,
		v => v,
		z => z,
		n => n,
		flag_out => flag_out
	);
	
	simulation: process
	begin
		c <= '0';
		v <= '1';
		z <= '0';
		n <= '1';			-- randomly initialise c, v, z, n (0101)
		wait for delay;
		s <= "001";			-- select '1'
		wait for delay;
		s <= "010";			-- select c flag
		wait for delay;
		s <= "011";			-- select v flag
		wait for delay;
		s <= "100";			-- select z flag
		wait for delay;
		s <= "101";			-- select n flag
		wait for delay;
		s <= "110";			-- select c flag (not)
		wait for delay;
		s <= "111";			-- select z flag (not)
		wait;
	end process;
end dataflow;