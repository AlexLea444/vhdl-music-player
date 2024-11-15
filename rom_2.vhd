library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_2 is
    port (
        addr : in unsigned(5 downto 0);
        data : out unsigned(25 downto 0)
    );
end rom_2;

architecture behavior of rom_2 is
begin

    process (addr)
    begin
        case addr is
            when "000000" => data <= 26d"36404";
            when "000001" => data <= 26d"36404";
            when "000010" => data <= 26d"36404";
            when "000011" => data <= 26d"36404";
            when "000100" => data <= 26d"36404";
            when "000101" => data <= 26d"36404";
            when "000110" => data <= 26d"36404";
            when "000111" => data <= 26d"36404";
            when "001000" => data <= 26d"27273";
            when "001001" => data <= 26d"27273";
            when "001010" => data <= 26d"27273";
            when "001011" => data <= 26d"27273";
            when "001100" => data <= 26d"27273";
            when "001101" => data <= 26d"0";
            when "001110" => data <= 26d"0";
            when "001111" => data <= 26d"0";
            when "010000" => data <= 26d"0";
            when "010001" => data <= 26d"0";
            when "010010" => data <= 26d"0";
            when "010011" => data <= 26d"0";
            when "010100" => data <= 26d"0";
            when "010101" => data <= 26d"0";
            when "010110" => data <= 26d"0";
            when "010111" => data <= 26d"0";
            when "011000" => data <= 26d"0";
            when "011001" => data <= 26d"0";
            when "011010" => data <= 26d"0";
            when "011011" => data <= 26d"0";
            when "011100" => data <= 26d"0";
            when "011101" => data <= 26d"0";
            when "011110" => data <= 26d"0";
            when "011111" => data <= 26d"0";
            when "100000" => data <= 26d"0";
            when "100001" => data <= 26d"0";
            when "100010" => data <= 26d"0";
            when "100011" => data <= 26d"0";
            when others => data <= 26d"0";
        end case;
    end process;
end architecture behavior;
