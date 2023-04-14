Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;
entity Pc is port(clk,rst,en:in std_logic; --addAmt is the amount to be added by the Pc
addAmt:in std_logic_vector(1 downto 0);
ci:out std_logic_vector(15 downto 0) --ci: current instruction being pointed by the Pc
);
end entity;
architecture Pc_arch of Pc is
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
end Pc_arch;
