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
end behavioural;
