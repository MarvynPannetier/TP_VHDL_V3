----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.09.2022 11:14:46
-- Design Name: 
-- Module Name: Trans - Behavioral
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

entity Trans is
    Port ( FORWARD : in STD_LOGIC;
         PLAY_PAUSE : in STD_LOGIC;
         RESTART : in STD_LOGIC;
         NB_MUS : in STD_LOGIC_VECTOR (9 downto 0);
         NB_VOL : in STD_LOGIC_VECTOR (3 downto 0);
         s_cent : out STD_LOGIC_VECTOR (6 downto 0);
         s_dizaine : out STD_LOGIC_VECTOR (6 downto 0);
         s_unit : out STD_LOGIC_VECTOR (6 downto 0);
         s_vol : out STD_LOGIC_VECTOR (6 downto 0);
         sortie1 : out STD_LOGIC_VECTOR (6 downto 0);
         sortie2 : out STD_LOGIC_VECTOR (6 downto 0);
         sortie3 : out STD_LOGIC_VECTOR (6 downto 0);
         sortie4 : out STD_LOGIC_VECTOR (6 downto 0));
end Trans;

architecture Behavioral of Trans is

    signal volume : STD_LOGIC_VECTOR (6 downto 0) := "1001111";
    signal cent_s : STD_LOGIC_VECTOR (6 downto 0) := "0100100";
    signal diz_s : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    signal unit_s : STD_LOGIC_VECTOR (6 downto 0) := "0000001";
    signal init : std_logic := '0';
    -- signal MUS : integer := to_integer(unsigned(NB_MUS));


    -- signal lim : integer := 0;

begin




    state : process(FORWARD,PLAY_PAUSE,RESTART)



    begin

        if RESTART = '1' then

            sortie1 <= "0110001";
            sortie2 <= "1111110";
            sortie3 <= "1111110";
            sortie4 <= "0000111";


        elsif PLAY_PAUSE = '1' then



            if FORWARD = '1' then

                sortie1 <= "1111110";
                sortie2 <= "1111110";
                sortie3 <= "1111110";
                sortie4 <= "0000111";

            elsif FORWARD ='0' then

                sortie1 <= "0110001";
                sortie2 <= "1111110";
                sortie3 <= "1111110";
                sortie4 <= "1111110";

            end if;
        elsif PLAY_PAUSE = '0' then

            init <= '0';

            sortie1 <= "1111110";
            sortie2 <= "1111110";
            sortie3 <= "1111110";
            sortie4 <= "1111110";

        end if;
    end process;

    vol : process (NB_VOL)

        variable i : integer := 0;


    begin

        if ( RESTART ='1') then
            volume <= "1001111";
        else
            CASE NB_VOL is

                when "0001" =>
                    volume <= "1001111";
                when "0010" =>
                    volume <= "0010010";
                when "0011" =>
                    volume <= "0000110";
                when "0100" =>
                    volume <= "1001100";
                when "0101" =>
                    volume <= "0100100";
                when "0110" =>
                    volume <= "0100000";
                when "0111" =>
                    volume <= "0001111";
                when "1000" =>
                    volume <= "0000000";
                when "1001" =>
                    volume <= "0000100";
                When others =>
                    volume <= "0000001";
            end case;

        end if;

    end process;

    --lim <= to_integer(unsigned(NB_MUS)) ;

    nbmus : process (NB_MUS)

        variable lim : integer := 0;
        variable cent : integer := 0;
        variable diz : integer := 0;
        variable unit : integer := 0;
        --    variable init : std_logic :='0';

    begin


        -- MUS <= to_integer(unsigned(NB_MUS));
        lim := to_integer(unsigned(NB_MUS)) ;
        cent := 0;
        diz := 0;

        for i in 0 to 9 loop

            if ((lim - 100) > 0) then
                cent := cent + 1;
                lim := lim -100;
            end if;

        end loop;



        CASE cent is

            when 1 =>
                cent_s <= "1001111";
            when 2 =>
                cent_s <= "0010010";
            when 3 =>
                cent_s <= "0000110";
            when 4 =>
                cent_s <= "1001100";
            when 5 =>
                cent_s <= "0100100";
            when 6 =>
                cent_s <= "0100000";
            when 7 =>
                cent_s <= "0001111";
            when 8 =>
                cent_s <= "0000000";
            when 9 =>
                cent_s <= "0000100";
            When others =>
                if ( RESTART ='1') then
                    cent_s <= "0100100";
                else
                    cent_s <= "0000001";
                end if;

        end case;

        lim := to_integer(unsigned(NB_MUS)) - (cent*100) ;


        for i in 0 to 9 loop

            if ((lim - 10) > 0) then
                diz := diz + 1;
                lim := lim -10;
            end if;

        end loop;

        CASE diz is

            when 1 =>
                diz_s <= "1001111";
            when 2 =>
                diz_s <= "0010010";
            when 3 =>
                diz_s <= "0000110";
            when 4 =>
                diz_s <= "1001100";
            when 5 =>
                diz_s <= "0100100";
            when 6 =>
                diz_s <= "0100000";
            when 7 =>
                diz_s <= "0001111";
            when 8 =>
                diz_s <= "0000000";
            when 9 =>
                diz_s <= "0000100";
            When others =>
                diz_s <= "0000001";
        end case;


        unit := to_integer(unsigned(NB_MUS)) - (cent*100) - (diz*10) ;



        CASE unit is

            when 1 =>
                unit_s <= "1001111";
            when 2 =>
                unit_s <= "0010010";
            when 3 =>
                unit_s <= "0000110";
            when 4 =>
                unit_s <= "1001100";
            when 5 =>
                unit_s <= "0100100";
            when 6 =>
                unit_s <= "0100000";
            when 7 =>
                unit_s <= "0001111";
            when 8 =>
                unit_s <= "0000000";
            when 9 =>
                unit_s <= "0000100";
            When others =>
                unit_s <= "0000001";
        end case;


    end process;

    s_vol <= volume;
    s_cent <= cent_s;
    s_dizaine <= diz_s;
    s_unit <= unit_s;

    --tout inversé dans vecteur!!

end Behavioral;
