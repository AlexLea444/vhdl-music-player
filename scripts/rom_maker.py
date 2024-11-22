import math


def main():
    clock = 24000000
    lut = {
            "C": 261.63,
            "C#": 277.18,
            "Db": 277.18,
            "D": 293.66,
            "D#": 293.66,
            "Eb": 293.66,
            "E": 329.63,
            "F": 349.23,
            "F#": 369.99,
            "Gb": 369.99,
            "G": 392,
            "G#": 415.30,
            "Ab": 415.30,
            "A": 440,
            "A#": 466.16,
            "Bb": 466.16,
            "B": 493.88
          }
    lines = []
    with open('input.txt', 'r') as file:
        for line in file:
            lines.append(line.strip("\n").split(" "))

    # Count number of notes for each ROM
    counts = []
    for i in range(max([len(notes) for notes in lines])):
        count = 0
        for line in lines:
            if i < len(line):
                count += 1
        counts.append(count)

    # Determine required address lengths
    addr_len = math.ceil(math.log2(len(lines)))

    # Print ROMs
    for i in range(max([len(notes) for notes in lines])):
        print("library IEEE;")
        print("use IEEE.std_logic_1164.all;")
        print("use IEEE.numeric_std.all;")
        print()
        print(f"entity rom_{i} is")
        print("    port (")
        print("        clk : in std_logic;")
        print("        read_enable : in std_logic;")
        print(f"        addr : in unsigned({addr_len - 1} downto 0);")
        print("        data : out unsigned(25 downto 0)")
        print("    );")
        print(f"end rom_{i};")
        print()
        print(f"architecture arch of rom_{i} is")
        print(f"    type rom_type is array (0 to {len(lines) - 1}) of unsigned(25 downto 0);")
        print()
        print("    constant mem: rom_type:=")
        print("    (")
        for num, line in enumerate(lines):
            print("        26d\"", end="")
            if i >= len(line):
                print("0", end="\"")
            elif (f := lut.get(line[i])) is not None:
                print(round(clock / (2 * f)), end="\"")
            else:
                print("0", end="\"")
            if num != len(lines) - 1:
                print(",")
        print()
        print("    );")
        print()

        print("begin")
        print("    process (clk) begin")
        print("        if (rising_edge(clk) and read_enable = '1') then")
        print("            data <= mem(to_integer(addr));")
        print("        end if;")
        print("    end process;")
        print("end architecture arch;")

    print("library IEEE;")
    print("use IEEE.std_logic_1164.all;")
    print("use IEEE.numeric_std.all;")
    print()
    print("entity top is")
    print("    port(")
    print("        sound_out : out std_logic")
    print("    );")
    print("end entity;")
    print()
    print("architecture synth of top is")
    print()
    print(f"[add {clock}Hz clock module here]")
    print()
    print("    -- tone module")
    print("    component tones is")
    print("        port(")
    print("            clk : in std_logic;")
    print("            sound_ch_en : in std_logic;")
    print("            sound_ch_T : in unsigned(25 downto 0);")
    print("            sound_out : out std_logic")
    print("        );")
    print("    end component;")
    print()

    for i in range(max([len(notes) for notes in lines])):
        print(f"    component rom_{i} is")
        print("        port (")
        print("            clk : in std_logic;")
        print("            read_enable : in std_logic;")
        print(f"            addr : in unsigned({addr_len - 1} downto 0);")
        print("            data : out unsigned(25 downto 0)")
        print("        );")
        print("    end component;")
        print()

    print("    -- Timing Signals")
    print("    signal clk : std_logic;")
    print("    signal counter : unsigned(23 downto 0) := (others => '0');")
    print(f"    signal addr_counter : unsigned({addr_len - 1} downto 0);")
    print()

    print("    -- Interconnect Signals")
    for i in range(max([len(notes) for notes in lines])):
        print(f"    signal sound_sig_{i} : std_logic;")
        print(f"    signal rom_out_{i} : unsigned(25 downto 0);")

    print()
    print("begin")
    print("[instantiate clock here]")
    print()

    for i in range(max([len(notes) for notes in lines])):
        print(f"    tones_{i} : tones")
        print("        port map (")
        print(f"            clk => clk, sound_ch_en => '1', sound_ch_T => rom_out_{i}, sound_out => sound_sig_{i}")
        print("        );")
        print()
        print(f"    song_rom_{i} : rom_{i}")
        print("        port map (")
        print(f"            clk => clk, read_enable => '1', addr => addr_counter, data => rom_out_{i}")
        print("        );")
        print()

    print("    process (clk) begin")
    print("        if rising_edge(clk) then")
    print("            counter <= counter + 1;")
    print("        end if;")
    print("    end process;")
    print()
    print("    process (counter(23)) begin")
    print("        if rising_edge(counter(23)) then")
    print("            addr_counter <= addr_counter + 1;")
    print("        end if;")
    print("    end process;")
    print()

    print("    sound_out <= sound_sig_0", end="")
    for i in range(1, max([len(notes) for notes in lines])):
        print(f" or sound_sig_{i}", end="")
    print(";")
    print()
    print("end architecture synth;")


if __name__ == "__main__":
    main()
