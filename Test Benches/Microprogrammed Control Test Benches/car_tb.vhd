library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity car_tb is
end car_tb;

architecture dataflow of car_tb is
	component car
		port (
			opcode : in std_logic_vector (7 downto 0);
			s, Clk, reset : in std_logic;
			next_inst : out std_logic_vector (7 downto 0)
		);
	end component;
	
	-- signal declaration and initialisation
	signal opcode : std_logic_vector (7 downto 0) := x"01";			
	signal s, Clk : std_logic := '0';
	signal reset : std_logic := '1';
	signal next_inst : std_logic_vector (7 downto 0) := x"00";
	
	constant delay : time := 100ns;
begin
	-- signals mapped to ports
	the_car: car port map (
		opcode => opcode,
		s => s,
		Clk => Clk,
		reset => reset,
		next_inst => next_inst
	);
	
	clock: process	-- binary signal
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
		s <= '1';			-- selector set to 1
		wait for delay;
		reset <= '1';		-- reset enabled
		wait;
	end process;
end dataflow;