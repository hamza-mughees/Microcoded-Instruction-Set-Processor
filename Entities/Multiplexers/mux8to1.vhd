library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8to1 is
	port (
		S0 : in std_logic;
		S1 : in std_logic;
		S2 : in std_logic;
		In0 : in std_logic_vector (15 downto 0);
		In1 : in std_logic_vector (15 downto 0);
		In2 : in std_logic_vector (15 downto 0);
		In3 : in std_logic_vector (15 downto 0);
		In4 : in std_logic_vector (15 downto 0);
		In5 : in std_logic_vector (15 downto 0);
		In6 : in std_logic_vector (15 downto 0);
		In7 : in std_logic_vector (15 downto 0);
		Z : out std_logic_vector (15 downto 0)
	);
end mux8to1;

architecture Behavioral of mux8to1 is
begin
z <= In0 after 5ns when S2='0' and S1='0' and S0='0' else
     In1 after 5ns when S2='0' and S1='0' and S0='1' else
     In2 after 5ns when S2='0' and S1='1' and S0='0' else
     In3 after 5ns when S2='0' and S1='1' and S0='1' else
     In4 after 5ns when S2='1' and S1='0' and S0='0' else
     In5 after 5ns when S2='1' and S1='0' and S0='1' else
     In6 after 5ns when S2='1' and S1='1' and S0='0' else
     In7 after 5ns when S2='1' and S1='1' and S0='1' else
     "0000000000000000" after 5ns;
end Behavioral;