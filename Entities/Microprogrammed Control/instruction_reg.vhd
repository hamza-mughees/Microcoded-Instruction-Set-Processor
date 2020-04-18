library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_reg is
	port (
		instruction : in std_logic_vector (15 downto 0);
		il, reset, Clk : in std_logic;
		opcode : out std_logic_vector (7 downto 0);
		sb, sa, dr : out std_logic_vector (2 downto 0)
	);
end instruction_reg;

architecture dataflow of instruction_reg is
	signal state : std_logic_vector (15 downto 0);
begin
	opcode (7) <= '0';
	opcode (6 downto 0) <= state (15 downto 9) after 5ns;
	
	dr <= state (8 downto 6);
	sa <= state (5 downto 3);
	sb <= state (2 downto 0);
	
	process (reset, Clk)
	begin
		if (reset='1')
			state <= "0000000000000000";
		elsif (il='1' and Clk='1')
			state <= instruction;
		end if;
	end process;
end dataflow;