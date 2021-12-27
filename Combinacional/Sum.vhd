----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2021 19:34:46
-- Design Name: 
-- Module Name: Sum - Simple
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
