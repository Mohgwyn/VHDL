library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textIO.ALL;

entity Test_Bench is
--  Port ( );
end Test_Bench;

architecture Behavioral of Test_Bench is

    constant MEDIO_PERIODO : time := 5ns;
    
    component FSM_Secuencial port(reset, x, clk, cke : in  STD_LOGIC;
                                  y                  : out STD_LOGIC_VECTOR(2 downto 0));
    end component FSM_Secuencial;
    
    signal reset, x, clk, cke : STD_LOGIC := '0';
    signal y                  : STD_LOGIC_VECTOR(2 downto 0) := ( others => '0');
begin

DUT : FSM_Secuencial port map(x => x,
                              reset => reset,  
                              clk => clk,
                              cke => cke,
                              y => y );

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

Estimulos_Desde_Fichero : process

    file  Input_File : text;
    file Output_File : text;
    
    variable     Input_Data : BIT_VECTOR( 1 downto 0) := ( others => '0' );
    variable          Delay :      time := 0 ms;
    variable     Input_Line :      line := NULL;
    variable    Output_Line :      line := NULL;
    variable   Std_Out_Line :      line := NULL;
    variable       Correcto :   Boolean := True;
    constant           Coma : character := ',';

    
    begin
    
-- Semisumador_Estimulos.txt contiene los estímulos y los tiempos de retardo para el semisumador.
        file_open(  Input_File, "C:\Users\usuario\Desktop\javi\eii\Electronica\FSM\FSM.txt", read_mode );
-- Semisumador_Estimulos.csv contiene los estímulos y los tiempos de retardo para el Analog Discovery 2.
        file_open( Output_File, "C:\Users\usuario\Desktop\javi\eii\Electronica\FSM\FSM.csv", write_mode );
        
-- Titles: Son para el formato EXCEL *.CSV (Comma Separated Values):
        write( Std_Out_Line, string'(  "Entrada" ) , right, 7 );
        write( Std_Out_Line,                 coma  , right, 1 );
        write( Std_Out_Line, string'(  "(cke, x)" ), right, 7 );
                
        Output_Line := Std_Out_Line;
               
        writeline(      output, Std_Out_Line );
        writeline( Output_File,  Output_Line );

        while ( not endfile( Input_File ) ) loop    
        
            readline( Input_File, Input_Line );
            
            read( Input_Line, Delay, Correcto );	-- Comprobación de que se trata de un texto que representa
													-- el retardo, si no es así leemos la siguiente línea.           
            if Correcto then

                read( Input_Line, Input_Data );		-- El siguiente campo es el vector de pruebas.
                
                x   <= TO_STDLOGICVECTOR( Input_Data )( 0 );
                cke <= TO_STDLOGICVECTOR( Input_Data )( 1 );
													-- De forma simultánea lo volcaremos en consola en csv.
                write( Std_Out_Line,        Delay, right, 5 ); -- Longitud del retardo, ej. "20 ms".
                write( Std_Out_Line,         Coma, right, 1 );
                write( Std_Out_Line,   Input_Data, right, 5 ); --Longitud de los datos de entrada.
                
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
