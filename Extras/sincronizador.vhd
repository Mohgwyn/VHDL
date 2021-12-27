----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2021 13:46:13
-- Design Name: 
-- Module Name: Sincronizador - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sincronizador is
    generic ( n_sin : integer );
    Port ( I : in STD_LOGIC;
           CKE : out STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC);
end Sincronizador;

architecture Estructura of Sincronizador is
    signal s2 : std_logic;
    
    component Debouncer is 
        generic ( n_sin : integer );
        port( I : in std_logic; O : out std_logic; reset: in std_logic; clk: in std_logic);
    end component;
    
    component CKE_Gen is port( I : in std_logic; O : out std_logic; reset : in std_logic; clk : in std_logic);
    end component;
    
begin

    DB: Debouncer generic map(n_sin)
                  port map (I=>I, O=>s2, reset=>reset, clk=>clk);
                  
    CKGEN: CKE_Gen port map (I=>s2, O=>CKE, reset=>reset, clk=>clk);

end Estructura;