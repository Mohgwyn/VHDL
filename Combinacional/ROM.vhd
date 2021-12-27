----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2021 00:27:14
-- Design Name: 
-- Module Name: ROM - Comportamiento
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

entity ROM is
    generic( N_Bits_Dir : natural := 2);
    Port   ( Direccion  : in  STD_LOGIC_VECTOR (N_Bits_Dir  - 1 downto 0);
             Dato       : out STD_LOGIC_VECTOR (N_Bits_Dato - 1 downto 0));
end ROM;

architecture Comportamiento of ROM is
    constant Tabla_ROM : Tabla(0 to 2**N_Bits_Dir-1) :=
    (('1','0','1','0','1','0','1','0'),
       b"1011_1011",
       x"CC",
       x"DD");
begin
    Dato <= Tabla_ROM(to_integer(unsigned(Direccion)));    
end Comportamiento;
