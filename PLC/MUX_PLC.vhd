library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.Tipos_FSM_PLC.all;
use IEEE.NUMERIC_STD.ALL;

entity MUX_PLC is
    generic( N_Bits_Dir : Natural := 3;
             T_D        : time    := 10 ps ); -- Tiempo de retardo desde el cambio de direcci�n hasta la actualizaci�n de la salida Q. 
    Port   ( Direccion  : in  STD_LOGIC_VECTOR ( N_Bits_Dir  - 1 downto 0 );
             Dato       : out STD_LOGIC_VECTOR ( N_Bits_Dato - 1 downto 0 );
             Tabla_ROM  : in  Tabla_FSM( 0 to 2**N_Bits_Dir - 1 ) );
end MUX_PLC;

architecture Comportamiento of MUX_PLC is

begin
    Dato <= transport Tabla_ROM( to_integer( unsigned( Direccion ) ) ) after T_D;
end Comportamiento;
