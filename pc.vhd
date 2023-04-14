Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
entity pc is port(clk,rst,en:in std_logic; --addAmt is the amount to be added by the pc
addAmt:in std_logic_vector(1 downto 0);
ci:out std_logic_vector(15 downto 0) --ci: current instruction being pointed by the PC
);
end entity;
architecture pc_arch of pc is
signal tmp:std_logic_vector(15 downto 0);
begin
process(clk,rst) --may want to update
BEGIN
if(rst='1') then
tmp<=(others=>'0');
elsif(rising_edge(clk) and en='1') then
    tmp<=std_logic_vector(unsigned(tmp)+unsigned(addAmt));
end if;
end process;
ci<=tmp;
end pc_arch;
