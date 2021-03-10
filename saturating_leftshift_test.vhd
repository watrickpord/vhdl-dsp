-- saturating leftshift testbench
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity saturating_leftshift_test is
end saturating_leftshift_test;

architecture behavioral of saturating_leftshift_test is
    component saturating_leftshift is
        generic (
            bit_width : natural := 16
        );
        port (
            input  : in  signed (bit_width-1 downto 0);
            output : out signed (bit_width-1 downto 0)
        );
    end component;
    
    signal input  : signed (7 downto 0);
    signal output : signed (7 downto 0);
begin
    -- instantiate 8 bit test
    dut : saturating_leftshift generic map (bit_width => 8)
                                port map (input, output);
                                
    -- apply test signals
    test_signals : process is
    begin
        for i in -128 to 127 loop
            input <= to_signed(i, 8);
            wait for 10 ns;
        end loop;
    end process;
end behavioral;
