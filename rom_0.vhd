library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_0 is
    port (
        input_clk : in std_logic;
        addr : in unsigned(5 downto 0);
        data : out unsigned(25 downto 0)
    );
end rom_0;

architecture behavior of rom_0 is
begin

    process (input_clk) begin
        if rising_edge(input_clk) then
            case addr is
                when "000000" => data <= 26d"36404";
                when "000001" => data <= 26d"40864";
                when "000010" => data <= 26d"36404";
                when "000011" => data <= 26d"45866";
                when "000100" => data <= 26d"36404";
                when "000101" => data <= 26d"45866";
                when "000110" => data <= 26d"40864";
                when "000111" => data <= 26d"36404";
                when "001000" => data <= 26d"0";
                when "001001" => data <= 26d"36404";
                when "001010" => data <= 26d"40864";
                when "001011" => data <= 26d"36404";
                when "001100" => data <= 26d"45866";
                when "001101" => data <= 26d"45866";
                when "001110" => data <= 26d"40864";
                when "001111" => data <= 26d"45866";
                when "010000" => data <= 26d"36404";
                when "010001" => data <= 26d"40864";
                when "010010" => data <= 26d"45866";
                when "010011" => data <= 26d"0";
                when "010100" => data <= 26d"27273";
                when "010101" => data <= 26d"45866";
                when "010110" => data <= 26d"40864";
                when "010111" => data <= 26d"30612";
                when "011000" => data <= 26d"45866";
                when "011001" => data <= 26d"40864";
                when "011010" => data <= 26d"34361";
                when "011011" => data <= 26d"45866";
                when "011100" => data <= 26d"40864";
                when "011101" => data <= 26d"30612";
                when "011110" => data <= 26d"45866";
                when "011111" => data <= 26d"40864";
                when "100000" => data <= 26d"45866";
                when "100001" => data <= 26d"24297";
                when "100010" => data <= 26d"27273";
                when "100011" => data <= 26d"30612";
                when others => data <= 26d"0";
            end case;
        end if;
    end process;
end architecture behavior;
