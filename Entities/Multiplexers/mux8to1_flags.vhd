library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8to1_flags is
	port (
		s : in std_logic_vector (2 downto 0);
		c, v, z, n : in std_logic;
		flag_out : out std_logic
	);
end mux8to1_flags;

architecture Behavioral of mux8to1_flags is
begin
	flag_out <= '0' after 5ns when s="000" else
				'1' after 5ns when s="001" else
				c after 5ns when s="010" else
				v after 5ns when s="011" else
				z after 5ns when s="100" else
				n after 5ns when s="101" else
				not c after 5ns when s="110" else
				not z after 5ns when s="111" else
				'0' after 5ns;
end Behavioral;