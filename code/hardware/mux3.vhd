library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity mux3 is
    generic(N : natural);
    port(
        a_in : in std_logic_vector(N-1 downto 0);
        b_in : in std_logic_vector(N-1 downto 0);
        c_in : in std_logic_vector(N-1 downto 0);
        select_in : in std_logic_vector(1 downto 0);

        data_out : out std_logic_vector(N-1 downto 0)
    );
end mux3;


architecture behavioural of mux3 is
begin

    process(a_in, b_in, c_in, select_in)
    begin
        case select_in is
            when "00" =>
                data_out <= a_in;
            when "01" =>
                data_out <= b_in;
            when "10" =>
                data_out <= c_in;
            when others =>
                data_out <= (others => 'X');
        end case;
    end process;

end architecture;
