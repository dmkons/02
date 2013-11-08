library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity ex_stage is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        pc_in : in std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        immediate_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        instruction_20_downto_16_in : in std_logic_vector(20 downto 16);
        instruction_15_downto_11_in : in std_logic_vector(15 downto 11);
        rs_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        rt_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        ex_control_signals_in : in ex_control_signals;

        pc_out : out std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        alu_result_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        alu_zero_out : out std_logic;
        register_destination_out : out std_logic_vector(4 downto 0);
        rt_data_out : out std_logic_vector(DDATA_BUS-1 downto 0)
    );
end ex_stage;


architecture behavioural of ex_stage is
    signal alu_y_in : std_logic_vector(DDATA_BUS-1 downto 0);
    signal alu_result_signed_out : signed(DDATA_BUS-1 downto 0);
begin

    alu: entity work.alu
    port map(
        x_in => signed(rs_data_in),
        y_in => signed(alu_y_in),
        function_in => ex_control_signals_in.alu_function,

        result_out => alu_result_signed_out,
        zero_out => alu_zero_out
    );

    process (alu_result_signed_out)
    begin
        alu_result_out <= std_logic_vector(alu_result_signed_out);
    end process;


    process (pc_in, immediate_in)
        variable incremented_pc_out : std_logic_vector(DDATA_BUS-1 downto 0);
    begin
        incremented_pc_out := std_logic_vector(unsigned(immediate_in) + unsigned(pc_in));
        pc_out <= incremented_pc_out(MEM_ADDR_COUNT-1 downto 0);
    end process;


    process (ex_control_signals_in.alu_source, rt_data_in, immediate_in)
    begin
        if ex_control_signals_in.alu_source = '1' then 
            alu_y_in <= immediate_in;
        else
            alu_y_in <= rt_data_in;
        end if;
    end process;


    process (ex_control_signals_in.register_destination,
        instruction_20_downto_16_in, instruction_15_downto_11_in)
    begin
        if ex_control_signals_in.register_destination = '1' then
            register_destination_out <= instruction_15_downto_11_in;
        else
            register_destination_out <= instruction_20_downto_16_in;
        end if;
    end process;

end behavioural;
