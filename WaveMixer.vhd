LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY WaveMixer IS
	GENERIC(
		N: INTEGER := 8 --Bits de cuantización
	);
	
	PORT(
		FInput : IN	 STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		GInput : IN	 STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		Output : OUT STD_LOGIC_VECTOR(N DOWNTO 0)
	);
END WaveMixer;

ARCHITECTURE Behavioral OF WaveMixer IS
	SIGNAL	gSignal  : INTEGER RANGE 0 TO 2**N - 1;
	SIGNAL	fSignal  : INTEGER RANGE 0 TO 2**N - 1;
	SIGNAL 	outSignal: INTEGER RANGE 0 TO 2**(N+1) - 1;
BEGIN
	gSignal <= TO_INTEGER(UNSIGNED(GInput));
	fSignal <= TO_INTEGER(UNSIGNED(FInput));
	
	outSignal <= 	gSignal + fSignal;
	
	Output <= STD_LOGIC_VECTOR(TO_UNSIGNED(outSignal, N+1));
END Behavioral;