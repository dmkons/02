library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity mem_stage is
    port(
        alu_zero_in : in std_logic;
        branch_in : in std_logic;

        pc_source_out : out std_logic
    );
end mem_stage;

architecture behavioural of mem_stage is
begin
    
    process (alu_zero_in, branch_in)
    begin
        pc_source_out <= alu_zero_in and branch_in;
    end process;

end behavioural;
