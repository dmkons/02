LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
 
ENTITY tb_mem_stage IS
END tb_mem_stage;
 
ARCHITECTURE behavior OF tb_mem_stage IS 
 
    COMPONENT mem_stage
    PORT(
         alu_zero_in : IN  std_logic;
         branch_in : IN  std_logic;
         pc_source_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal alu_zero_in : std_logic := '0';
   signal branch_in : std_logic := '0';

 	--Outputs
   signal pc_source_out : std_logic;
   
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: mem_stage PORT MAP (
          alu_zero_in => alu_zero_in,
          branch_in => branch_in,
          pc_source_out => pc_source_out
        );

   stim_proc: process
   begin		
      wait for 100 ns;
      alu_zero_in <= '0';
      branch_in <= '0';
      wait for clk_period;
      test("", "no flags", pc_source_out, '0');
      
      alu_zero_in <= '1';
      branch_in <= '0';
      wait for clk_period;
      test("", "alu zero flag", pc_source_out, '0');
      
      alu_zero_in <= '0';
      branch_in <= '1';
      wait for clk_period;
      test("", "branch flag", pc_source_out, '0');
      
      alu_zero_in <= '1';
      branch_in <= '1';
      wait for clk_period;
      test("", "alu zero flag and branch flag", pc_source_out, '1'); 


      wait;
   end process;

END;
