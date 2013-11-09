library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity forwarding_unit is
    port(
        rs_address_from_id_ex : in std_logic_vector(RADDR_BUS-1 downto 0);
        rt_address_from_id_ex : in std_logic_vector(RADDR_BUS-1 downto 0);
        register_destination_from_ex_mem :
            in std_logic_vector(RADDR_BUS-1 downto 0);
        register_destination_from_mem_wb :
            in std_logic_vector(RADDR_BUS-1 downto 0);
        register_write_from_ex_mem : in std_logic;
        register_write_from_mem_wb : in std_logic;

        forward_rs_out : out std_logic_vector(1 downto 0);
        forward_rt_out : out std_logic_vector(1 downto 0)
    );
end forwarding_unit;

architecture behavioural of forwarding_unit is
begin
end behavioural;
