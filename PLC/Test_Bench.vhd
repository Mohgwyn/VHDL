library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textIO.ALL;
use work.Tipos_FSM_PLC.all;

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is

constant k    : natural := 3;
constant p    : natural := 4;
constant m    : natural := 4;
constant T_DM, T_D, T_SU, T_H, T_W : time := 10 ps;
constant MEDIO_PERIODO : time := 5ns;
constant ZERO : std_logic_vector(31 downto 0) := (others => '0');

component FSM_PLC generic (k, p, m : natural;
                           T_DM, T_D, T_SU, T_H, T_W : time);
                  port ( clk, cke, reset, trigger : in STD_LOGIC;
                         x : in  STD_LOGIC_VECTOR( K-1 downto 0);
                         y : out STD_LOGIC_VECTOR( p-1 downto 0);
                         Tabla_De_Estado, Tabla_De_Salida : in Tabla_FSM( 0 to 2**m-1));
end component FSM_PLC;

signal x : STD_LOGIC_VECTOR( k - 1 downto 0 );
signal y : STD_LOGIC_VECTOR( p - 1 downto 0 );

signal Tabla_De_Estado : Tabla_FSM( 0 to 2**m-1 ) := 
(ZERO(31 downto 8) & "00100001",  --Para el estado 0 los posibles proximos son 1 o 2
 ZERO(31 downto 8) & "00110010",  --Para el estado 1 los posibles proximos son 2 o 3
 ZERO(31 downto 8) & "01000011",  --Para el estado 2 los posibles proximos son 3 o 4
 ZERO(31 downto 8) & "01010100",  --Para el estado 3 los posibles proximos son 4 o 5
 ZERO(31 downto 8) & "01100101",  --Para el estado 4 los posibles proximos son 5 o 6
 ZERO(31 downto 8) & "01110110",  --Para el estado 5 los posibles proximos son 6 o 7
 ZERO(31 downto 8) & "00000111",  --Para el estado 6 los posibles proximos son 7 o 0
 ZERO(31 downto 8) & "00010000",  --Para el estado 7 los posibles proximos son 0 o 1
 ZERO(31 downto 8) & "00000000",
 ZERO(31 downto 8) & "00000000",
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0));
 
signal Tabla_De_Salida : Tabla_FSM( 0 to m**2-1 ) := 
(ZERO(31 downto 4) & "0000",  --Para el estado 0 la salida es 0
 ZERO(31 downto 4) & "0001",  --Para el estado 1 la salida es 1
 ZERO(31 downto 4) & "0010",  --Para el estado 2 la salida es 2
 ZERO(31 downto 4) & "0011",  --Para el estado 3 la salida es 3
 ZERO(31 downto 4) & "0100",  --Para el estado 4 la salida es 4
 ZERO(31 downto 4) & "0101",  --Para el estado 5 la salida es 5
 ZERO(31 downto 4) & "0110",  --Para el estado 6 la salida es 6
 ZERO(31 downto 4) & "0111",  --Para el estado 7 la salida es 7
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0),
 ZERO(31 downto 0));
 
signal clk     : STD_LOGIC;
signal cke     : STD_LOGIC;             
signal reset   : STD_LOGIC;
signal Trigger : STD_LOGIC;

begin

DUT: FSM_PLC
    generic map ( k => k, p => p, m => m, T_DM => T_DM, T_D => T_D, T_SU => T_SU, T_H => T_H, T_W => T_W)
    port    map (clk => clk, cke => cke, reset => reset, trigger => trigger, x => x, y => y, 
                 Tabla_De_Estado => Tabla_De_Estado, Tabla_De_Salida => Tabla_De_Salida);
    
Reloj: process
begin
    clk <= '1';
    wait for MEDIO_PERIODO;
    clk <= '0';
    wait for MEDIO_PERIODO;
end process Reloj;

clear: process
begin
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait;
end process clear;

disparo: process
begin
    wait for 10 ns;
    trigger <= '0';
    wait for 1 ps;
    trigger <= '1';
    wait for 2 ps;
    trigger <= '0';
    wait for 2 ps;
    trigger <= '1';
    wait for 1 ps;
    trigger <= '0';
    wait for 1 ps;
    trigger <= '1';
    wait for 2 ps;
    trigger <= '0';
    wait for 1 ps;
    trigger <= '1';
    wait for 2 ps;
    trigger <= '0';
    wait for 50 ns;
    trigger <= '1';
    wait for 100 ns;
    trigger <= '0';
    wait;   
end process disparo;

Enable: process
begin
    cke <= '0';
    wait for 300 ns;
    cke <= '1';
    wait;
end process Enable;

Estimulos_Desde_Fichero : process

    file  Input_File : text;
    file Output_File : text;
    
    variable     Input_Data : BIT_VECTOR( 2 downto 0 ) := ( OTHERS => '0' );
    variable          Delay :      time := 0 ms;
    variable     Input_Line :      line := NULL;
    variable    Output_Line :      line := NULL;
    variable   Std_Out_Line :      line := NULL;
    variable       Correcto :   Boolean := True;
    constant           Coma : character := ',';

    
    begin
    
-- Semisumador_Estimulos.txt contiene los estímulos y los tiempos de retardo para el semisumador.
        file_open(  Input_File, "C:\Users\nadie\Desktop\javi\eii\Electronica\PLC\PLC.txt", read_mode );
-- Semisumador_Estimulos.csv contiene los estímulos y los tiempos de retardo para el Analog Discovery 2.
        file_open( Output_File, "C:\Users\nadie\Desktop\javi\eii\Electronica\PLC\PLC.csv", write_mode );
        
-- Titles: Son para el formato EXCEL *.CSV (Comma Separated Values):
        write( Std_Out_Line, string'(  "Tiempo" ), right, 6 );
        write( Std_Out_Line,                  Coma, right, 1 );
        write( Std_Out_Line, string'( "Entrada" ), right, 7 );        
                
        Output_Line := Std_Out_Line;
               
        writeline(      output, Std_Out_Line );
        writeline( Output_File,  Output_Line );

        while ( not endfile( Input_File ) ) loop    
        
            readline( Input_File, Input_Line );
            
            read( Input_Line, Delay, Correcto );	-- Comprobación de que se trata de un texto que representa
													-- el retardo, si no es así leemos la siguiente línea.           
            if Correcto then

                read( Input_Line, Input_Data );		-- El siguiente campo es el vector de pruebas.
                
                x <= TO_STDLOGICVECTOR( Input_Data );
                
													-- De forma simultánea lo volcaremos en consola en csv.
                write( Std_Out_Line,        Delay, right, 5 ); -- Longitud del retardo, ej. "20 ms".
                write( Std_Out_Line,         Coma, right, 1 );
                write( Std_Out_Line,   Input_Data, right, 3 ); --Longitud de los datos de entrada.
                
                Output_Line := Std_Out_Line;
                
                writeline(      output, Std_Out_Line );
                writeline( Output_File, Output_Line );
        
                wait for Delay;
            end if;
         end loop;
         
         file_close(  Input_File );	-- Cerramos el fichero de entrada.
         file_close( Output_File );	-- Cerramos el fichero de salida.
         wait;		 
    end process Estimulos_Desde_Fichero;

end Behavioral;
