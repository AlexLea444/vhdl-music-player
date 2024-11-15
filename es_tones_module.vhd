library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tones is
    port(
        input_clk       : in  std_logic; -- Must be 48 MHz
        sound_ch_en     : in std_logic;
        sound_ch_T      : in unsigned(25 downto 0);  
        --T = clk / (2 * f), where f is the frequency of the desired sound

        sound_out       : out std_logic
    );
end tones;

architecture synth of tones is

signal counter      : unsigned(25 downto 0) := 26d"0";
signal pitch      : std_logic := '0';

begin

    process (input_clk) begin
        if rising_edge (input_clk) then
            if counter = sound_ch_T then
                counter <= 26d"0";
                if sound_ch_T > 0 then
                    pitch <= not pitch;
                end if;
            else
                counter <= counter + 1;
            end if;
    	end if;
    end process;

    sound_out <= pitch and sound_ch_en;

end;
