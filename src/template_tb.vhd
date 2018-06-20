-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity template_tb is
    generic (
        constant clk_period  : time    := 10 ns;
        constant clk_divisor : integer := 10
        );
end entity;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture tb of template_tb is

    -- declare component
    component template is
        -- declare generics
        generic (
            constant freq_divisor : integer := 100
            );
        -- declare port assignments
        port (
            clk_i : in  std_logic;
            led_o : out std_logic
            );
    end component;

    -- declare signals
    signal clk_s : std_logic;
    signal led_s : std_logic;
    
begin

    -- instantiate device under test
    dut_0 : template
        generic map (
            freq_divisor => clk_divisor
            )
        port map (
            clk_i => clk_s,
            led_o => led_s
            );

    -- generate clock signal
    gen_clk : process
    begin
        clk_s <= '1';
        wait for clk_period/2;
        clk_s <= '0';
        wait for clk_period/2;
    end process;

    -- simple assert with report
    check_invert : process
    begin
        wait for (((clk_period*clk_divisor)/2)-clk_period);
        assert led_s = '0' report "output should be 0 by now." severity error;
        wait for (2*clk_period);
        assert led_s = '1' report "output should be 1 by now." severity error;
        wait;
    end process;
    
end tb;

-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------
