----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 14:19:44
-- Design Name: 
-- Module Name: Compteur - Behavioral
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

entity Compteur is
    Port ( raz : in STD_LOGIC;
         clock : in STD_LOGIC;
         CE44100 : in STD_LOGIC;
         pause : in STD_LOGIC;
         sens : in STD_LOGIC;
         --EN : in std_logic ;
         MAX : in STD_LOGIC_VECTOR (16 downto 0);
         output : out STD_LOGIC_VECTOR (16 downto 0));
end Compteur;

architecture Behavioral of Compteur is

    signal count : STD_LOGIC_VECTOR ( 16  downto 0) := (others => '0');
    signal count_reverse : STD_LOGIC_VECTOR ( 16  downto 0) := MAX;
begin

    process (clock)

        variable count_out : STD_LOGIC_VECTOR (16  downto 0);

    begin

        if (clock'event and clock='1') then

            if (raz ='1') then
                count <= (others => '0');
                count_reverse <= MAX;

            elsif ( CE44100 = '1') then -- and pause = '0' ) then

                if ( pause  = '1') then

                    if ( sens = '1') then
                        if ( count < MAX) then
                            count <= count + 1;
                        else
                            count <= (others => '0');
                        end if;
                        count_out := count;
                    elsif ( sens ='0') then
                        if ( count_reverse > 0) then
                            count_reverse <= count_reverse - 1;
                        else
                            count_reverse <= MAX;
                        end if;

                        count_out := count_reverse;
                    end if;
                end if;

            end if;
        end if;
        output <= count_out ;
    end process;

    --output <= count ;
end Behavioral;
