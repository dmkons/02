library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity pipeline_flusher is
    Port ( reset : in std_logic;
           clk : in std_logic;
           branch_in : in  STD_LOGIC;
           flush_out : out  STD_LOGIC);
end pipeline_flusher;

architecture Behavioral of pipeline_flusher is
    
    signal counter_in : std_logic_vector(1 downto 0);
    signal counter_out : std_logic_vector(1 downto 0);
    
begin

    counter: entity work.flip_flop
    generic map(N => 2)
    port map(
        clk => clk,
        reset => reset,
        enable => '1',
        data_in => counter_in,
        data_out => counter_out
    );
    
    process (clk, branch_in, reset, counter_in, counter_out)
    begin
        if reset='1' then
            counter_in <= "00";
        elsif branch_in='1' then
            counter_in <= "11";
        elsif counter_out/="00" then
            counter_in <= std_logic_vector(unsigned(counter_out) - 1);
        else
            counter_in <= "00";
        end if;
        if counter_out="00" then
            flush_out <= '0';
        else
            flush_out <= '1';
        end if;
    end process;

end Behavioral;

