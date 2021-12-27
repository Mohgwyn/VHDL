library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Package Tipos_ROM_MUX is

    constant N_Bits_Dato : natural := 8;
    type Tabla is array( Natural range <> ) of STD_LOGIC_VECTOR(N_Bits_Dato - 1 downto 0);
end Tipos_ROM_MUX;
