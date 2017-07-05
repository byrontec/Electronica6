LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MISO IS
	GENERIC(N: INTEGER := 4);
	
	PORT(
		ClockIn	 :	IN  STD_LOGIC;
		Enable	 : IN  STD_LOGIC;
		ParallelIn: IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		SerialOut : OUT STD_LOGIC
	);
END MISO;

ARCHITECTURE Behavioral OF MISO IS
	SIGNAL ParallelSignal: STD_LOGIC_VECTOR(N DOWNTO 0);
--	SIGNAL ClockSignal   : STD_LOGIC;
BEGIN
--	ClockSignal <= ClockIn OR Enable;
	
	MISOProcess:
	PROCESS(ClockIn, Enable, ParallelIn)
	BEGIN
		IF Enable = '1' THEN
			ParallelSignal <= '1' & ParallelIn;
		ELSIF FALLING_EDGE(ClockIn) THEN
			SerialOut <= ParallelSignal(N);
			ParallelSignal <= ParallelSignal(N-1 DOWNTO 0) & '0';
		END IF;
	END PROCESS MISOProcess;
END Behavioral;
