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
	
	-- signal declaration and initialisation
	signal pl, pi, Clk : std_logic_vector := '0';
	signal reset : std_logic := '1';
	signal disp : std_logic_vector (15 downto 0) := x"0b65";
	signal instruction : std_logic_vector (15 downto 0);
	
	constant delay : time := 100ns;
begin
	-- signals mapped to ports
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
		-- this will make sure it tests each 
		-- condition for when Clk is 1 and 
		-- when its 0
	end process;
	
	simulation: process
	begin
		wait for delay;
		reset <= '0';		-- reset disabled
		wait for delay;
		pl <= '1';			-- load pc with signal
		wait for delay;
		pi <= '1';
		wait for delay;
		pl <= '0';			-- increment pc
		wait for delay;
		reset <= '1';		-- reset enabled
		wait;
	end process;
end dataflow;