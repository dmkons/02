library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.test_utils.all;
use work.opcodes.all;

ENTITY tb_pipeline_flusher IS
END tb_pipeline_flusher;
 
ARCHITECTURE behavior OF tb_pipeline_flusher IS 
 
    COMPONENT pipeline_flusher
    PORT(
         reset : IN  std_logic;
         clk : IN  std_logic;
         branch_in : IN  std_logic;
         flush_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal branch_in : std_logic := '0';

 	--Outputs
   signal flush_out : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline_flusher PORT MAP (
          reset => reset,
          clk => clk,
          branch_in => branch_in,
          flush_out => flush_out
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

      wait for clk_period*10;

      reset <= '1';
      wait for clk_period;
      test("single branch","reset branch",flush_out,'0');
      reset <= '0';
      wait for clk_period;
      branch_in <= '1';
      wait for clk_period;
      test("single branch","branch",flush_out,'1');
      branch_in <= '0';
      wait for clk_period*2;
      test("single branch","just before end of branch",flush_out,'1');
      wait for clk_period;
      test("single branch","after branch flush",flush_out,'0');
      
      reset <= '1';
      wait for clk_period;
      test("single branch","reset branch",flush_out,'0');
      reset <= '0';
      wait for clk_period; 
      branch_in <= '1';
      wait for clk_period;
      test("single branch","branch",flush_out,'1');
      branch_in <= '0';
      wait for clk_period*2;
      test("single branch","rebranch",flush_out,'1');
      branch_in <= '1';
      wait for clk_period*2;
      test("single branch","just before end of branch",flush_out,'1');
      branch_in <= '0';
      wait for clk_period*2;
      test("single branch","after branch",flush_out,'1');
      
      wait;
   end process;

END;
