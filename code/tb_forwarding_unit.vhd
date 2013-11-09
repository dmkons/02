LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.test_utils.all;
 

ENTITY tb_forwarding_unit IS
END tb_forwarding_unit;
 
ARCHITECTURE behavior OF tb_forwarding_unit IS 
 
    COMPONENT forwarding_unit
    PORT(
         rs_address_from_id_ex : IN  std_logic_vector(4 downto 0);
         rt_address_from_id_ex : IN  std_logic_vector(4 downto 0);
         register_destination_from_ex_mem : IN  std_logic_vector(4 downto 0);
         register_destination_from_mem_wb : IN  std_logic_vector(4 downto 0);
         register_write_from_ex_mem : IN  std_logic;
         register_write_from_mem_wb : IN  std_logic;
         forward_rs_out : OUT  std_logic_vector(1 downto 0);
         forward_rt_out : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal rs_address_from_id_ex : std_logic_vector(4 downto 0) := (others => '0');
   signal rt_address_from_id_ex : std_logic_vector(4 downto 0) := (others => '0');
   signal register_destination_from_ex_mem : std_logic_vector(4 downto 0) := (others => '0');
   signal register_destination_from_mem_wb : std_logic_vector(4 downto 0) := (others => '0');
   signal register_write_from_ex_mem : std_logic := '0';
   signal register_write_from_mem_wb : std_logic := '0';

 	--Outputs
   signal forward_rs_out : std_logic_vector(1 downto 0);
   signal forward_rt_out : std_logic_vector(1 downto 0);
 
   constant clk_period : time := 10 ns;
 
BEGIN
   uut: forwarding_unit PORT MAP (
          rs_address_from_id_ex => rs_address_from_id_ex,
          rt_address_from_id_ex => rt_address_from_id_ex,
          register_destination_from_ex_mem => register_destination_from_ex_mem,
          register_destination_from_mem_wb => register_destination_from_mem_wb,
          register_write_from_ex_mem => register_write_from_ex_mem,
          register_write_from_mem_wb => register_write_from_mem_wb,
          forward_rs_out => forward_rs_out,
          forward_rt_out => forward_rt_out
        );

 
   stim_proc: process
   begin		
      wait for 100 ns;	
      
      rs_address_from_id_ex <= "00000";
      rt_address_from_id_ex <= "00000";
      register_destination_from_ex_mem <= "00000";
      register_destination_from_mem_wb <= "00000";
      register_write_from_ex_mem <= '0';
      register_write_from_mem_wb <= '0';
      wait for clk_period;
      test("no forwarding", "rs", forward_rs_out, "00");
      test("no forwarding", "rt", forward_rt_out, "00"); 
      
      rs_address_from_id_ex <= "10000";
      rt_address_from_id_ex <= "10000";
      register_destination_from_ex_mem <= "10000";
      register_destination_from_mem_wb <= "10000";
      register_write_from_ex_mem <= '1';
      register_write_from_mem_wb <= '0';
      wait for clk_period;
      test("exmem forwarding", "rs", forward_rs_out, "01");
      test("exmem forwarding", "rt", forward_rt_out, "01");   
      
      rs_address_from_id_ex <= "10000";
      rt_address_from_id_ex <= "10000";
      register_destination_from_ex_mem <= "10000";
      register_destination_from_mem_wb <= "10000";
      register_write_from_ex_mem <= '0';
      register_write_from_mem_wb <= '1';
      wait for clk_period;
      test("memb forwarding", "rs", forward_rs_out, "10");
      test("memwb forwarding", "rt", forward_rt_out, "10");

      wait;
   end process;

END;
