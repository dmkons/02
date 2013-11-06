library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity MEM_WB is
    generic(DMEM_DATA_BUS : natural := DDATA_BUS; PC_SIZE : natural := MEM_ADDR_COUNT);
    port(
        data_memory_in : in numeric_std(PC_SIZE-1 downto 0);
        alu_result_in : in std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        register_destination_in : in std_logic_vector(4 downto 0);
        
        data_memory_out : out numeric_std(PC_SIZE-1 downto 0);
        alu_result_out : out std_logic_vector(DMEM_DATA_BUS-1 downto 0);
        register_destination_out : out std_logic_vector(4 downto 0);
    );
end MEM_WB;


architecture behavioral of MEM_WB is
begin
end Behavioral;
