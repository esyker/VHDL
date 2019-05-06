library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- =========================================================
-- VHDL file to generate a set of slower clock signals
-- ---------------------------------------------------------
--  INPUTs  => CLK 
--  OUTPUTs => CLK_FAST = 55 MHz (same as CLK)
--          => CLK_SLOW = 840 Hz (CLK/2^16)
--          => CLK_DISP = 0.8 Hz (CLK/2^26)
-- =========================================================

entity clkdiv is
  Port (
	clk : in std_logic;
	clk_fast, clk_slow, clk_disp : out std_logic
  );
end clkdiv;

architecture mixed of clkdiv is

signal clk_i : std_logic;
-- I have to count at least to 100.000.000
signal cnt : std_logic_vector(26 downto 0);

begin

BUFG_INST1: BUFG port map (I => clk, O => clk_i);
clk_fast <= clk_i;

process (clk_i)
begin
	if rising_edge(clk_i) then
		cnt <= cnt + 1;
	end if;
end process;

BUFG_INST2: BUFG port map (I => cnt(26), O => clk_slow);
BUFG_INST3: BUFG port map (I => cnt(16), O => clk_disp);
 
end mixed;



