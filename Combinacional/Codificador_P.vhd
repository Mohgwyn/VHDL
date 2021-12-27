library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Codificador_P is
    generic(n: integer := 2);
    Port ( x : in STD_LOGIC_VECTOR((2**n)-1 downto 0);
           y : out STD_LOGIC_VECTOR(n-1 downto 0);
           EA : out STD_LOGIC);
end Codificador_P;

architecture B of Codificador_P is

begin
    process(x)
    begin
        y <= (others => '0'); EA <= '0';
        for i in x'reverse_range loop
            if x(i) = '1' then
                y <= std_logic_vector( to_unsigned(i,n));
                EA <= '1';
            end if;
        end loop;
    end process;

end B;
