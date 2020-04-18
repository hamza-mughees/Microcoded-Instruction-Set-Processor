library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity zero_fill is
	port (
		a : in std_logic_vector (2 downto 0);
		z : out std_logic_vector (15 downto 0)
	);
end zero_fill;

architecture dataflow of zero_fill is
begin
	z (15 downto 3) <= "0000000000000" after 5ns;
	-- ^ zero filling
	z (2 downto 0) <= a after 5ns;
end dataflow;