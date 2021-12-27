----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 12:10:40
-- Design Name: 
-- Module Name: TB - Behavioral
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
use work.Mis_Tipos.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB is
--  Port ( );
end TB;

architecture Behavioral of TB is
    
    signal s_sr : Mi_Logica          := 'U';
    signal s_r  : Mi_Logica_Resuelta := 'U';
begin

Bus_End_Point_1: process
    begin
        --s_sr <= '0' after 5ns, '1' after 10ns, 'X' after 12 ns;
        s_r  <= '0' after 5ns, '1' after 10ns, 'X' after 20 ns;
        wait;
end process Bus_End_Point_1;

Bus_End_Point_2: process
    begin
        s_sr <= '0' after 5ns, '1' after 12ns, 'X' after 15 ns;
        s_r  <= '0' after 5ns, '1' after 12ns, 'X' after 15 ns;
        wait;
    end process Bus_End_Point_2;
    
end Behavioral;
