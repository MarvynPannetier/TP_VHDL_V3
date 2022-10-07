----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.10.2022 10:49:32
-- Design Name: 
-- Module Name: Global_syst - Behavioral
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

entity Global_syst is

    Port (     clock : in STD_LOGIC;
         reset : in STD_LOGIC;
         BU : in STD_LOGIC;
         BD : in STD_LOGIC;
         BL : in STD_LOGIC;
         BR : in STD_LOGIC;
         BC : in STD_LOGIC;
        -- sens : out STD_LOGIC;
      --   pause : out STD_LOGIC;
      --   volume : out STD_LOGIC_VECTOR (3 downto 0);
         sept_s : out STD_LOGIC_VECTOR (6 downto 0);
         point : out STD_LOGIC;
         afficheur : out STD_LOGIC_VECTOR (7 downto 0);
         RX : in std_logic;
         EN_PWM : out STD_LOGIC;
         PWM_out : out STD_LOGIC);



end Global_syst;

architecture Behavioral of Global_syst is

signal s_sens : std_logic;
signal s_pause : std_logic;
signal s_volume : STD_LOGIC_VECTOR (3 downto 0);

begin 


    IHM : entity work.Interface_VHDL port map(
    
         CLK100MHZ => clock,
         raz => reset,
         BTNU => BU,
         BTND => BD,
         BTNL => BL,
         BTNR => BR,
         BTNC => BC,
         sens => s_sens,
         pause_play => s_pause,
         volume => s_volume,
         Sept_Segments => sept_s,
         DP => point,
         AN => afficheur);
         
systeme : entity work.syst port map(

clock => clock,
raz => reset,
uart_rx =>  RX,
sens => s_sens,
pause => s_pause,
volume => s_volume,
PWM_EN => EN_PWM, 
out_PWM => PWM_out);       
         

end Behavioral;
