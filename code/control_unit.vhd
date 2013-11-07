library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.opcodes.all;

entity control_unit is
    generic ( OPCODE_SIZE: natural; FUNCTION_SIZE: natural);
    Port (  instruction_opcode : in std_logic_vector(OPCODE_SIZE-1 downto 0);
            instruction_func : in std_logic_vector(FUNCTION_SIZE-1 downto 0);
            alu_function : out STD_LOGIC_VECTOR (5 downto 0)
            alu_source : out  STD_LOGIC;
            register_destination : out  STD_LOGIC;
            branch : out  STD_LOGIC;
            memory_read : out  STD_LOGIC;
            memory_write : out  STD_LOGIC;
            memory_to_register : out  STD_LOGIC;
            register_write : out  STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

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

-- ADD, SUB, SLT, AND, OR, BEQ, LW, SW, LUI, J


end Behavioral;