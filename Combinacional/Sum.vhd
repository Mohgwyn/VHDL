library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Sum is
    generic(n: integer := 2);
    Port ( x : in STD_LOGIC_VECTOR(n-1 downto 0);
           y : in STD_LOGIC_VECTOR(n-1 downto 0);
           s : out STD_LOGIC_VECTOR(n-1 downto 0));
end Sum;

architecture Simple of Sum is

begin
   
    s <= std_logic_vector( unsigned(x) + unsigned(y));

end Simple;
