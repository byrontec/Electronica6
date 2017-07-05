library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity chipselect is
port(
	nuevo : in std_logic;
	lectura: out std_logic;
	CS		: out std_logic
);
end chipselect;

architecture Behavioral of chipselect is
signal cont : integer range 0 to 37;

begin
process(nuevo)
begin
	if (falling_edge(nuevo)) then
			cont <= cont + 1;
			if cont = 37 then
					cont <= 0;
			end if;
	end if;
end process;
	CS <= '1' when cont < 19 else '0'; 	
	lectura <= '1' when (cont < 26) or (cont > 33 ) else '0';

end Behavioral;