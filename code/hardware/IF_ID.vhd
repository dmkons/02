library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity IF_ID is
    generic(IMEM_DATA_BUS : natural := IDATA_BUS; PC_SIZE : natural := MEM_ADDR_COUNT);
    port(
        pc_in : in numeric_std(PC_SIZE-1 downto 0);
        instruction : in std_logic_vector(IMEM_DATA_BUS-1 downto 0);
        
        pc_out : out numberic:_std(PC_SIZE-1 downto 0);
        instruction : out std_logic_vector(IMEM_DATA_BUS-1 downto 0);
    );
end IF_ID;


architecture behavioral of IF_ID is
begin
end behavioral;
