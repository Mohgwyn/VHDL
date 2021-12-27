library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro is
    generic ( n : integer );
    port ( d : in STD_LOGIC;
           q : out STD_LOGIC_VECTOR (n-1 downto 0);
           reset : in STD_LOGIC;
           des : in STD_LOGIC;
           clk : in STD_LOGIC);
end Registro;

architecture Desplazamiento of Registro is
signal temp: std_logic_vector(n-1 downto 0);
begin
    process( clk, reset )
    begin
        if reset = '1' then
            temp <= ( others => '0' );
        elsif rising_edge(clk) then
            if des = '1' then
                for i in temp'high downto 1 loop
                    temp(i) <= temp(i-1);
                end loop;
                temp(0) <= d;
             end if;
         end if;
     end process;
     
q <= temp;

end Desplazamiento;
