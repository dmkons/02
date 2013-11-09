library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
    generic(N : integer);
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data_in : in std_logic_vector(N-1 downto 0);
        data_out : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture behavioral of flip_flop is
begin

    flip_flop : process (clk, reset)
    begin
        if reset = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;

end behavioral;

-- VHDL support for type generics sucks, so here is a crappy workaround:
library ieee;
use ieee.std_logic_1164.all;

entity flip_flop_std_logic is
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data_in : in std_logic;
        data_out : out std_logic
    );
end entity;
architecture behavioral of flip_flop_std_logic is
begin

    flip_flop : process (clk, reset)
    begin
        if reset = '1' then
            data_out <= '0';
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity flip_flop_ex_control_signals is
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data_in : in ex_control_signals;
        data_out : out ex_control_signals
    );
end entity;
architecture behavioral of flip_flop_ex_control_signals is
begin

    flip_flop : process (clk, reset)
    begin
        if reset = '1' then
            data_out <= ('0', (others => '0'), '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity flip_flop_mem_control_signals is
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data_in : in mem_control_signals;
        data_out : out mem_control_signals
    );
end entity;
architecture behavioral of flip_flop_mem_control_signals is
begin

    flip_flop : process (clk, reset)
    begin
        if reset = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;
end behavioral;

library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity flip_flop_wb_control_signals is
    port(
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        data_in : in wb_control_signals;
        data_out : out wb_control_signals
    );
end entity;
architecture behavioral of flip_flop_wb_control_signals is
begin

    flip_flop : process (clk, reset)
    begin
        if reset = '1' then
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;
end behavioral;
