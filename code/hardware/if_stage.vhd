library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity if_stage is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;

        pc_source_in : in std_logic;
        alu_result_in : in std_logic_vector(DDATA_BUS-1 downto 0);

        pc_out : out std_logic_vector(MEM_ADDR_COUNT-1 downto 0)
    );
end if_stage;


architecture behavioural of if_stage is
    signal new_pc_in : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal new_pc_out : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal pc_incremented : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
begin


    pc: entity work.flip_flop
    generic map(
        N => MEM_ADDR_COUNT
    )port map(
        clk => clk,
        reset => reset,
        enable => processor_enable,
        data_in => new_pc_in,
        data_out => new_pc_out
    );

    process (pc_source_in, pc_incremented, alu_result_in)
    begin
        if pc_source_in = '1' then
            new_pc_in <= alu_result_in(MEM_ADDR_COUNT-1 downto 0);
        else 
            new_pc_in <= pc_incremented;
        end if;
    end process;


    process (new_pc_out)
    begin
        pc_incremented <= std_logic_vector(unsigned(new_pc_out) + "1");
        pc_out <= new_pc_out;
    end process;

end behavioural;
