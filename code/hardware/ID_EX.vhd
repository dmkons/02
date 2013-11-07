library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;


entity ID_EX is
    generic(
        DMEM_DATA_BUS : natural := DDATA_BUS;
        PC_SIZE : natural := MEM_ADDR_COUNT
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        pc_in : in std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        immediate_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        instruction_20_downto_16_in : in std_logic_vector(20 downto 16);
        instruction_15_downto_11_in : in std_logic_vector(15 downto 11);
        rs_data_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        rt_data_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        ex_control_signals_in : in ex_control_signals;
        mem_control_signals_in : in mem_control_signals;
        wb_control_signals_in : in wb_control_signals;
        
        pc_out : out std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        immediate_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        instruction_20_downto_16_out : out std_logic_vector(20 downto 16);
        instruction_15_downto_11_out : out std_logic_vector(15 downto 11);
        rs_data_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        rt_data_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0)
        ex_control_signals_out : out ex_control_signals;
        mem_control_signals_out : out mem_control_signals;
        wb_control_signals_out : out wb_control_signals;
    );
end ID_EX;

architecture behavioral of ID_EX is
begin

    pc_register: entity work.flip_flop
    generic map(N => MEM_ADDR_COUNT)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => pc_in,
        data_out => pc_out
    );

    immediate_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => immediate_in,
        data_out => immediate_out
    );

    instruction_20_downto_16_register: entity work.flip_flop
    generic map(N => 5)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => instruction_20_downto_16_in,
        data_out => instruction_20_downto_16_out
    );

    instruction_15_downto_11_register: entity work.flip_flop
    generic map(N => 5)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => instruction_15_downto_11_in,
        data_out => instruction_15_downto_11_out
    );

    rs_data_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => rs_data_in,
        data_out => rs_data_out
    );

    rt_data_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => rt_data_in,
        data_out => rt_data_out
    );

    ex_control_signals_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => ex_control_signals_in,
        data_out => ex_control_signals_out
    );

    mem_control_signals_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => mem_control_signals_in,
        data_out => mem_control_signals_out
    );

    wb_control_signals_register: entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => wb_control_signals_in,
        data_out => wb_control_signals_out
    );

end behavioral;
