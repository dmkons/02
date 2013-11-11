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

constant R0 : std_logic_vector(4 downto 0) := "00000";
constant R1 : std_logic_vector(4 downto 0) := "00001";
constant R2 : std_logic_vector(4 downto 0) := "00010";
constant R3 : std_logic_vector(4 downto 0) := "00011";
constant R4 : std_logic_vector(4 downto 0) := "00100";
constant R5 : std_logic_vector(4 downto 0) := "00101";
constant R6 : std_logic_vector(4 downto 0) := "00110";
constant R7 : std_logic_vector(4 downto 0) := "00111";
constant R8 : std_logic_vector(4 downto 0) := "01000";
constant R9 : std_logic_vector(4 downto 0) := "01001";
constant R10 : std_logic_vector(4 downto 0) := "01010";
constant R11 : std_logic_vector(4 downto 0) := "01011";
constant R12 : std_logic_vector(4 downto 0) := "01100";
constant R13 : std_logic_vector(4 downto 0) := "01101";
constant R14 : std_logic_vector(4 downto 0) := "01110";
constant R15 : std_logic_vector(4 downto 0) := "01111";
constant R16 : std_logic_vector(4 downto 0) := "10000";
constant R17 : std_logic_vector(4 downto 0) := "10001";
constant R18 : std_logic_vector(4 downto 0) := "10010";
constant R19 : std_logic_vector(4 downto 0) := "10011";
constant R20 : std_logic_vector(4 downto 0) := "10100";
constant R21 : std_logic_vector(4 downto 0) := "10101";
constant R22 : std_logic_vector(4 downto 0) := "10110";
constant R23 : std_logic_vector(4 downto 0) := "10111";
constant R24 : std_logic_vector(4 downto 0) := "11000";
constant R25 : std_logic_vector(4 downto 0) := "11001";
constant R26 : std_logic_vector(4 downto 0) := "11010";
constant R27 : std_logic_vector(4 downto 0) := "11011";
constant R28 : std_logic_vector(4 downto 0) := "11100";
constant R29 : std_logic_vector(4 downto 0) := "11101";
constant R30 : std_logic_vector(4 downto 0) := "11110";
constant R31 : std_logic_vector(4 downto 0) := "11111";

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
