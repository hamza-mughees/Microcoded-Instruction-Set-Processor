library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder_4to9 is
	Port (
		A0 : in std_logic;
		A1 : in std_logic;
		A2 : in std_logic;
		A3 : in std_logic;
		Q0 : out std_logic;
		Q1 : out std_logic;
		Q2 : out std_logic;
		Q3 : out std_logic;
		Q4 : out std_logic;
		Q5 : out std_logic;
		Q6 : out std_logic;
		Q7 : out std_logic;
		Q8 : out std_logic
	);
end decoder_4to9;

architecture Behavioral of decoder_4to9 is
begin
	Q0 <= ((not A2) and (not A1) and (not A0)) after 5 ns;				--  000
	Q1 <= ((not A2) and (not A1) and A0) after 5 ns;					--  001
	Q2 <= ((not A2) and A1 and (not A0)) after 5 ns;					--  010
	Q3 <= (and (not A2) and A1 and A0) after 5 ns;						--  011
	Q4 <= (and A2 and (not A1) and (not A0)) after 5 ns;				--  100
	Q5 <= (and A2 and (not A1) and A0) after 5 ns;						--  101
	Q6 <= (and A2 and A1 and (not A0)) after 5 ns;						--  110
	Q7 <= (and A2 and A1 and A0) after 5 ns;							--  111
	Q8 <= (A3 and (not A2) and (not A1) and (not A0)) after 5ns;		-- 1000
end Behavioral;