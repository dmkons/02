library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity MEM_WB is
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;

        data_memory_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        alu_result_in : in std_logic_vector(DDATA_BUS-1 downto 0);
        register_destination_in : in std_logic_vector(4 downto 0);
        wb_control_signals_in : in wb_control_signals;
        
        data_memory_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        alu_result_out : out std_logic_vector(DDATA_BUS-1 downto 0);
        register_destination_out : out std_logic_vector(4 downto 0);
        wb_control_signals_out : out wb_control_signals
    );
end MEM_WB;


architecture behavioral of MEM_WB is
begin

    data_memory_register : entity work.flip_flop
    generic map(N => DDATA_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => data_memory_in,
        data_out => data_memory_out
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

    register_destination_register : entity work.flip_flop
    generic map(N => RADDR_BUS)
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => register_destination_in,
        data_out => register_destination_out
    );

    wb_control_signals_register: entity work.flip_flop_wb_control_signals
    port map(
        clk => clk,
        reset => reset,
        enable => halt,
        data_in => wb_control_signals_in,
        data_out => wb_control_signals_out
    );

end behavioral;
