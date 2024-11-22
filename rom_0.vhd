library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_0 is
    port (
        clk : in std_logic;
        read_enable : in std_logic;
        addr : in unsigned(5 downto 0);
        data : out unsigned(25 downto 0)
    );
end rom_0;

architecture arch of rom_0 is
    type rom_type is array (0 to 35) of unsigned(25 downto 0);

    constant mem: rom_type:=
    (
        26d"36404",
        26d"40864",
        26d"36404",
        26d"45866",
        26d"36404",
        26d"45866",
        26d"40864",
        26d"36404",
        26d"0",
        26d"36404",
        26d"40864",
        26d"36404",
        26d"45866",
        26d"45866",
        26d"40864",
        26d"45866",
        26d"36404",
        26d"40864",
        26d"45866",
        26d"0",
        26d"27273",
        26d"45866",
        26d"40864",
        26d"30612",
        26d"45866",
        26d"40864",
        26d"34361",
        26d"45866",
        26d"40864",
        26d"30612",
        26d"45866",
        26d"40864",
        26d"45866",
        26d"24297",
        26d"27273",
        26d"30612"
    );

begin
    process (clk) begin
        if (rising_edge(clk) and read_enable = '1') then
            data <= mem(to_integer(addr));
        end if;
    end process;
end architecture arch;
