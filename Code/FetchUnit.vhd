Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
entity FetchUnit is
    port (
        clk : in std_logic;
        rst:in std_logic; --this reset intialize the Register File to 0
        currInstrPc: in std_logic_vector(15 downto 0);
        instr: out std_logic_vector(31 downto 0);  
        pcNxtAddAmt:out std_logic_vector(1 downto 0)
    );
end FetchUnit;



architecture FetchArch of FetchUnit is
    signal instr1,instr2,nxtInstr:std_logic_vector(15 downto 0):=(others=>'0');
    signal currin : std_logic_vector(15 downto 0):=(others=>'0');
begin
    nxtInstr<=std_logic_vector(unsigned(currInstrPc)+1) when rst='0' else ((15 downto 1 => '0') & '1');
    currin <= currInstrPc when rst='0' else (others => '0');
    instructionFile: entity work.MyMemory generic map(16,16)port map(clk=>clk,rst=>'0',w_en=>'0',r_add1=>currin
    ,r_add2=>nxtInstr,w_add=>(others=>'0'),write_port=>(others=>'0'),read_port_rs=>instr1,read_port_rt=>instr2);
    instr<=instr1&instr2;
    process(instr1,instr2)
        begin
            if(instr1(15 downto 13)="111") then
                pcNxtAddAmt<="10";
            else
                pcNxtAddAmt<="01";
            end if;
    end process;
end architecture;