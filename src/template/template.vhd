-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity template is
    -- declare generics
    generic (
        constant freq_divisor : integer := 100
        );
    -- declare port assignments
    port (
        clk_i : in  std_logic;
        led_o : out std_logic
        );
end entity;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of template is

    -- declare needed signals
    signal led_s : std_logic := '0';
    
begin

    -- count positive clock edges until count is reached
    -- and invert the led_s signal
    process (clk_i)
        variable counter : integer range 0 to freq_divisor/2-1;
    begin
        if (rising_edge(clk_i)) then
            if (counter = freq_divisor/2-1) then
                led_s   <= not led_s;
                counter := 0;
            else
                counter := counter + 1;
            end if;
        end if;
    end process;

    -- assign the signal to the actual output
    led_o <= led_s;

end rtl;

-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------
