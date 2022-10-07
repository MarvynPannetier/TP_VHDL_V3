----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 11:20:27
-- Design Name: 
-- Module Name: detect_impulsion - Behavioral
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

entity detect_impulsion is
    Port ( clock : in STD_LOGIC;
         input : in STD_LOGIC;
         output : out STD_LOGIC);
end detect_impulsion;

architecture Behavioral of detect_impulsion is

-- signal copy : std_logic := '0';

begin

--    process(clock)
    
--    begin
    
        
--        if clock'event and clock = '1' then
        
--        copy <= input;
        
--            if input = '1' then  
--            output <= '1';        
--              --  output <= (clock xor copy) and clock;
--            else
--                output <= '0';
--            end if;
--        end if;
--    end process;

    process(clock)

        variable copy : std_logic := '0';

    begin
        if clock'event and clock = '1' then
            if input = '1' and copy = '0' then
                output <= '1';
                copy := '1';
            else
                output <= '0';
                if input ='0' then
                    copy := '0';
                end if;
            end if;
        end if;
    end process;
    

     
     

end Behavioral;
