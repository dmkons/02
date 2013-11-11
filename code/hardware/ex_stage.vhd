library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity ex_stage is
    port(
        pc_in : in std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        immediate_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        instruction_in : in std_logic_vector(IDATA_BUS-1 downto 0);
        rs_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        rt_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        ex_control_signals_in : in ex_control_signals;
        register_destination_from_ex_mem :
            in std_logic_vector(RADDR_BUS-1 downto 0);
        register_destination_from_mem_wb :
            in std_logic_vector(RADDR_BUS-1 downto 0);
        register_write_from_ex_mem : in std_logic;
        register_write_from_mem_wb : in std_logic;
        alu_result_from_ex_mem : in std_logic_vector(DDATA_BUS-1 downto 0);
        write_data_from_wb_stage : in std_logic_vector(DDATA_BUS-1 downto 0);

        pc_out : out std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        alu_result_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        rt_data_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        alu_zero_out : out std_logic;
        register_destination_out : out std_logic_vector(4 downto 0)
    );
end ex_stage;


architecture behavioural of ex_stage is
    signal alu_x_in : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_y_in : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_y_forwarding_mux_out : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_result_signed_out : signed(DDATA_BUS-1 downto 0);
    signal forward_rs_out : std_logic_vector(1 downto 0);
    signal forward_rt_out : std_logic_vector(1 downto 0);
begin

    alu: entity work.alu
    port map(
        x_in => signed(alu_x_in),
        y_in => signed(alu_y_in),
        function_in => ex_control_signals_in.alu_function,

        result_out => alu_result_signed_out,
        zero_out => alu_zero_out
    );

    forwarding_unit: entity work.forwarding_unit
    port map(
        rs_address_from_id_ex => get_rs(instruction_in),
        rt_address_from_id_ex => get_rt(instruction_in),
        register_destination_from_ex_mem => register_destination_from_ex_mem,
        register_destination_from_mem_wb => register_destination_from_mem_wb, 
        register_write_from_ex_mem => register_write_from_ex_mem,
        register_write_from_mem_wb => register_write_from_mem_wb,

        forward_rs_out => forward_rs_out,
        forward_rt_out => forward_rt_out
    );

    alu_x_forwarding_mux : entity work.mux3
    generic map(N => DDATA_BUS)
    port map(
        a_in => rs_data_in,
        b_in => write_data_from_wb_stage,
        c_in => alu_result_from_ex_mem,
        select_in => forward_rs_out,
        data_out => alu_x_in
    );

    alu_y_forwarding_mux : entity work.mux3
    generic map(N => DDATA_BUS)
    port map(
        a_in => rt_data_in,
        b_in => write_data_from_wb_stage,
        c_in => alu_result_from_ex_mem,
        select_in => forward_rt_out,
        data_out => alu_y_forwarding_mux_out
    );

    alu_y_immediate_mux : entity work.mux2
    generic map(N => DDATA_BUS)
    port map(
        a_in => alu_y_forwarding_mux_out,
        b_in => immediate_in,
        select_in => ex_control_signals_in.alu_source,
        data_out => alu_y_in
    );

    register_destination_mux : entity work.mux2
    generic map(N => RADDR_BUS)
    port map(
        a_in => get_rt(instruction_in),
        b_in => get_rd(instruction_in),
        select_in => ex_control_signals_in.register_destination,
        data_out => register_destination_out
    );


    process (alu_result_signed_out)
    begin
        alu_result_out <= std_logic_vector(alu_result_signed_out);
    end process;
    
    process (alu_y_forwarding_mux_out)
    begin
        rt_data_out <= alu_y_forwarding_mux_out;
    end process;


    process (pc_in, immediate_in)
        variable incremented_pc_out : std_logic_vector(DDATA_BUS-1 downto 0);
    begin
        incremented_pc_out := std_logic_vector(unsigned(immediate_in) + unsigned(pc_in));
        pc_out <= incremented_pc_out(MEM_ADDR_COUNT-1 downto 0);
    end process;

end behavioural;
