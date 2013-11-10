library ieee;
use ieee.std_logic_1164.all;
use work.mips_constant_pkg.all;

package opcodes is

function get_opcode(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector;
function get_function(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector;
function get_rs(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector;
function get_rt(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector;
function get_rd(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector;

constant OPCODE_SIZE : integer := 6;
constant FUNCTION_SIZE : integer := 6;

constant OPCODE_R_ALL : std_logic_vector(5 downto 0):= "000000";
constant OPCODE_ADDI : std_logic_vector(5 downto 0) := "001000";
constant OPCODE_BEQ : std_logic_vector(5 downto 0) := "000100";
constant OPCODE_LW : std_logic_vector(5 downto 0) := "100011";
constant OPCODE_SW : std_logic_vector(5 downto 0) := "101011";
constant OPCODE_J : std_logic_vector(5 downto 0) := "000010";

constant FUNCTION_ADD : std_logic_vector(5 downto 0) := "100000";
constant FUNCTION_AND : std_logic_vector(5 downto 0) := "100100";
constant FUNCTION_OR : std_logic_vector(5 downto 0) := "100101";
constant FUNCTION_SLT : std_logic_vector(5 downto 0) := "101010";
constant FUNCTION_SUB : std_logic_vector(5 downto 0) := "100010";

constant FUNCTION_PASSTHROUGH : std_logic_vector(5 downto 0) := "111111";
end opcodes;

package body opcodes is
    function get_opcode(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector is
    begin
        return instruction(31 downto 26);
    end;

    function get_function(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector is
    begin
        return instruction(5 downto 0);
    end;

    function get_rs(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector is
    begin
        return instruction(25 downto 21);
    end;

    function get_rt(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector is
    begin
        return instruction(20 downto 16);
    end;

    function get_rd(instruction : std_logic_vector(IDATA_BUS-1 downto 0))
    return std_logic_vector is
    begin
        return instruction(15 downto 11);
    end;
end opcodes;
