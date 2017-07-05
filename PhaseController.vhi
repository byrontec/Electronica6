
-- VHDL Instantiation Created from source file PhaseController.vhd -- 18:34:25 06/30/2017
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT PhaseController
	PORT(
		DataIn : IN std_logic_vector(7 downto 0);
		Offset : IN std_logic_vector(1 downto 0);
		Clock : IN std_logic;          
		DataOut : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	Inst_PhaseController: PhaseController PORT MAP(
		DataIn => ,
		Offset => ,
		Clock => ,
		DataOut => 
	);


