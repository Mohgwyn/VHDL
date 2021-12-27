----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2021 00:34:35
-- Design Name: 
-- Module Name: MUX - Comportamiento
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
use work.Tipos_ROM_MUX.all;
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
    generic( N_Bits_Dir : Natural := 2);
    Port   ( Direccion  : in  STD_LOGIC_VECTOR (N_Bits_Dir  - 1 downto 0);
             Dato       : out STD_LOGIC_VECTOR (N_Bits_Dato - 1 downto 0);
             Tabla_ROM  : in  Tabla(0 to 2**N_Bits_Dir-1));
end MUX;

architecture Comportamiento of MUX is
    
begin

    Dato <= Tabla_ROM(to_integer(unsigned(Direccion)));
    
end Comportamiento;
