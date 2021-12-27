library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_Uni is
    generic( n : integer );
    Port ( clk, reset, CKE : in  STD_LOGIC;
           control         : in  STD_LOGIC_VECTOR(2 downto 0);
           dato            : in  STD_LOGIC_VECTOR(n-1 downto 0);
           salida          : out STD_LOGIC_VECTOR(n-1 downto 0));
end Reg_Uni;

architecture Behavioral of Reg_Uni is

--000 Carga el dato de entrada
--001 Contador ascendente
--010 Contador descendente
--011 Desplaza a la izquierda
--100 Desplaza a la derecha
--101 a 111 Conserva el dato

signal Estado_Actual, Proximo_Estado  : std_logic_vector(n-1 downto 0) := (others => '0');

begin

Combinacional: process(control, dato, Estado_Actual)
    begin
        
        case control is
        when "000" =>
            Proximo_Estado <= dato;
        when "001" =>
            Proximo_Estado <= std_logic_vector( unsigned(Estado_Actual) + 1 );
        when "010" =>
            Proximo_Estado <= std_logic_vector( unsigned(Estado_Actual) - 1 );
        when "011" =>
            Proximo_Estado(n-1 downto 1) <= Estado_Actual(n-2 downto 0);
            Proximo_Estado(0)            <= '0';
        when "100" =>
            Proximo_Estado(n-2 downto 0) <= Estado_Actual(n-1 downto 1);
            Proximo_Estado(n-1)          <= '0';
        when others =>
            Proximo_Estado <= Estado_Actual;          
        end case;

        salida <= Estado_Actual;

end process Combinacional;

Secuencial: process(clk, reset)
    begin
        if reset='1' then
            Estado_Actual <= (others => '0');
        elsif cke = '1' then
            if rising_edge(clk) then
                Estado_Actual <= Proximo_Estado;
            end if;
        end if;
    end process Secuencial;

end Behavioral;
