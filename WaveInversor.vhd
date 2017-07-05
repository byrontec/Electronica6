LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY WaveInversor IS
	GENERIC(
		N: INTEGER := 8 --Bits de cuantización
	);
	
	PORT(
		WaveInput : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		WaveOutput: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END WaveInversor;

ARCHITECTURE Behavioral OF WaveInversor IS
	SIGNAL 	waveInputValue: INTEGER RANGE 0 TO 2**N - 1;
	CONSTANT offset		  : INTEGER := 2**N - 1;
BEGIN
	waveInputValue <= TO_INTEGER(UNSIGNED(WaveInput));
	WaveOutput <= STD_LOGIC_VECTOR(TO_SIGNED(offset-waveInputValue, N));
END Behavioral;