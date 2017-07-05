LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY WaveFormSupressor IS
	GENERIC(
		N: INTEGER := 8 --Bits de cuantización
	);
	
	PORT(
		Input   : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		Selector: IN  STD_LOGIC;
		Output  : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END WaveFormSupressor;

ARCHITECTURE Behavioral OF WaveFormSupressor IS
BEGIN
	Output <= Input WHEN Selector = '1' ELSE (OTHERS => '0');
END Behavioral;