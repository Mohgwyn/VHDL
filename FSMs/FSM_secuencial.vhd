library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity FSM_secuencial is

    Port ( x     : in  std_logic;
           y     : out std_logic_vector(2 downto 0);
           reset : in  std_logic;
           clk   : in  std_logic;
           cke   : in std_logic );
    type Estado is ( E1, E2, E3, E4, E5, E6, E7, E8);

end FSM_secuencial;

architecture Behavioral of FSM_secuencial is

signal Estado_Actual  : Estado := E1;
signal Proximo_Estado : Estado := E2;
signal cuenta         : unsigned(2 downto 0);

begin

Combinacional: process(x, Estado_Actual)
    begin
    
        case Estado_Actual is
        when E1 =>
            cuenta <= "000";
            if x='1' then
                Proximo_Estado <= E3;
            else
                Proximo_Estado <= E2;
            end if;
            
        when E2 =>
            cuenta <= "001";
            if x='1' then
                Proximo_Estado <= E4;
            else
                Proximo_Estado <= E3;
            end if;
            
        when E3 =>
            cuenta <= "010";
            if x='1' then
                Proximo_Estado <= E5;
            else
                Proximo_Estado <= E4;
            end if;
            
        when E4 =>
            cuenta <= "011";
            if x='1' then
                Proximo_Estado <= E6;
            else
                Proximo_Estado <= E5;
            end if;
            
        when E5 =>
            cuenta <= "100";
            if x='1' then
                Proximo_Estado <= E7;
            else
                Proximo_Estado <= E6;
            end if;
            
        when E6 =>
            cuenta <= "101";
            if x='1' then
                Proximo_Estado <= E8;
            else
                Proximo_Estado <= E7;
            end if;
            
        when E7 =>
            cuenta <= "110";
            if x='1' then
                Proximo_Estado <= E1;
            else
                Proximo_Estado <= E8;
            end if;
            
        when E8 =>
            cuenta <= "111";
            if x='1' then
                Proximo_Estado <= E2;
            else
                Proximo_Estado <= E1;
            end if;
        end case;        
    y <= std_logic_vector( cuenta );
    end process Combinacional;

Secuencial: process(clk, reset)
    begin
        if reset='1' then
            Estado_Actual <= E1;
        elsif cke = '1' then
            if rising_edge(clk) then
                Estado_Actual <= Proximo_Estado;
            end if;
        end if;
    end process Secuencial;
    
end Behavioral;
