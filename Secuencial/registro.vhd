----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.12.2021 23:01:50
-- Design Name: 
-- Module Name: Registro - Desplazamiento
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
