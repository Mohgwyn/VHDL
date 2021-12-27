----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2021 20:55:11
-- Design Name: 
-- Module Name: contador - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contador is

    generic(n : integer := 3);
    port(din : in STD_LOGIC_VECTOR(n-1 downto 0);
         dout : out STD_LOGIC_VECTOR(n-1 downto 0);
         reset,ce,load : in STD_LOGIC;
         fdc : out STD_LOGIC;
         clk : in STD_LOGIC);
         
end contador;

architecture Behavioral of contador is
signal cuenta : unsigned(n-1 downto 0); 
begin
    process (clk, reset, ce)
    begin
        if to_integer(cuenta) = 2**n-1 then fdc <= '1'; else
            fdc <= '0';
        end if;
        if reset = '1' then
            cuenta <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                cuenta <= unsigned(din);
            elsif ce='1' then
                cuenta <= cuenta + 1;
            end if;
        end if;
        dout <= std_logic_vector(cuenta);
    end process;
end Behavioral;
