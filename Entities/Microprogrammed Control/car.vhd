library IEEE;	
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity car is
	port (
		opcode : in std_logic_vector (7 downto 0);
		s, Clk, reset : in std_logic;
		next_inst : out std_logic_vector (7 downto 0)
	);
end car;

architecture dataflow of car is
	component alu_16bit is
		port (
			a, b : in std_logic_vector(15 downto 0);
			c_in, s0, s1, s2 : in std_logic;
			c_out : out std_logic;
			sum : out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal state : std_logic_vector (7 downto 0);
	signal carry : std_logic := '0';
	-- ^ always 0
	signal add_opcode : std_logic_vector (11 downto 0) := x"001";
	-- ^ always add
	signal alu_in : std_logic_vector (15 downto 0) := x"0101";
	signal alu_out : std_logic_vector (15 downto 0);
	signal zeros : std_logic_vector (7 downto 0) := x"00";
begin
	alu: alu_16bit port map (
		a (15 downto 8) => zeros,
		a (7 downto 0) => state,
		b => alu_in,
		c_in => carry,
		s0 => add_opcode(0),
		s1 => add_opcode(1),
		s2 => add_opcode(2),
		c_out => open,
		sum => alu_out
	);
	
	next_inst <= state after 5ns;
	
	process (Clk, reset)
	begin
		if (reset='1') then
			state <= x"00";
		elsif (Clk='1' and s='0') then
			state <= alu_out (7 downto 0);
		elsif (Clk='1' and s='1') then
			state <= opcode;
		end if;
	end process;
end dataflow;
