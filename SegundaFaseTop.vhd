LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SegundaFaseTop IS
	GENERIC(
		N: INTEGER := 8; --Bits de cuantizacion
		M: INTEGER := 8  --Bits de muestreo
	);
	
	PORT(
--		Clock		  : IN  STD_LOGIC;
		FEnable	  : IN  STD_LOGIC;
		GEnable	  : IN  STD_LOGIC;
		SineSignal : IN  STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		WaveOutput : OUT STD_LOGIC_VECTOR(N DOWNTO 0)
--		WaveIOutput: OUT STD_LOGIC_VECTOR(N DOWNTO 0)
	);
END SegundaFaseTop;

ARCHITECTURE Behavioral OF SegundaFaseTop IS
--	COMPONENT SinWaveGenerator
--		PORT(
--			Clock  : IN  std_logic;
--			Enable : IN  std_logic;
--			Reset  : IN  std_logic;          
--			SinWave: OUT std_logic_vector(6 downto 0)
--		);
--	END COMPONENT;
	
	COMPONENT WaveFormSupressor
		PORT(
			Input   : IN  std_logic_vector(7 downto 0);
			Selector: IN  std_logic;          
			Output  : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT WaveInversor
		PORT(
			WaveInput : IN  std_logic_vector(7 downto 0);          
			WaveOutput: OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT WaveMixer
		PORT(
			FInput : IN  std_logic_vector(7 downto 0);
			GInput : IN  std_logic_vector(7 downto 0);          
			Output : OUT std_logic_vector(8 downto 0)
		);
	END COMPONENT;
	
--	COMPONENT ClockScaler
--		PORT(
--			ClockIn   : IN  std_logic;
--			ChipSelect: IN  std_logic;          
--			ClockOut  : OUT std_logic
--		);
--	END COMPONENT;
	
--	SIGNAL SineSignal 	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL SineISignal	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL SineSupressed	: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL SineISupressed: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	SIGNAL WaveOutSignal : STD_LOGIC_VECTOR(N DOWNTO 0);
--	SIGNAL ClockSignal	: STD_LOGIC;
BEGIN
--	Inst_SinWaveGenerator: SinWaveGenerator 
--	PORT MAP(
--		Clock => ClockSignal,
--		Enable => '1',
--		Reset => '0',
--		SinWave => SineSignal
--	);
	
	Inst_WaveFormSupressorF: WaveFormSupressor 
	PORT MAP(
		Input => SineSignal,
		Selector => FEnable,
		Output => SineSupressed
	);
	
	Inst_WaveFormSupressorG: WaveFormSupressor 
	PORT MAP(
		Input => SineISignal,
		Selector => GEnable,
		Output => SineISupressed
	);
	
	Inst_WaveInversor: WaveInversor 
	PORT MAP(
		WaveInput => SineSignal,
		WaveOutput => SineISignal 
	);
	
	Inst_WaveMixer: WaveMixer 
	PORT MAP(
		FInput => SineSupressed,
		GInput => SineISupressed,
		Output => WaveOutSignal
	);
	
--	Inst_ClockScaler: ClockScaler 
--	PORT MAP(
--		ClockIn => Clock,
--		ChipSelect => '1',
--		ClockOut => ClockSignal
--	);
	WaveOutput  <= WaveOutSignal;
--	WaveIOutput <= '0' & SineISignal;
END Behavioral;