----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.09.2022 10:59:23
-- Design Name: 
-- Module Name: mux8 - Behavioral
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

entity mux8 is
    Port ( commande : in STD_LOGIC_VECTOR (2 downto 0);
         E0 : in STD_LOGIC_VECTOR (6 downto 0);
         E1 : in STD_LOGIC_VECTOR (6 downto 0);
         E2 : in STD_LOGIC_VECTOR (6 downto 0);
         E3 : in STD_LOGIC_VECTOR (6 downto 0);
         E4 : in STD_LOGIC_VECTOR (6 downto 0);
         E5 : in STD_LOGIC_VECTOR (6 downto 0);
         E6 : in STD_LOGIC_VECTOR (6 downto 0);
         E7 : in STD_LOGIC_VECTOR (6 downto 0);
         DP : out STD_LOGIC;
         S : out STD_LOGIC_VECTOR (6 downto 0));
end mux8;

architecture Behavioral of mux8 is

begin

    process (commande)
    begin
    
 --  DP <= '0';
  -- S <= "0100100";

        CASE commande is

            when "001" =>
                S <= E1;
                DP <= '1';
            when "010" =>
                S <= E2;
                DP <= '0';
            when "011" =>
                S <= E3;
                DP <= '1';
            when "100" =>
                S <= E4;
                DP <= '1';
            when "101" =>
                S <= E5;
                DP <= '1';
            when "110" =>
                S <= E6;
                DP <= '1';
            when "111" =>
                S <= E7;
                DP <= '1';
            When others =>
                S <= E0;
                DP <= '1';
        end case;
    end process;

end Behavioral;
