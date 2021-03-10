-- 2's complement saturating leftshift
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity saturating_leftshift is
    generic (
        bit_width : natural := 16
    );
    port (
        input  : in  signed (bit_width-1 downto 0);
        output : out signed (bit_width-1 downto 0)
    );
end saturating_leftshift;

architecture behavioral of saturating_leftshift is
begin
    process (input) is
    begin
        -- look at two leftmost bits, if 00 or 11 then output won't
        -- saturate, if 01 or 10 then then output will saturate
        if input (bit_width-1 downto bit_width-2) = "00" or input (bit_width-1 downto bit_width-2) = "11" then
            -- non saturating case: keep sign bit and leftshift remaining bits
            output <= input (input'high) & input (input'high-2 downto 0) & '0';
        elsif input (bit_width-1 downto bit_width-2) = "01" or input (bit_width-1 downto bit_width-2) = "10" then
            -- otherwise saturate
            if input (bit_width-1 downto bit_width-2) = "01" then
                -- positive saturation
                output <= (output'high => '0', others => '1');
            else
                -- negative saturation
                output <= (output'high => '1', others => '0');
            end if;
        end if;
    end process;

end behavioral;
