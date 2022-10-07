----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2022 10:52:25
-- Design Name: 
-- Module Name: Interface_VHDL - Behavioral
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

entity Interface_VHDL is

    Port (     CLK100MHZ : in STD_LOGIC;
         raz : in STD_LOGIC;
         BTNU : in STD_LOGIC;
         BTND : in STD_LOGIC;
         BTNL : in STD_LOGIC;
         BTNR : in STD_LOGIC;
         BTNC : in STD_LOGIC;
         sens : out STD_LOGIC;
         pause_play : out STD_LOGIC;
         volume : out STD_LOGIC_VECTOR (3 downto 0);
         Sept_Segments : out STD_LOGIC_VECTOR (6 downto 0);
--         CA : out STD_LOGIC;
--         CB : out STD_LOGIC;
--         CC : out STD_LOGIC;
--         CD : out STD_LOGIC;
--         CE : out STD_LOGIC;
--         CF : out STD_LOGIC;
--         CG : out STD_LOGIC;
         DP : out STD_LOGIC;
         AN : out STD_LOGIC_VECTOR (7 downto 0));

end Interface_VHDL;

architecture Behavioral of Interface_VHDL is

    signal sortie_c : std_logic := '0';
    signal sortie_h : std_logic := '0';
    signal sortie_d : std_logic := '0';
    signal sortie_l : std_logic := '0';
    signal sortie_r : std_logic := '0';

    signal  s_PLAY_PAUSE : std_logic := '0';
    signal  s_RESTART : std_logic := '0';
    signal  s_FORWARD : std_logic := '0';
    signal  s_VOLUME_UP : std_logic := '0';
    signal  s_VOLUME_DOWN : std_logic:= '0';

    signal s_CE_affichage   : std_logic := '0';
    signal s_CE_perception   : std_logic := '0';

    signal sortie_cpt1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    signal sortie_cpt2 : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";

    signal s_cent: STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    signal s_dizaine: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal s_unit: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal s_vol: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie1: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie2: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie3: STD_LOGIC_VECTOR (6 downto 0):= "0000000";
    signal sortie4: STD_LOGIC_VECTOR (6 downto 0):= "0000000";

    signal s_commande: STD_LOGIC_VECTOR (2 downto 0);

  
    signal S: STD_LOGIC_VECTOR (6 downto 0);

begin
    -- dÃ©claration du component Ã  instancier
    bouton_center : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNC,
            output => sortie_c);

    bouton_high : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNU,
            output => sortie_h);

    bouton_down : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTND,
            output => sortie_d);

    bouton_right : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNR,
            output => sortie_r);

    bouton_left : entity work.detect_impulsion port map(
            clock => CLK100MHZ,
            input => BTNL,
            output => sortie_l);

    FSM : entity work.FSM_MP3 port map(
            clock => CLK100MHZ,
            reset => RAZ,
            B_UP => sortie_h,
            B_DOWN => sortie_d,
            B_CENTER => sortie_c,
            B_LEFT => sortie_l,
            B_RIGHT =>  sortie_r,
            PLAY_PAUSE => s_PLAY_PAUSE,
            RESTART => s_RESTART,
            FORWARD =>  s_FORWARD,
            VOLUME_UP =>  s_VOLUME_UP,
            VOLUME_DOWN => s_VOLUME_DOWN,
            pause_play => pause_play, 
            sens => sens );

    gest_freq : entity work.gestion_freq port map(
            clock => CLK100MHZ,
            RAZ => RAZ,
            CE_affichage => s_CE_affichage,
            CE_perception => s_CE_perception);

    cpt_1_9 : entity work.cpt_1_9 port map(
            raz => RAZ,
            incr =>  s_VOLUME_UP,
            decr =>  s_VOLUME_DOWN,
            clock => CLK100MHZ,
            sortie =>  sortie_cpt1,
            vol => volume);

    cpt_1_999 : entity work.cpt_1_999 port map(
            CE     => s_CE_affichage,
            clock  => CLK100MHZ,
            init   => s_RESTART,
            raz    => RAZ,
            play   => s_PLAY_PAUSE,
            sens   => s_FORWARD,
            sortie => sortie_cpt2 );

    trans : entity work.Trans port map(
            FORWARD    => s_FORWARD,
            PLAY_PAUSE => s_PLAY_PAUSE,
            RESTART    => s_RESTART,
            NB_MUS     => sortie_cpt2,
            NB_VOL     => sortie_cpt1,
            s_cent     => s_cent,
            s_dizaine  => s_dizaine,
            s_unit     => s_unit,
            s_vol      => s_vol,
            sortie1    => sortie1,
            sortie2    => sortie2,
            sortie3    => sortie3,
            sortie4    => sortie4 );

    mod8 : entity work.mod8 port map(
            CE     => s_CE_perception,
            clock  => CLK100MHZ,
            raz    => RAZ,
            AN_s     => AN,
--            AN_s(0) => AN(0),
--            AN_s(1) => AN(1),
--            AN_s(2) => AN(2),
--            AN_s(3) => AN(3),
--            AN_s(4) => AN(4),
--            AN_s(5) => AN(5),
--            AN_s(6) => AN(6),
--            AN_s(7) => AN(7),
            sortie => s_commande );

    mux8 : entity work.mux8 port map(
            commande => s_commande,
            E0       => s_cent,
            E1       => s_dizaine,
            E2       => s_unit,
            E3       => s_vol,
            E4       => sortie1,
            E5       => sortie2,
            E6       => sortie3,
            E7       => sortie4,
            DP       => DP,
            S     => Sept_Segments);

--            S(0)     => Sept_Segments(0),
--            S(1)     => Sept_Segments(1),
--            S(2)     => Sept_Segments(2),
--            S(3)     => Sept_Segments(3),
--            S(4)     => Sept_Segments(4),
--            S(5)     => Sept_Segments(5),
--            S(6)     => Sept_Segments(6));

-- faire des tests affichage choses simples

        -- dÃ©claration d'Ã©ventuels signaux
        -- ...



        -- pour le portmap, l'idée et de faire Sept_Segments(0) => CA, Sept_Segments(1) => CB ...etc et pour AN pareil mais tenter AN => AN car c'est un vecteur



end Behavioral;
