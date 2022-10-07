----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 16:38:01
-- Design Name: 
-- Module Name: mod8 - Behavioral
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
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mod8 is
    Port ( CE : in STD_LOGIC;
         clock : in STD_LOGIC;
         raz : in STD_LOGIC;
         AN_s : out STD_LOGIC_VECTOR (7 downto 0);
         sortie : out STD_LOGIC_VECTOR (2 downto 0));
end mod8;

architecture Behavioral of mod8 is

    signal count : std_logic_vector(2 downto 0) := "000";
    signal copy : std_logic_vector(7 downto 0) := "00000000";
    signal count_int : integer := 0;
begin

    process (raz, clock)
    begin

        if (raz ='1') then
            count <= "000";
        elsif ( clock'event and clock = '1') then
            if (CE = '1') then
                if ( count < "111") then
                    count <= count + "001";
                else
                    count <= "000";
                end if;
            end if;
        end if;

        copy <= "11111111";
        count_int <= to_integer(unsigned(count));
        copy(count_int) <= '0';

    end process;

    sortie <= count;
    AN_s <= copy;
  --  AN_s <= "10101010";


end Behavioral;

-- 0 à 7 sur 3 bits pour sélectionner la donnée à afficher 
-- 00000000 à 11111111 pour sélectionner l'afficheur 7 segments à utiliser 

--bloc transcodeur recoit les données bon format et actualise en même temps que changement d'afficheur (sortie 8bits mod8) et azffiche les septs segments d'un seul coup
