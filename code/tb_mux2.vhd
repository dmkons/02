
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
 
ENTITY tb_mux2 IS
END tb_mux2;
 
ARCHITECTURE behavior OF tb_mux2 IS 

   --Inputs
   signal a_in : std_logic_vector(31 downto 0) := (others => '0');
   signal b_in : std_logic_vector(31 downto 0) := (others => '0');
   signal select_in : std_logic := '0';

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	uut: entity work.mux2
    generic map(
        N => 32
    )PORT MAP (
      a_in => a_in,
      b_in => b_in,
      select_in => select_in,
      data_out => data_out
    );


   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

      a_in <= X"DEADBEEF";
      b_in <= X"CAFEBABE";
      select_in <= '0';
      
      wait for clk_period;    
      test("", "select 0", data_out, X"DEADBEEF");
      select_in <= '1';
      wait for clk_period;    
      test("", "select 1", data_out, X"CAFEBABE");
      b_in <= X"FACEB00C";
      wait for clk_period;
      test("", "select 1 (updated values)", data_out, X"FACEB00C");
      wait;
   end process;

END;
