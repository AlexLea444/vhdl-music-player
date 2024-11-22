library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top is
    port(
        sound_out : out std_logic
    );
end entity;

architecture synth of top is
    -- Clock module
    component SB_HFOSC is
        generic (
            CLKHF_DIV : String := "0b01"
        );
        port (
            CLKHFPU : in std_logic := 'X';
            CLKHFEN : in std_logic := 'X';
            CLKHF : out std_logic := 'X'
        );
    end component;

    -- tone module
    component tones is
        port(
            clk : in std_logic;
            sound_ch_en : in std_logic;
            sound_ch_T : in unsigned(25 downto 0);
            sound_out : out std_logic
        );
    end component;

    component rom_0 is
        port (
            clk : in std_logic;
            read_enable : in std_logic;
            addr : in unsigned(5 downto 0);
            data : out unsigned(25 downto 0)
        );
    end component;

    component rom_1 is
        port (
            clk : in std_logic;
            read_enable : in std_logic;
            addr : in unsigned(5 downto 0);
            data : out unsigned(25 downto 0)
        );
    end component;

    component rom_2 is
        port (
            clk : in std_logic;
            read_enable : in std_logic;
            addr : in unsigned(5 downto 0);
            data : out unsigned(25 downto 0)
        );
    end component;

    component rom_3 is
        port (
            clk : in std_logic;
            read_enable : in std_logic;
            addr : in unsigned(5 downto 0);
            data : out unsigned(25 downto 0)
        );
    end component;

    -- Timing Signals
    signal clk : std_logic;
    signal counter : unsigned(23 downto 0) := (others => '0');
    signal addr_counter : unsigned(5 downto 0);

    -- Interconnect Signals
    signal sound_sig_0 : std_logic;
    signal rom_out_0 : unsigned(25 downto 0);
    signal sound_sig_1 : std_logic;
    signal rom_out_1 : unsigned(25 downto 0);
    signal sound_sig_2 : std_logic;
    signal rom_out_2 : unsigned(25 downto 0);
    signal sound_sig_3 : std_logic;
    signal rom_out_3 : unsigned(25 downto 0);

begin
    osc : SB_HFOSC generic map (CLKHF_DIV => "0b01")
                    port map (CLKHFPU => '1',
                              CLKHFEN => '1',
                              CLKHF => clk);

    tones_0 : tones
        port map (
            clk => clk, sound_ch_en => '1', sound_ch_T => rom_out_0, sound_out => sound_sig_0
        );

    song_rom_0 : rom_0
        port map (
            clk => clk, read_enable => '1', addr => addr_counter, data => rom_out_0
        );

    tones_1 : tones
        port map (
            clk => clk, sound_ch_en => '1', sound_ch_T => rom_out_1, sound_out => sound_sig_1
        );

    song_rom_1 : rom_1
        port map (
            clk => clk, read_enable => '1', addr => addr_counter, data => rom_out_1
        );
--
--    tones_2 : tones
--        port map (
--            clk => clk, sound_ch_en => '1', sound_ch_T => rom_out_2, sound_out => sound_sig_2
--        );
--
--    song_rom_2 : rom_2
--        port map (
--            clk => clk, read_enable => '1', addr => addr_counter, data => rom_out_2
--        );
--
--    tones_3 : tones
--        port map (
--            clk => clk, sound_ch_en => '1', sound_ch_T => rom_out_3, sound_out => sound_sig_3
--        );
--
--    song_rom_3 : rom_3
--        port map (
--            clk => clk, read_enable => '1', addr => addr_counter, data => rom_out_3
--        );

    process (clk) begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    process (counter(23)) begin
        if rising_edge(counter(23)) then
            addr_counter <= addr_counter + 1;
        end if;
    end process;

    sound_out <= sound_sig_0 or sound_sig_1;-- or sound_sig_2 or sound_sig_3;

end architecture synth;
