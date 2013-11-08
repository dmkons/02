library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;
use work.opcodes.all;

entity id_stage is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        instruction_in : in std_logic_vector(IDATA_BUS-1 downto 0);
        register_write_in : in std_logic;
        write_data_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        register_destination_in : in std_logic_vector(RADDR_BUS-1 downto 0);

        immediate_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        instruction_20_downto_16_out : out std_logic_vector(20 downto 16);
        instruction_15_downto_11_out : out std_logic_vector(15 downto 11);
        rs_data_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        rt_data_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        ex_control_signals_out : out  ex_control_signals;
        mem_control_signals_out : out mem_control_signals;
        wb_control_signals_out : out wb_control_signals
    );
end id_stage;


architecture behavioural of id_stage is
begin

    control_unit: entity work.control_unit
    port map(
        instruction_opcode => get_opcode(instruction_in),
        instruction_function => get_function(instruction_in),

        ex_control_signals => ex_control_signals_out,
        mem_control_signals => mem_control_signals_out,
        wb_control_signals => wb_control_signals_out
    );


    register_file: entity work.register_file
    port map(
        clk => clk,
        reset => reset,
        rw => register_write_in,
        rs_addr => get_rs(instruction_in),
        rt_addr => get_rt(instruction_in),
        rd_addr => register_destination_in,
        write_data => write_data_in,

        rs => rs_data_out,
        rt => rt_data_out
    );


    process (instruction_in)
    begin
        immediate_out <= std_logic_vector(resize(
                             signed(instruction_in(15 downto 0)),
                             immediate_out'length));
    end process;


    process (instruction_in)
    begin
        instruction_20_downto_16_out <= instruction_in(20 downto 16);
        instruction_15_downto_11_out <= instruction_in(15 downto 11);
    end process;

end behavioural;
