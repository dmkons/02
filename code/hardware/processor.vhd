library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity processor is
    generic (MEM_ADDR_BUS : natural := DADDR_BUS; MEM_DATA_BUS : natural := DDATA_BUS);
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        imem_data_in : in std_logic_vector (MEM_DATA_BUS-1 downto 0);
        dmem_data_in : in std_logic_vector (MEM_DATA_BUS-1 downto 0);

        imem_address : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        dmem_address : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        dmem_address_wr : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        dmem_data_out : out std_logic_vector (MEM_DATA_BUS-1 downto 0);
        dmem_write_enable : out std_logic
    );

end processor;

architecture behavioral of processor is

    -- convention: <name without in/out>_from_<who outputs it>

    -- signals from if_stage
    signal pc_from_if_stage : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal instruction_from_if_stage : std_logic_vector(IDATA_BUS-1 downto 0);
    signal instruction_address_from_if_stage : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);

    -- signals from if_id
    signal pc_from_if_id : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal instruction_from_if_id : std_logic_vector(IDATA_BUS-1 downto 0);


    -- signals from id_stage
    signal immediate_from_id_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    signal rs_data_from_id_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    signal rt_data_from_id_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    signal ex_control_signals_from_id_stage : ex_control_signals;
    signal mem_control_signals_from_id_stage : mem_control_signals;
    signal wb_control_signals_from_id_stage : wb_control_signals;

    
    -- signals from id_ex
    signal pc_from_id_ex : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal immediate_from_id_ex : std_logic_vector(DDATA_BUS-1 downto 0);
    signal instruction_from_id_ex : std_logic_vector(IDATA_BUS-1 downto 0);
    signal rs_data_from_id_ex : std_logic_vector(DDATA_BUS-1 downto 0);
    signal rt_data_from_id_ex : std_logic_vector(DDATA_BUS-1 downto 0);
    signal ex_control_signals_from_id_ex : ex_control_signals;
    signal mem_control_signals_from_id_ex : mem_control_signals;
    signal wb_control_signals_from_id_ex : wb_control_signals;


    -- signals from ex_stage
    signal pc_from_ex_stage : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal alu_result_from_ex_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_zero_from_ex_stage : std_logic;
    signal instruction_20_downto_16_from_ex_stage : std_logic_vector(20 downto 16);
    signal register_destination_from_ex_stage : std_logic_vector(4 downto 0);


    -- signals from ex_mem
    signal pc_from_ex_mem : std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
    signal alu_result_from_ex_mem : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_zero_from_ex_mem : std_logic;
    signal register_destination_from_ex_mem : std_logic_vector(4 downto 0);
    signal mem_control_signals_from_ex_mem : mem_control_signals;
    signal wb_control_signals_from_ex_mem : wb_control_signals;


    -- signals from mem_stage
    signal data_memory_from_mem_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    signal pc_source_from_mem_stage : std_logic;


    -- signals from mem_wb
    signal data_memory_from_mem_wb : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_result_from_mem_wb : std_logic_vector(DDATA_BUS-1 downto 0);
    signal register_destination_from_mem_wb : std_logic_vector(4 downto 0);
    signal wb_control_signals_from_mem_wb : wb_control_signals;


    -- signals from wb_stage
    signal write_data_from_wb_stage : std_logic_vector(DDATA_BUS-1 downto 0);
    

