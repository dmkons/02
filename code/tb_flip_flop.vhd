LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
 
ENTITY tb_flip_flop IS
END tb_flip_flop;
 
ARCHITECTURE behavior OF tb_flip_flop IS 

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';
   signal data_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: entity work.flip_flop
   generic map(N => 32)
   PORT MAP (
          clk => clk,
          reset => reset,
          enable => enable,
          data_in => data_in,
          data_out => data_out
        );

   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   stim_proc: process
   begin		
      wait for 100 ns;
      enable <= '1';
      data_in <= X"DEADBEEF";
      wait for clk_period;
      test("", "", data_out, X"DEADBEEF");
      
      data_in <= X"CAFEBABE";
      wait for clk_period;
      test("", "", data_out, X"CAFEBABE");
      
      enable <= '0';
      data_in <= X"FACEB00C";
      wait for clk_period;
      test("", "should not update when enable is off", data_out, X"CAFEBABE");
      
      reset <= '1';
      wait for clk_period;
      test("", "should reset even when enable if off", data_out, X"00000000");
      
      enable <= '1';
      reset <= '0';
      wait for clk_period;
      test("", "", data_out, X"FACEB00C");

      wait;
   end process;

END;
