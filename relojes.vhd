

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity relojes is
port(
	clk : in std_logic;
	nuevo : out std_logic
--	Nnuevo: out std_logic
);
end relojes;

architecture Behavioral of relojes is
signal cont : integer range 0 to 2;--n 2

begin
process(clk)
begin
	if (rising_edge(clk)) then
			cont <= cont + 1;
			if cont = 2 then--n
					cont <= 0;
			end if;
	end if;
end process;
	nuevo  <= '1' when cont < 1 else '0'; --n/2	
--	Nnuevo <= '0' when cont < 1 else '1'; 
end Behavioral;