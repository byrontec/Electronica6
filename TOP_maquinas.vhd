
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TOP_maquinas is
port(
	clk     : in std_logic;
	serial  : in std_logic;
	nuevo	  : out std_logic;
	CS		  : out std_logic;
	data	  : out std_logic_vector(7 downto 0);
	enmaster: out std_logic;
	mosipin : out std_logic;
--	lectura	: out std_logic;
	ParallelIn: in std_logic_vector(3 downto 0)
);
end TOP_maquinas;

architecture Behavioral of TOP_maquinas is
	COMPONENT MISO
	PORT(
		ClockIn : IN std_logic;
		Enable : IN std_logic;
		ParallelIn : IN std_logic_vector(3 downto 0);          
		SerialOut : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT chipselect
	PORT(
		nuevo : IN std_logic;          
		lectura : OUT std_logic;
		CS : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT juntar
	PORT(
		nuevo : IN std_logic;
		serial : IN std_logic;
		lectura : IN std_logic;          
		enmaster : OUT std_logic;
		data : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT relojes
	PORT(
		clk : IN std_logic;          
		nuevo : OUT std_logic
		);
	END COMPONENT;
	
	signal nnuevo : std_logic;
	signal nlectura: std_logic;
	signal nCS : std_logic;
begin
	Inst_MISO: MISO PORT MAP(
		ClockIn => nnuevo,
		Enable => nCS,
		ParallelIn => ParallelIn ,
		SerialOut => mosipin
	);
	
	Inst_chipselect: chipselect PORT MAP(
		nuevo => nnuevo,
		lectura => nlectura,
		CS => nCS
	);
	
	Inst_juntar: juntar PORT MAP(
		nuevo => nnuevo,
		serial => serial,
		lectura => nlectura,
		enmaster => enmaster,
		data => data
	);
	
	Inst_relojes: relojes PORT MAP(
		clk => clk,
		nuevo => nnuevo
	);
--	lectura <= nlectura;
	CS <= nCS;
	nuevo <= nnuevo;
end Behavioral;