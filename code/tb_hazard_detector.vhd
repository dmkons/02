LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;

 
ENTITY tb_hazard_detector IS
END tb_hazard_detector;
 
ARCHITECTURE behavior OF tb_hazard_detector IS 
 
    COMPONENT hazard_detector
    PORT(
         register_address_in : IN  std_logic_vector(4 downto 0);
         register_write_execute_in : IN  std_logic;
         register_write_memory_in : IN  std_logic;
         register_destination_execute_in : IN  std_logic_vector(4 downto 0);
         register_destination_memory_in : IN  std_logic_vector(4 downto 0);
         hazard_out : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    
   --Inputs
   signal register_address_in : std_logic_vector(4 downto 0) := (others => '0');
   signal register_write_execute_in : std_logic := '0';
   signal register_write_memory_in : std_logic := '0';
   signal register_destination_execute_in : std_logic_vector(4 downto 0) := (others => '0');
   signal register_destination_memory_in : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal hazard_out : std_logic_vector(1 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: hazard_detector PORT MAP (
          register_address_in => register_address_in,
          register_write_execute_in => register_write_execute_in,
          register_write_memory_in => register_write_memory_in,
          register_destination_execute_in => register_destination_execute_in,
          register_destination_memory_in => register_destination_memory_in,
          hazard_out => hazard_out
        );


   stim_proc: process
   begin		
      wait for 100 ns;	

       register_address_in <= "00000";
       register_write_execute_in <= '0';
       register_write_memory_in <= '0';
       register_destination_execute_in <= "00000";
       register_destination_memory_in <= "00000";
      wait for clk_period;
      test("no hazard", "no write", hazard_out, "00");
      
       register_address_in <= "00100";
       register_write_execute_in <= '1';
       register_write_memory_in <= '1';
       register_destination_execute_in <= "00010";
       register_destination_memory_in <= "00001";
        wait for clk_period;
      test("no hazard", "different addresses", hazard_out, "00");
      
       register_address_in <= "00000";
       register_write_execute_in <= '1';
       register_write_memory_in <= '0';
       register_destination_execute_in <= "00000";
       register_destination_memory_in <= "00000";
        wait for clk_period;
      test("execute hazard", "", hazard_out, "01");
      
       register_address_in <= "00000";
       register_write_execute_in <= '0';
       register_write_memory_in <= '1';
       register_destination_execute_in <= "00000";
       register_destination_memory_in <= "00000";
        wait for clk_period;
      test("memory hazard", "", hazard_out, "10");      

      wait;
   end process;

END;
