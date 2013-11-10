library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity mux2 is
    generic(N : natural);
    port(
        a_in : in std_logic_vector(N-1 downto 0);
        b_in : in std_logic_vector(N-1 downto 0);
        select_in : in std_logic;

        data_out : out std_logic_vector(N-1 downto 0)
    );
end mux2;


architecture behavioural of mux2 is
begin

    process(a_in, b_in, select_in)
    begin
        if select_in = '1' then
            data_out <= b_in;
        else
            data_out <= a_in;
        end if;
    end process;

end architecture;
