library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity mem_stage is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;

        pc_in : in std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        alu_result_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        alu_zero_in : in std_logic;
        rt_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        mem_control_signals_in : in mem_control_signals;
        wb_control_signals_in : in wb_control_signals;

        data_memory_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        wb_control_signals_out : out wb_control_signals;
        pc_source_out : out std_logic
    );
end mem_stage;

architecture behavioural of mem_stage is
begin

    data_memory: entity work.memory
	generic map(
        N => DDATA_BUS,
        M => MEM_ADDR_COUNT
    )port map(
		clk => clk,
		reset => reset,
		w_addr => alu_result_in,
		write_data => rt_data_in,
		memwrite => mem_control_signals_in.memory_write,
		addr => alu_result_in,

		read_data => data_memory_out
    );

    
    process (alu_zero_in, mem_control_signals_in.branch)
    begin
        pc_source_out <= alu_zero_in and mem_control_signals_in.branch;
    end process;

end behavioural;
