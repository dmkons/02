LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
ENTITY tb_wb_stage IS
END tb_wb_stage;
 
ARCHITECTURE behavior OF tb_wb_stage IS 
 
    COMPONENT wb_stage
    PORT(
         data_memory_in : IN  std_logic_vector(31 downto 0);
         alu_result_in : IN  std_logic_vector(31 downto 0);
         memory_to_register_in : IN  std_logic;
         write_data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal data_memory_in : std_logic_vector(31 downto 0) := (others => '0');
   signal alu_result_in : std_logic_vector(31 downto 0) := (others => '0');
   signal memory_to_register_in : std_logic := '0';

 	--Outputs
   signal write_data_out : std_logic_vector(31 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
   uut: wb_stage PORT MAP (
          data_memory_in => data_memory_in,
          alu_result_in => alu_result_in,
          memory_to_register_in => memory_to_register_in,
          write_data_out => write_data_out
        );


   stim_proc: process
   begin		
      wait for 100 ns;	

      data_memory_in <= X"DEADBEEF";
      alu_result_in <= X"CAFEBABE";
      memory_to_register_in <= '0';
      wait for clk_period;
      test("", "use data from alu operation", write_data_out, X"CAFEBABE");
      
      data_memory_in <= X"DEADBEEF";
      alu_result_in <= X"CAFEBABE";
      memory_to_register_in <= '1';
      wait for clk_period;
      test("", "use data from memory", write_data_out, X"DEADBEEF");


      wait;
   end process;

END;
