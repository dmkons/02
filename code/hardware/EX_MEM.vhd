library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity EX_MEM is
    generic(DMEM_DATA_BUS : natural := DDATA_BUS; PC_SIZE : natural := MEM_ADDR_COUNT);
    port(
        pc_in : in numeric_std(PC_SIZE-1 downto 0);
        alu_result_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        instruction_20_downto_16_in : in std_logic_vector(20 downto 16);
        instruction_15_downto_11_in : in std_logic_vector(15 downto 11);
        rt_data_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        
        pc_out : out numeric_std(PC_SIZE-1 downto 0);
        alu_result_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        instruction_20_downto_16_in : out std_logic_vector(20 downto 16);
        instruction_15_downto_11_in : out std_logic_vector(15 downto 11);
        rt_data_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
    );
end EX_MEM;


architecture behavioral of EX_MEM is
begin
end behavioral;
