library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity alu is
    port(
            x_in : in signed(DDATA_BUS-1 downto 0);
            y_in : in signed(DDATA_BUS-1 downto 0);
            function_in : in std_logic_vector(FUNCTION_SIZE-1 downto 0);

            result_out  : out signed(DDATA_BUS-1 downto 0);
            zero_out : out std_logic
        );
end alu;

architecture behavioural of alu is
begin

    process(function_in, x_in, y_in)
        variable result_readable : signed(DDATA_BUS-1 downto 0);
    begin

        -- set defaults
        result_out <= (others => '0');
        zero_out <= '0';

        case function_in is
            when FUNCTION_ADD =>
                result_out <= x_in + y_in;

            when FUNCTION_AND =>
                result_out <= x_in and y_in;

            when FUNCTION_OR =>
                result_out <= x_in or y_in;

            when FUNCTION_SLT =>
                if x_in < y_in then
                    result_out <= "00000000000000000000000000000001";
                else
                    result_out <= "00000000000000000000000000000000";
                end if;


            when FUNCTION_SUB =>
                result_readable := x_in - y_in;
                result_out <= result_readable;
                if (result_readable="00000000000000000000000000000000") then
                    zero_out <= '1';
                else
                    zero_out <= '0';
                end if;

            when FUNCTION_PASSTHROUGH =>
                result_out <= x_in;

            when others =>
                null;
        end case;
    end process;

end behavioural;
