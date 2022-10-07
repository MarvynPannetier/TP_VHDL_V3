----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 11:18:45
-- Design Name: 
-- Module Name: detec_bouton - Behavioral
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

entity detec_bouton is
    Port ( haut : in STD_LOGIC;
           bas : in STD_LOGIC;
           droite : in STD_LOGIC;
           gauche : in STD_LOGIC;
           centre : in STD_LOGIC;
           clock : in STD_LOGIC;
           output : out STD_LOGIC);
end detec_bouton;

architecture Behavioral of detec_bouton is

begin


end Behavioral;
