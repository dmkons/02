library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;


entity IF_ID is
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        pc_in : in std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        instruction_in : in std_logic_vector(IDATA_BUS-1 downto 0);

        pc_out : out std_logic_vector(MEM_ADDR_COUNT-1 downto 0);
        instruction_out : out std_logic_vector(IDATA_BUS-1 downto 0)
    );
end IF_ID;


architecture behavioral of IF_ID is
begin



end behavioral;
