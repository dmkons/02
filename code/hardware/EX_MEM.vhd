library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity EX_MEM is
    generic(DMEM_DATA_BUS : natural := DDATA_BUS; PC_SIZE : natural := MEM_ADDR_COUNT);
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        pc_in : in std_logic_vector(PC_SIZE-1 downto 0);
        alu_result_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        alu_zero_in : in std_logic;
        register_destination_in : in std_logic_vector(4 downto 0);
        rt_data_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        mem_control_signals_in : in mem_control_signals;
        wb_control_signals_in : in wb_control_signals;
        
        pc_out : out std_logic_vector(PC_SIZE-1 downto 0);
        alu_result_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        alu_zero_out : out std_logic;
        register_destination_out : out std_logic_vector(4 downto 0);
        rt_data_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        mem_control_signals_out : out mem_control_signals;
        wb_control_signals_out : out wb_control_signals
    );
end EX_MEM;

architecture behavioral of EX_MEM is
begin

    pc_register : entity work.flip_flop
    generic map(N => MEM_ADDR_COUNT)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => pc_in,
        data_out => pc_out
    );

    alu_result_register : entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => alu_result_in,
        data_out => alu_result_out
    );

    register_destination_register: entity work.flip_flop
    generic map(N => 5)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => register_destination_in,
        data_out => register_destination_out
    );

    rt_data_register : entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => rt_data_in,
        data_out => rt_data_out
    );

    mem_control_signals_register: entity work.flip_flop_mem_control_signals
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => mem_control_signals_in,
        data_out => mem_control_signals_out
    );

    wb_control_signals_register: entity work.flip_flop_wb_control_signals
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => wb_control_signals_in,
        data_out => wb_control_signals_out
    );

    alu_zero_register: entity work.flip_flop_std_logic
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => alu_zero_in,
        data_out => alu_zero_out
    );

end behavioral;
