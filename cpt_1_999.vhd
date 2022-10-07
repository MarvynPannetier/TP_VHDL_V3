----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 14:59:54
-- Design Name: 
-- Module Name: cpt_1_999 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpt_1_999 is
    Port ( CE : in STD_LOGIC;
         clock : in STD_LOGIC;
         init : in STD_LOGIC;
         raz : in STD_LOGIC;
         play : in STD_LOGIC;
         sens : in STD_LOGIC;
         sortie : out STD_LOGIC_VECTOR (9 downto 0));
end cpt_1_999;

architecture Behavioral of cpt_1_999 is

    signal count : std_logic_vector(9 downto 0) := "0000000000";

begin

process( raz, clock, init)
begin

    if (raz ='1' or init = '1') then
        count <= "0000000000";
    elsif (clock'event and clock ='1') then

        if ( CE ='1') then

            if ( play = '1') then

                if (sens ='1' and count < 999) then
                    count <= count + "0000000001";
                elsif (sens ='0' and count > 0) then
                    count <= count - "0000000001";
                end if;
            end if;
        end if;
    end if;
end process;

sortie <= count;


end Behavioral;
