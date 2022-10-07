----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.10.2022 14:56:12
-- Design Name: 
-- Module Name: timebase - Behavioral
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

entity timebase is
    Port ( clock : in STD_LOGIC;
         raz : in STD_LOGIC;
         output : out STD_LOGIC);
end timebase;

architecture Behavioral of timebase is

    signal cpt : std_logic_vector(11 downto 0) := x"000";

begin

    process (clock)

    begin

        if (clock'event and clock ='1') then

            if (raz ='1') then

                cpt <= x"000";

            else

                 if (cpt = 2267) then
                 output <= '1';
                 cpt <= x"000";
                 else
                 output <= '0';
                 cpt <= cpt + "000000000001";
                 end if;

            end if;
        end if;
    end process;

--  process( cpt)

--        begin

--            if (cpt = 2268) then
--                output<= '1';
--                cpt <= x"000";
--            else
--                output <= '0';
--            end if;

--        end process;

end Behavioral;
