library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mips_constant_pkg.all;


entity IF_ID is
    generic(
        IMEM_DATA_BUS : natural := IDATA_BUS;
        PC_SIZE : natural := MEM_ADDR_COUNT
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        halt : in std_logic;
        pc_in : in unsigned(PC_SIZE-1 downto 0);
        instruction_in : in std_logic_vector(IMEM_DATA_BUS-1 downto 0);

        pc_out : out unsigned(PC_SIZE-1 downto 0);
        instruction_out : out std_logic_vector(IMEM_DATA_BUS-1 downto 0)
    );
end IF_ID;


architecture behavioral of IF_ID is
begin

    main_control_unit: entity work.flip_flop
    generic map(
                    OPCODE_SIZE => OPCODE_SIZE,
                    FUNCTION_SIZE => FUNCTION_SIZE
                )
    port map (
                 reset => reset,
                 clock => CLK,
                 instruction_opcode => instruction_opcode,
                 instruction_func => instruction_func,
                 processor_enable => processor_enable,

                 register_destination => register_destination,
                 memory_to_register => memory_to_register,
                 alu_source => alu_source,
                 alu_func => alu_func,
                 register_write => register_write,
                 jump => jump,
                 shift_swap => shift_swap,
                 pc_enable => pc_enable,
                 memory_write => memory_write

             );



end behavioral;
