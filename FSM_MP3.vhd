----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.09.2022 11:06:07
-- Design Name: 
-- Module Name: FSM_MP3 - Behavioral
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_MP3 is
    Port ( clock : in STD_LOGIC;
         reset : in STD_LOGIC;
         B_UP : in STD_LOGIC;
         B_DOWN : in STD_LOGIC;
         B_CENTER : in STD_LOGIC;
         B_LEFT : in STD_LOGIC;
         B_RIGHT : in STD_LOGIC;
         PLAY_PAUSE : out STD_LOGIC;
         RESTART : out STD_LOGIC;
         FORWARD : out STD_LOGIC;
         VOLUME_UP : out STD_LOGIC;
         VOLUME_DOWN : out STD_LOGIC;
         pause_play : out std_logic;
         sens : out std_logic);
         
end FSM_MP3;

architecture Behavioral of FSM_MP3 is

    TYPE STATE_TYPE IS (init, play_fwd, play_bwd, pause, stop);
    --SIGNAL current_state : STATE_TYPE;
    --SIGNAL next_state : STATE_TYPE;
    SIGNAL state : STATE_TYPE;
begin


    PROCESS (clock)
    BEGIN
        IF (clock'EVENT AND clock = '1') THEN
            IF RESET = '1' THEN
                state <= INIT;
            ELSE
                CASE state IS
                    WHEN INIT =>
                        IF B_CENTER = '1' THEN 
                        state <= PLAY_FWD;
                        ELSE state <= INIT;
                        END IF;
                    WHEN PLAY_FWD =>
                        IF B_CENTER = '1' THEN state <= PAUSE;
                        ELSE state <= PLAY_FWD;
                        END IF;
                    WHEN PLAY_BWD =>
                        IF B_CENTER = '1' THEN state <= PAUSE;
                        ELSE state <= PLAY_BWD;
                        END IF;
                    WHEN PAUSE =>
                        IF B_LEFT = '1' THEN state <= PLAY_BWD;
                        ELSIF B_RIGHT = '1' THEN state <= PLAY_FWD;
                        ELSIF B_CENTER = '1' THEN state <= STOP;
                        ELSE state <= PAUSE;
                        END IF;
                    WHEN STOP =>
                        IF B_CENTER = '1' THEN state <= PLAY_FWD;
                        ELSE state <= STOP;
                        END IF;

                    WHEN OTHERS => state <= INIT;
                END CASE;
            END IF;
        END IF;
    END PROCESS;

    --Output signal computation
    RESTART <= '1' WHEN (state = INIT) OR (state = STOP) ELSE
                  '0';
    PLAY_PAUSE <= '1' WHEN (state = PLAY_BWD) OR (state = PLAY_FWD) ELSE
                  '0';
    
    pause_play <= '1' WHEN (state = PLAY_BWD) OR (state = PLAY_FWD) ELSE
                  '0';              
                  
    VOLUME_UP <= B_UP WHEN (state = PLAY_BWD) OR (state = PLAY_FWD) ELSE
                  '0';
    VOLUME_DOWN <= B_DOWN WHEN (state = PLAY_BWD) OR (state = PLAY_FWD) ELSE
                  '0';
    FORWARD <= '1' WHEN (state = PLAY_FWD) ELSE
                  '0';
                  
    sens <= '1' WHEN (state = PLAY_FWD) ELSE
                  '0';

end Behavioral;
