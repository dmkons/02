LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 
 
ENTITY tb_if_stage IS
END tb_if_stage;
 
ARCHITECTURE behavior OF tb_if_stage IS 
 
    COMPONENT if_stage
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         processor_enable : IN  std_logic;
         pc_source_in : IN  std_logic;
         pc_in : IN  std_logic_vector(7 downto 0);
         pc_out : OUT  std_logic_vector(7 downto 0);
         instruction_address_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal processor_enable : std_logic := '0';
   signal pc_source_in : std_logic := '0';
   signal pc_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal pc_out : std_logic_vector(7 downto 0);
   signal instruction_address_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: if_stage PORT MAP (
          clk => clk,
          reset => reset,
          processor_enable => processor_enable,
          pc_source_in => pc_source_in,
          pc_in => pc_in,
          pc_out => pc_out,
          instruction_address_out => instruction_address_out
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
       processor_enable <= '1';
       pc_source_in <= '1';
       pc_in <= "00000000";
      wait for clk_period;
      test("", "setting pc to 0", instruction_address_out, "00000000");
      test("", "setting pc to 0", pc_out, "00000001");
      
       pc_source_in <= '0';
      wait for clk_period;
      test("", "letting pc go 1", instruction_address_out, "00000001");
      test("", "setting pc to 1", pc_out, "00000010");
      
      wait for clk_period;
      test("", "letting pc go 2", instruction_address_out, "00000010");
      test("", "setting pc to 2", pc_out, "00000011");
      
      wait for clk_period;
      test("", "letting pc go 3", instruction_address_out, "00000011");
      test("", "setting pc to 3", pc_out, "00000100");
      
      wait for clk_period;
      test("", "letting pc go 4", instruction_address_out, "00000100");
      test("", "setting pc to 4", pc_out, "00000101");
      
      pc_source_in <= '1';
      pc_in <= "11111110";
      wait for clk_period;
      test("", "setting pc to max-1", instruction_address_out, "11111110");
      test("", "setting pc to max-1", pc_out, "11111111");
      
      pc_source_in <= '0';
      wait for clk_period;
      test("", "letting pc go to max", instruction_address_out, "11111111");
      test("", "setting pc go to max", pc_out, "00000000");
      
      wait for clk_period;
      test("", "should have looped to 0", instruction_address_out, "00000000");
      test("", "should have looped to 0", pc_out, "00000001");

      wait;
   end process;

END;
