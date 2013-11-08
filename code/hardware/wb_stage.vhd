library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity wb_stage is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;

        data_memory_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        alu_result_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        memory_to_register_in : in std_logic;

        write_data_out : out std_logic_vector(DDATA_BUS-1 downto 0)
    );
end wb_stage;

architecture behavioural of wb_stage is
begin

    process (data_memory_in, alu_result_in, memory_to_register_in)
    begin
        if memory_to_register_in = '1' then
            write_data_out <= data_memory_in;    
        else
            write_data_out <= alu_result_in;
        end if;
    end process;

end behavioural;
