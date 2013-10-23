library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity processor is
    generic (MEM_ADDR_BUS : natural := DADDR_BUS; MEM_DATA_BUS : natural := DDATA_BUS);
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        imem_address : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        imem_data_in : in std_logic_vector (MEM_DATA_BUS-1 downto 0);
        dmem_data_in : in std_logic_vector (MEM_DATA_BUS-1 downto 0);
        dmem_address : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        dmem_address_wr : out std_logic_vector (MEM_ADDR_BUS-1 downto 0);
        dmem_data_out : out std_logic_vector (MEM_DATA_BUS-1 downto 0);
        dmem_write_enable : out std_logic
    );

end processor;


architecture Behavioral of processor is
begin
end Behavioral;
