library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sign_extend is
	port (
		dr_sb : in std_logic_vector (5 downto 0);
		z : out std_logic_vector (15 downto 0)
	);
end sign_extend;

architecture dataflow of sign_extend is
begin
	z (15 downto 6) <= "1111111111" after 5ns when dr_sb(5)='1' else
					   "0000000000" after 5ns;
	-- ^ sign extension
	
	z (5 downto 3) <= dr_sb (5 downto 3);
	z (2 downto 0) <= dr_sb (2 downto 0);
end dataflow;