library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.opcodes.all;

entity control_unit is
    generic(
        OPCODE_SIZE: natural;
        FUNCTION_SIZE: natural
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        instruction_opcode : in std_logic_vector(OPCODE_SIZE-1 downto 0);
        instruction_function : in std_logic_vector(FUNCTION_SIZE-1 downto 0);
        alu_function : out std_logic_vector (5 downto 0);
        alu_source : out  std_logic;
        register_destination : out  std_logic;
        branch : out  std_logic;
        memory_read : out  std_logic;
        memory_write : out  std_logic;
        memory_to_register : out  std_logic;
        register_write : out  std_logic;
        jump : out std_logic
    );
end control_unit;


architecture behavioral of control_unit is
begin

    process (clk, reset, processor_enable, instruction_opcode)
    begin
        -- Set defauts
        alu_function <= FUNCTION_PASSTHROUGH;
        alu_source <= '0';
        register_destination <= '0';
        branch <= '0';
        memory_read <= '0';
        memory_write <= '0';
        memory_to_register <= '0';
        register_write <= '0';
        
        case instruction_opcode is
            when OPCODE_R_ALL =>
                alu_function <= instruction_function;
                register_destination <= '1';
                register_write <= '1';
                
            when OPCODE_BEQ =>
                alu_function <= FUNCTION_SUB;
                branch <= '1';
            
            when OPCODE_LW =>
                alu_function <= FUNCTION_ADD;
                alu_source <= '1';
                memory_read <= '1';
                memory_to_register <= '1';
                register_write <= '1';
        
            when OPCODE_SW =>
                alu_function <= FUNCTION_ADD;
                alu_source <= '1';
                memory_write <= '1';
                
            when OPCODE_J =>
                jump <= '1';
                
            when OPCODE_ADDI =>
                alu_source <= '1';
                alu_function <= FUNCTION_ADD;
                register_write <= '1';

            when others =>
        end case;

    -- ADD, SUB, SLT, AND, OR, BEQ, LW, SW, LUI, J
    end process;

end behavioral;
