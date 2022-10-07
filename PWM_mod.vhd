----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 10:57:33
-- Design Name: 
-- Module Name: PWM_mod - Behavioral
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

entity PWM_mod is
    Port ( idata : in STD_LOGIC_VECTOR (10 downto 0);
         CE_44100HZ : in STD_LOGIC;
         clock : in STD_LOGIC;
         pause : in STD_LOGIC;
         raz : in STD_LOGIC;
         indice_vol : in STD_LOGIC_VECTOR (3 downto 0);
         odata : out STD_LOGIC;
         EN : out STD_LOGIC);

    --  cop : out integer );
end PWM_mod;

architecture Behavioral of PWM_mod is

    signal output : std_logic := '0';

    --    subtype vol is integer;
    --    TYPE vol_table IS ARRAY(0 to 8) of vol;
    --    signal table : vol_table := (1300,1100,1000,900,800,770,750,720) ;

begin

    process ( clock )


        variable count : integer := 0;
        variable  copy : integer := 0;
        --  variable volu : integer :=0;
        --  variable amp : std_logic_vector(10 downto 0);

    begin

        copy := to_integer(signed(idata));

        CASE indice_vol is

            when "0001" =>
                copy := copy/8;
            when "0010" =>
                copy := copy/8;
            when "0011" =>
                copy := copy/6;
            when "0100" =>
                copy := copy/6;
            when "0101" =>
                copy := copy/4;
            when "0110" =>
                copy := copy/4;
            when "0111" =>
                copy := copy/2;
            when "1000" =>
                copy := copy/2;
            when "1001" =>
                copy := copy;
            When others =>
                copy := 0;
        end case;


        if (clock'event and clock ='1') then

            EN <= '1';

            if (raz ='1' ) then
                output <= '0';
                count := 0;
                EN <= '0';
            --elsif ( pause = '1') then

            --  EN <= '0';

            elsif (CE_44100HZ = '1' and output = '0' ) then

                output <= '1';
                count := 0;
            elsif ( output ='1') then

                --  if ( count < copy + table(to_integer(unsigned(indice_vol)))) then
                if ( count < copy + 725) then
                    count := count + 1;
                else
                    output <= '0';
                end if;
            end if;
        end if;

        odata <= output ;
        --   cop <= copy + 725;
    end process;

    -- odata <= output ; 

end Behavioral;
