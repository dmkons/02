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
            if enable = '0' then
                data_out <= data_in;
            end if;
        end if;
    end process flip_flop;

end behavioral;
