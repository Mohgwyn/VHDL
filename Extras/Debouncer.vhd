----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2021 13:13:58
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

entity Debouncer is
    generic(n_sin: integer);
    Port ( I : in STD_LOGIC;
           O : out STD_LOGIC;
           reset : in STD_LOGIC;
           clk : in STD_LOGIC);
end Debouncer;

architecture Simple of Debouncer is

signal s : STD_LOGIC_VECTOR(n_sin-1 downto 0);
constant UNOS : STD_LOGIC_VECTOR(n_sin-1 downto 0) := ( others => '1' );

component Reg_Des is
    generic(n : integer);
    port( d:in std_logic; 
          q: out std_logic_vector(n-1 downto 0); 
          reset: in std_logic;
          des: in std_logic;
          clk: in std_logic);
end component Reg_Des;

begin
Registro: Reg_Des generic map(n_sin)
        port map(d=>I, 
                 q=>s, 
                 reset=>reset, 
                 des=>'1', 
                 clk=>clk);
        O <= transport '1' after 1ns when s=UNOS else '0' after 1ns; 
end Simple;
