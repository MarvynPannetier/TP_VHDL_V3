----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 15:21:25
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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
--  IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gestion_freq is
    Port ( clock : in STD_LOGIC;
         RAZ : in STD_LOGIC;
         CE_affichage : out STD_LOGIC;
         CE_perception : out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is

    signal counter_3kHz : std_logic_vector(15 downto 0):=x"0000";
    constant DIVISOR_3kHz: std_logic_vector(15 downto 0):= x"823C";

    signal counter_10Hz : std_logic_vector(23 downto 0):=x"000000";
    constant DIVISOR_10Hz: std_logic_vector(23 downto 0):= x"98967F";


begin

    process(clock,RAZ)

    begin

        if (RAZ = '1') then
            CE_affichage <= '0';
            CE_perception <= '0';
        else

            if (clock'event and clock = '1') then

                if (counter_3kHz = DIVISOR_3kHz) then
                    counter_3kHz <= x"0000";
    CE_perception <= '1';
    else
                    counter_3kHz <= counter_3kHz + x"0001";
    CE_perception <= '0';
    end if;

                if (counter_10Hz = DIVISOR_10Hz) then
    counter_10Hz <= x"000000";
    CE_affichage <= '1';
    else
    counter_10Hz <= counter_10Hz + x"000001";
    CE_affichage <= '0';
    end if;
    
end if;
        end if;
    end process;


end Behavioral;
