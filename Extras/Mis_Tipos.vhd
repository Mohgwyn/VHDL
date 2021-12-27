----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 12:00:18
-- Design Name: 
-- Module Name: Mis_Tipos - Behavioral
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

Package Mis_Tipos is

    type Mi_Logica is ('U','0','1','X');
    type Mi_Logica_Vector is array( Natural range <> ) of Mi_Logica;
    
    function Resuelve( x : Mi_Logica_Vector ) return Mi_Logica;
    subtype Mi_Logica_Resuelta is Resuelve Mi_Logica;
end Mis_Tipos;

package body Mis_Tipos is 
    function Resuelve( x : Mi_Logica_Vector ) return Mi_Logica is
        type Tabla is array(Mi_Logica range 'U' to 'X',Mi_Logica range 'U' to 'X')
of Mi_Logica;

        constant Operacion : Tabla := (('U','0','1','X'),
                                       ('0','0','X','X'),
                                       ('1','X','1','X'),
                                       ('X','X','X','X'));
        variable Parcial : Mi_Logica := 'U';
    begin
        for i in x'Range loop
           Parcial := Operacion(Parcial,x(i));
        end loop;
        return Parcial;
    end Resuelve; 
end Mis_Tipos;