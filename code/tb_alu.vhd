LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
use work.opcodes.all;
 
ENTITY tb_alu IS
END tb_alu;
 
ARCHITECTURE behavior OF tb_alu IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         x_in : IN  std_logic_vector(31 downto 0);
         y_in : IN  std_logic_vector(31 downto 0);
         function_in : IN  std_logic_vector(5 downto 0);
         result_out : OUT  std_logic_vector(31 downto 0);
         zero_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x_in : std_logic_vector(31 downto 0) := (others => '0');
   signal y_in : std_logic_vector(31 downto 0) := (others => '0');
   signal function_in : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal result_out : std_logic_vector(31 downto 0);
   signal zero_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          x_in => x_in,
          y_in => y_in,
          function_in => function_in,
          result_out => result_out,
          zero_out => zero_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	
      
        x_in <= "00000000000000000000000000000001";
        y_in <= "00000000000000000000000000000001";
        function_in <= FUNCTION_ADD;
        wait for clk_period;
        test("Add", "1+1", result_out, "00000000000000000000000000000010");
        wait for clk_period;
        x_in <= "11111111111111111111111111111111";
        y_in <= "11111111111111111111111111111111";
        function_in <= FUNCTION_ADD;
        wait for clk_period;
        test("Add", "-1 + -1", result_out, "11111111111111111111111111111110");
        wait for clk_period;
        x_in <= "00000000000000000000000000000001";
        y_in <= "11111111111111111111111111111111";
        function_in <= FUNCTION_ADD;
        wait for clk_period;
        test("Add", "1 + -1", result_out, "00000000000000000000000000000000");
        wait for clk_period;
    
      wait for clk_period;

      wait;
   end process;

END;
