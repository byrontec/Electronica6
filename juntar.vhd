
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity juntar is
port(
	nuevo   : in std_logic;
	serial  : in std_logic;
	lectura : in std_logic;
	enmaster: out std_logic;
	data    : out std_logic_vector(7 downto 0)
);
end juntar;

architecture Behavioral of juntar is
type proceso1 is (espera, junto);
signal estado : proceso1;
signal contador : integer range 0 to 7;
begin
			
process(nuevo)
begin
if (rising_edge(nuevo))then
	case estado is 
		when espera =>
			if lectura='0' then
				estado <= junto;
			end if;
			enmaster <= '0';
		when junto =>
			if (contador = 7) then
				enmaster <= '1';
				contador <= 0;
				estado <= espera;
			else
				contador <= contador +1;
			end if;
				data(contador) <= serial;
		when others =>
			estado <= espera;
	end case;
end if;
end process;
end Behavioral;