----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.10.2022 10:57:49
-- Design Name: 
-- Module Name: syst - Behavioral
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

entity syst is
    Port ( clock : in STD_LOGIC;
         raz : in STD_LOGIC;
         uart_rx : in std_logic;
         sens : in STD_LOGIC;
         pause : in STD_LOGIC;
         volume : in STD_LOGIC_VECTOR (3 downto 0);
         PWM_EN : out STD_LOGIC;
         out_PWM : out STD_LOGIC);
end syst;

architecture Behavioral of syst is

    signal out_timebase : std_logic ;
    signal out_compteur : STD_LOGIC_VECTOR (16 downto 0);
    signal out_RAM: STD_LOGIC_VECTOR(10 DOWNTO 0) ;
    signal odata: STD_LOGIC;
    signal memory_addr : STD_LOGIC_VECTOR (16 downto 0);
    signal   data_value  : STD_LOGIC_VECTOR (15 downto 0);
    signal    memory_wen  : STD_LOGIC;

begin

    TimeCE : entity work.timebase port map (
            clock  => clock,
            raz    => raz,
            output => out_timebase );

    compt : entity work.Compteur port map (
            raz     => raz,
            clock   => clock,
            CE44100 => out_timebase,
            pause => pause,
            sens => sens,
            MAX => memory_addr,
            output  => out_compteur );

    uart : entity work.full_UART_recv port map (

            clk_100MHz => clock,
            reset => raz,
            rx =>  uart_rx,
            memory_addr => memory_addr,
            data_value => data_value,
            memory_wen => memory_wen );


    RAM: entity work.RAM port map(
            CLOCK    => CLOCK,
            compteur   => out_compteur,
            addr => memory_addr,
            value => data_value,
            enable => memory_wen,
            output   => out_RAM);

    PWM_audio : entity work.PWM_mod port map (
            idata      => out_RAM,
            CE_44100HZ => out_timebase,
            clock      => clock,
            pause => pause,
            raz        => raz,
            indice_vol => volume,
            odata      => out_PWM,
            EN => PWM_EN );


end Behavioral;
