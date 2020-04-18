library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2_8bit is
	port (
		s : in std_logic;
		in0 : in std_logic_vector (7 downto 0);
		in1 : in std_logic_vector (7 downto 0);
		z : out std_logic_vector (7 downto 0)
	);
end mux2_8bit;

architecture Behavioral of mux2_8bit is
begin
	process ( s, in0, in1 )
	begin
		case s is
			when '0' => z <= in0;
			when '1' => z <= in1;
			when others => z <= in0;
		end case;
	end process;
end Behavioral;