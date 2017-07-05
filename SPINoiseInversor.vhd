LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY SPINoiseInversor IS
	PORT(
		Clock	   	 : IN  STD_LOGIC;
		FEnable  	 : IN  STD_LOGIC;
		GEnable  	 : IN  STD_LOGIC;
		SPI_MISO 	 : IN  STD_LOGIC;
		SPI_Address	 :	IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		Phase_Offset : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
		SPI_Clock	 : OUT STD_LOGIC;
		SPI_CS		 : OUT STD_LOGIC;
		SPI_Inverted :	OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
		SPI_MOSI		 : OUT STD_LOGIC;
		LoadFlag		 : OUT STD_LOGIC
	);
END SPINoiseInversor;

ARCHITECTURE Behavioral OF SPINoiseInversor IS
	COMPONENT SegundaFaseTop
		PORT(
			FEnable 	 : IN  STD_LOGIC;
			GEnable 	 : IN  STD_LOGIC;
			SineSignal: IN  STD_LOGIC_VECTOR(7 DOWNTO 0);          
			WaveOutput: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT TOP_maquinas
		PORT(
			clk 		 : IN  STD_LOGIC;
			serial 	 : IN  STD_LOGIC;
			ParallelIn: IN  STD_LOGIC_VECTOR(3 DOWNTO 0);          
			nuevo 	 : OUT STD_LOGIC;
			CS 		 : OUT STD_LOGIC;
			data 		 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			enmaster  : OUT STD_LOGIC;
			mosipin 	 : OUT STD_LOGIC
--			lectura 	 : OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT PhaseController
		PORT(
			DataIn : IN  STD_LOGIC_VECTOR(8 DOWNTO 0);
			Offset : IN  STD_LOGIC_VECTOR(6 DOWNTO 0);
			Clock  : IN  STD_LOGIC;          
			DataOut: OUT STD_LOGIC_VECTOR(8 DOWNTO 0)
		);
	END COMPONENT;
	
--	SIGNAL SineSignalS: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL WaveOutputS: STD_LOGIC_VECTOR(8 DOWNTO 0);
	
	SIGNAL SineSignalI: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL WaveOutputI: STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL SPI_CSS		: STD_LOGIC;
BEGIN
	Inst_SegundaFaseTop: SegundaFaseTop PORT MAP(
		FEnable    => FEnable,
		GEnable    => GEnable,
		SineSignal => SineSignalI,
		WaveOutput => WaveOutputI
	);
	
	Inst_TOP_maquinas: TOP_maquinas PORT MAP(
		clk        => Clock,
		serial     => SPI_MISO,
		ParallelIn => SPI_Address,
		nuevo      => SPI_Clock,
		CS         => SPI_CSS,
		data       => SineSignalI,
		enmaster   => LoadFlag,
		mosipin    => SPI_MOSI
	);
	
	Inst_PhaseController: PhaseController PORT MAP(
		DataIn     => WaveOutputI,
		Offset     => Phase_Offset,
		Clock      => SPI_CSS,
		DataOut    => WaveOutputS
	);
	
	SPI_CS		 <= SPI_CSS;
	SPI_Inverted <= WaveOutputS;
END Behavioral;