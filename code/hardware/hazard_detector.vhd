library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

entity hazard_detector is
    port(
        register_address_in : in std_logic_vector(RADDR_BUS-1 downto 0);
        register_write_execute_in : in std_logic;
        register_write_memory_in : in std_logic;
        register_destination_execute_in : std_logic_vector(RADDR_BUS-1 downto 0);
        register_destination_memory_in : std_logic_vector(RADDR_BUS-1 downto 0);

        hazard_out : out std_logic_vector(1 downto 0)
    );
end hazard_detector;

architecture behavioural of hazard_detector is
begin
    process(register_address_in, register_write_execute_in, register_write_memory_in,
        register_destination_execute_in, register_destination_memory_in)
    begin
        -- default
        hazard_out <= "00";

        -- execute hazard
        if register_write_execute_in = '1' and
                register_destination_execute_in = register_address_in then
            hazard_out <= "01";
        end if;

        -- memory hazard
        if register_write_memory_in = '1' and 
                register_destination_memory_in = register_address_in then
            hazard_out <= "10";
        end if;
    end process;
end behavioural;
