library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;


entity IF_ID is
    generic(
        IMEM_DATA_BUS : natural := IDATA_BUS;
        PC_SIZE : natural := MEM_ADDR_COUNT
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        pc_in : in unsigned(PC_SIZE-1 downto 0);
        instruction_in : in std_logic_vector(IMEM_DATA_BUS-1 downto 0);

        pc_out : out unsigned(PC_SIZE-1 downto 0);
        instruction_out : out std_logic_vector(IMEM_DATA_BUS-1 downto 0)
    );
end IF_ID;


architecture behavioral of IF_ID is
begin



end behavioral;
