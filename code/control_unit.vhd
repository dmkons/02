library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.opcodes.all;

entity control_unit is
    Port ( instruction : in  STD_LOGIC_VECTOR (0 downto 31);
           alu_source : out  STD_LOGIC;
           alu_operation : out  STD_LOGIC;
           register_destination : out  STD_LOGIC;
           branch : out  STD_LOGIC;
           memory_read : out  STD_LOGIC;
           memory_write : out  STD_LOGIC;
           memory_to_register : out  STD_LOGIC;
           pc_source : out  STD_LOGIC);
end control_unit;

architecture Behavioral of control_unit is

begin

    -- Set defauts
    alu_source <= '0';
    alu_operation <= '0';
    register_destination <= '0';
    branch <= '0';
    memory_read <= '0';
    memory_write <= '0';
    memory_to_register <= '0';
    pc_source <= '0';
    
    case instruction is
        

-- ADD, SUB, SLT, AND, OR, BEQ, LW, SW, LDI, J


end Behavioral;