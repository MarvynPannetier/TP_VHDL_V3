----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 13:26:35
-- Design Name: 
-- Module Name: cpt_1_9 - Behavioral
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

entity cpt_1_9 is
    Port ( raz : in STD_LOGIC;
         incr : in STD_LOGIC;
         decr : in STD_LOGIC;
         clock : in STD_LOGIC;
         sortie : out STD_LOGIC_VECTOR (3 downto 0);
         vol : out STD_LOGIC_VECTOR (3 downto 0));
end cpt_1_9;

architecture Behavioral of cpt_1_9 is

    signal count : std_logic_vector(3 downto 0) := "0000";

begin

    PROCESS (raz, clock)
    BEGIN
        IF (raz = '1') THEN
            count <= "0000";
            
       elsif (clock'EVENT AND clock = '1') then
            if ( incr = '1' and count < 9) then
                count <= count + "0001";
            elsif ( decr = '1' and count > 0 ) then
                count <= count - "0001";
            end if;
        end if;
end process;

sortie <= count;
vol <= count;

end Behavioral;
