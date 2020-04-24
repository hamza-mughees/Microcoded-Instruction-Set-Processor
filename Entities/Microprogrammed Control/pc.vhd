library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
	port (
		pl, pi, Clk, reset : in std_logic;
		disp : in std_logic_vector (15 downto 0);
		instruction : out std_logic_vector (15 downto 0)
	);
end pc;

architecture dataflow of pc is
	component alu_16bit is
		port (
			a, b : in std_logic_vector(15 downto 0);
			c_in, s0, s1, s2 : in std_logic;
			c_out : out std_logic;
			sum : out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal state : std_logic_vector (15 downto 0);
	signal carry : std_logic := '0';
	-- ^ always 0
	signal add_opcode : std_logic_vector (2 downto 0) := x"001";
	-- ^ always add
	signal alu_in : std_logic_vector (15 downto 0) := x"0000";
	signal alu_out : std_logic_vector (15 downto 0);
begin
	alu: alu_16bit port map (
		a => state,
		b => alu_in,
		c_in => carry,
		s0 => add_opcode(0),
		s1 => add_opcode(1),
		s2 => add_opcode(2),
		c_out => open,
		sum => alu_out
	);
	
	instruction <= state after 5ns;
	
	process (Clk, reset)
	begin
		if (reset='1') then
			state <= x"0000";
		elsif ((Clk='1' and (pl='0' and pi='1')) or (pl='1' and pi='0')) then
			state <= alu_out;
		else
			state <= state;
		end if;
	end process;
	
	alu_in <= x"0001" after 5ns when pl='0' and pi='1' else
			  disp after 5ns when pl='1' and pi='0' else
			  x"0001" after 5ns;
end dataflow;