begin

    if_stage: entity work.if_stage
    port map(
        clk => clk,
        reset => reset,
        processor_enable => processor_enable,
        pc_source_in => pc_source_from_mem_stage,
        pc_in => pc_from_ex_mem,

        pc_out => pc_from_if_stage,
        instruction_address_out => instruction_address_from_if_stage
    );
    
    process (instruction_address_from_if_stage)
    begin
        imem_address <= instruction_address_from_if_stage;
    end process;

    if_id: entity work.if_id
    port map(
        clk => clk,
        reset => reset,
        halt => processor_enable,
        pc_in => pc_from_if_stage,
        instruction_in => imem_data_in,

        pc_out => pc_from_if_id,
        instruction_out => instruction_from_if_id
    );

    id_stage: entity work.id_stage
    port map(
        clk => clk,
        reset => reset,
        processor_enable => processor_enable,
        instruction_in => instruction_from_if_id,
        register_write_in => wb_control_signals_from_mem_wb.register_write,
        write_data_in => write_data_from_wb_stage,
        register_destination_in => register_destination_from_mem_wb,

        immediate_out => immediate_from_id_stage,
        rs_data_out => rs_data_from_id_stage,
        rt_data_out => rt_data_from_id_stage,
        ex_control_signals_out => ex_control_signals_from_id_stage,
        mem_control_signals_out => mem_control_signals_from_id_stage,
        wb_control_signals_out => wb_control_signals_from_id_stage
    );

    id_ex: entity work.id_ex
    port map(
        clk => clk,
        reset => reset,
        halt => processor_enable,
        pc_in => pc_from_if_id,
        immediate_in => immediate_from_id_stage,
        instruction_in => instruction_from_if_id,
        rs_data_in => rs_data_from_id_stage,
        rt_data_in => rt_data_from_id_stage,
        ex_control_signals_in => ex_control_signals_from_id_stage,
        mem_control_signals_in => mem_control_signals_from_id_stage,
        wb_control_signals_in => wb_control_signals_from_id_stage,
        
        pc_out => pc_from_id_ex,
        immediate_out => immediate_from_id_ex,
        instruction_out => instruction_from_id_ex,
        rs_data_out => rs_data_from_id_ex,
        rt_data_out => rt_data_from_id_ex,
        ex_control_signals_out => ex_control_signals_from_id_ex,
        mem_control_signals_out => mem_control_signals_from_id_ex,
        wb_control_signals_out => wb_control_signals_from_id_ex
    );

    ex_stage: entity work.ex_stage
    port map(
        pc_in => pc_from_id_ex,
        immediate_in => immediate_from_id_ex,
        instruction_in => instruction_from_id_ex,
        rs_data_in => rs_data_from_id_ex,
        rt_data_in => rt_data_from_id_ex,
        ex_control_signals_in => ex_control_signals_from_id_ex,
        register_destination_from_ex_mem => register_destination_from_ex_mem,
        register_destination_from_mem_wb => register_destination_from_mem_wb,
        register_write_from_ex_mem => wb_control_signals_from_ex_mem.register_write,
        register_write_from_mem_wb => wb_control_signals_from_mem_wb.register_write,
        alu_result_from_ex_mem => alu_result_from_ex_mem,
        write_data_from_wb_stage => write_data_from_wb_stage,

        pc_out => pc_from_ex_stage,
        alu_result_out => alu_result_from_ex_stage,
        alu_zero_out => alu_zero_from_ex_stage,
        register_destination_out => register_destination_from_ex_stage
    );

    ex_mem: entity work.ex_mem
    port map(
        clk => clk,
        reset => reset,
        halt => processor_enable,
        pc_in => pc_from_ex_stage,
        alu_result_in => alu_result_from_ex_stage,
        alu_zero_in => alu_zero_from_ex_stage,
        register_destination_in => register_destination_from_ex_stage,
        rt_data_in => rt_data_from_id_ex,
        mem_control_signals_in => mem_control_signals_from_id_ex,
        wb_control_signals_in => wb_control_signals_from_id_ex,
        
        pc_out => pc_from_ex_mem,
        alu_result_out => alu_result_from_ex_mem,
        alu_zero_out => alu_zero_from_ex_mem,
        register_destination_out => register_destination_from_ex_mem,
        rt_data_out => dmem_data_out,
        mem_control_signals_out => mem_control_signals_from_ex_mem,
        wb_control_signals_out => wb_control_signals_from_ex_mem
    );
    
    process (mem_control_signals_from_ex_mem)
    begin
        if mem_control_signals_from_ex_mem.memory_write = '1' then
            dmem_write_enable <= '1';
        else
            dmem_write_enable <= '0';
        end if;
    end process;

    mem_stage: entity work.mem_stage
    port map(
        alu_zero_in => alu_zero_from_ex_mem,
        branch_in => mem_control_signals_from_ex_mem.branch,

        pc_source_out => pc_source_from_mem_stage
    );
    
    process (alu_result_from_ex_mem)
    begin
        dmem_address <= alu_result_from_ex_mem(MEM_ADDR_COUNT-1 downto 0);
    end process;
    

    mem_wb: entity work.mem_wb
    port map(
        clk => clk,
        reset => reset,
        halt => processor_enable,
        data_memory_in => dmem_data_in,
        alu_result_in => alu_result_from_ex_mem,
        register_destination_in => register_destination_from_ex_mem,
        wb_control_signals_in => wb_control_signals_from_ex_mem,
        
        data_memory_out => data_memory_from_mem_wb,
        alu_result_out => alu_result_from_mem_wb,
        register_destination_out => register_destination_from_mem_wb,
        wb_control_signals_out => wb_control_signals_from_mem_wb
    );

    wb_stage: entity work.wb_stage
    port map(
        data_memory_in => data_memory_from_mem_wb,
        alu_result_in => alu_result_from_mem_wb,
        memory_to_register_in => wb_control_signals_from_mem_wb.memory_to_register,

        write_data_out => write_data_from_wb_stage
    );

end behavioral;
