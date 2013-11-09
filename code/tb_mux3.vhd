LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
ENTITY tb_mux3 IS
END tb_mux3;
 
ARCHITECTURE behavior OF tb_mux3 IS 

   --Inputs
   signal a_in : std_logic_vector(31 downto 0) := (others => '0');
   signal b_in : std_logic_vector(31 downto 0) := (others => '0');
   signal c_in : std_logic_vector(31 downto 0) := (others => '0');
   signal select_in : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: entity work.mux3
   generic map(
        N => 32
   )PORT MAP (
          a_in => a_in,
          b_in => b_in,
          c_in => c_in,
          select_in => select_in,
          data_out => data_out
        );

   stim_proc: process
   begin		
      wait for 100 ns;
      a_in <= X"DEADBEEF";
      b_in <= X"CAFEBABE";
      c_in <= X"FACEB00C";
      select_in <= "00";
      wait for clk_period;
      test("", "select 0", data_out, X"DEADBEEF");
      select_in <= "01";
      wait for clk_period;
      test("", "select 1", data_out, X"CAFEBABE");
      select_in <= "10";
      wait for clk_period;
      test("", "select 2", data_out, X"FACEB00C");
      select_in <= "11";
      wait for clk_period;
      test("", "select 3 (if this test doesn't pass, you might want to check your metavalue return settings in your simulator)", data_out, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");


      wait;
   end process;

END;
