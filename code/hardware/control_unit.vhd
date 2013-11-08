library ieee;
use ieee.std_logic_1164.all;
use work.opcodes.all;
use work.mips_constant_pkg.all;

entity control_unit is
    port(
        clk : in std_logic;
        reset : in std_logic;
        processor_enable : in std_logic;
        instruction_opcode : in std_logic_vector(OPCODE_SIZE-1 downto 0);
        instruction_function : in std_logic_vector(FUNCTION_SIZE-1 downto 0);
        ex_control_signals : out ex_control_signals;
        mem_control_signals : out mem_control_signals;
        wb_control_signals : out wb_control_signals;
        jump : out std_logic
    );
end control_unit;


architecture behavioral of control_unit is
begin

    process (clk, reset, processor_enable, instruction_opcode, instruction_function)
    begin
        -- Set defauts
        ex_control_signals.alu_function <= FUNCTION_PASSTHROUGH;
        ex_control_signals.alu_source <= '0';
        ex_control_signals.register_destination <= '0';
        mem_control_signals.branch <= '0';
        mem_control_signals.memory_write <= '0';
        wb_control_signals.memory_to_register <= '0';
        wb_control_signals.register_write <= '0';
        
        case instruction_opcode is
            when OPCODE_R_ALL =>
                ex_control_signals.alu_function <= instruction_function;
                ex_control_signals.register_destination <= '1';
                wb_control_signals.register_write <= '1';
                
            when OPCODE_BEQ =>
                ex_control_signals.alu_function <= FUNCTION_SUB;
                mem_control_signals.branch <= '1';
            
            when OPCODE_LW =>
                ex_control_signals.alu_function <= FUNCTION_ADD;
                ex_control_signals.alu_source <= '1';
                wb_control_signals.memory_to_register <= '1';
                wb_control_signals.register_write <= '1';
        
            when OPCODE_SW =>
                ex_control_signals.alu_function <= FUNCTION_ADD;
                ex_control_signals.alu_source <= '1';
                mem_control_signals.memory_write <= '1';
                
            when OPCODE_J =>
                jump <= '1';
                
            when OPCODE_ADDI =>
                ex_control_signals.alu_source <= '1';
                ex_control_signals.alu_function <= FUNCTION_ADD;
                wb_control_signals.register_write <= '1';

            when others =>
        end case;

    -- ADD, SUB, SLT, AND, OR, BEQ, LW, SW, LUI, J
    end process;

end behavioral;
