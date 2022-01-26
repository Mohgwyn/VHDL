library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

Package Tipos_FSM_PLC is    -- En este paquete defino mis tipos
                            -- de datos constantes y se�ales globales, subprogramas, etc.
                            -- El tipo Tabla es com�n para generar una ROM � un Multiplexor.
    constant N_Bits_Dato : Natural := 32; -- Anchura del dato de la tabla.                            
    type Tabla_FSM is array( Natural range <> ) of STD_LOGIC_VECTOR( N_Bits_Dato - 1 downto 0 );
                            -- Requerimientos de E/S del enunciado:
    constant       k_Max : natural := 3;   -- 3 entradas como m�ximo.
    constant       p_Max : natural := 4;   -- p salidas como m�ximo.
    constant       m_Max : natural := 4;   -- m biestables como m�ximo. (Hasta 16 estados)
end Tipos_FSM_PLC;