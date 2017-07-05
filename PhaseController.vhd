LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY PhaseController IS
	GENERIC(
		N: INTEGER:= 9;
		M: INTEGER:= 7
	);
	
	PORT(
		DataIn : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		Offset : IN  STD_LOGIC_VECTOR(M-1 DOWNTO 0); 
		Clock	 : IN  STD_LOGIC;
		DataOut: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0)
	);
END PhaseController;

ARCHITECTURE Behavioral OF PhaseController IS
	TYPE   Memory IS ARRAY (0 TO 2**M - 1) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL FIFO: Memory;
	
	SIGNAL counter		 : INTEGER RANGE 0 TO 2**M - 1;
	SIGNAL phaseCounter: INTEGER RANGE 0 TO 2**(M+1)-1;
BEGIN
	FIFOProcess:
	PROCESS(Clock)
	BEGIN
		IF RISING_EDGE(Clock) THEN
			phaseCounter <= counter + TO_INTEGER(UNSIGNED(offset));
			
			IF phaseCounter >= 2**M THEN
				phaseCounter <= phaseCounter - 2**M;
			END IF;
			
			FIFO(counter) <= DataIn;
			DataOut <= FIFO(phaseCounter);
			
			IF counter = 2**M - 1 THEN
				counter <= 0;
			ELSE
				counter <= counter + 1;
			END IF;
		END IF;
	END PROCESS FIFOProcess;
END Behavioral;