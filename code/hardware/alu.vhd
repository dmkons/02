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
		
		result_out : out signed(DDATA_BUS-1 downto 0);
		zero_out : out std_logic
    );
end alu;

architecture behavioural of alu is
begin

case func is
when FUNCTION_ADD =>
r <= x + y;

when FUNCTION_AND =>
r <= x and y

when FUNCTION_OR =>
r <= x or y;

when FUNCTION_SLT =>
if x < y then
r <= "00000000000000000000000000000001";
else
r <= "00000000000000000000000000000000";
end if;


when FUNCTION_SUB =>
r_readable := x - y;
r <= r_readable;
if (r_readable="00000000000000000000000000000000") then
flags.zero <= '1';
else
flags.zero <= '0';
end if;

when FUNCTION_PASSTHROUGH =>
r <= x;

when others =>
null;
end case;

end behavioural;
