library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- ===================================================================================================
-- VHDL file to interface with 7 segment display
-- ---------------------------------------------------------------------------------------------------
--  INPUTs  => CLK 
--          => aceso1 ==> enables segment 1 (i.e., turns the segment on)
--          => aceso2 ==> enables segment 2 (i.e., turns the segment on)
--          => aceso3 ==> enables segment 3 (i.e., turns the segment on)
--          => aceso4 ==> enables segment 4 (i.e., turns the segment on)
--          => (disp1_3,disp1_2,disp1_1,disp1_0) ==> hexadecimal number to write on the 1st segment
--          => (disp2_3,disp2_2,disp2_1,disp2_0) ==> hexadecimal number to write on the 2nd segment
--          => (disp3_3,disp3_2,disp3_1,disp3_0) ==> hexadecimal number to write on the 3th segment
--          => (disp4_3,disp4_2,disp4_1,disp4_0) ==> hexadecimal number to write on the 4th segment
--  OUTPUTs => Signals to interface with the 7Segment display
-- ===================================================================================================
entity disp7 is
  Port (
   disp4_3, disp4_2, disp4_1, disp4_0, aceso4 : in std_logic;
   disp3_3, disp3_2, disp3_1, disp3_0, aceso3 : in std_logic;
   disp2_3, disp2_2, disp2_1, disp2_0, aceso2 : in std_logic;
   disp1_3, disp1_2, disp1_1, disp1_0, aceso1 : in std_logic;
   clk : in std_logic;
	en1, en2, en3, en4 : out std_logic;
	segm1, segm2, segm3, segm4, segm5, segm6, segm7, dp : out std_logic
  );
end disp7;

architecture mixed of disp7 is

type STATE_TYPE is (S0, S1, S2);
signal cs, ns : STATE_TYPE;
signal d1, d2, d3, d4, en, hex : std_logic_vector(3 downto 0);
signal led : std_logic_vector(7 downto 0);
signal count : std_logic_vector(1 downto 0);
signal cnt_en, srg_en, en_oe : std_logic;
signal srg_out : std_logic_vector(3 downto 0) := "1000";

begin

d1(0)<=disp1_0; d1(1)<=disp1_1; d1(2)<=disp1_2; d1(3)<=disp1_3;
d2(0)<=disp2_0; d2(1)<=disp2_1; d2(2)<=disp2_2; d2(3)<=disp2_3;
d3(0)<=disp3_0; d3(1)<=disp3_1; d3(2)<=disp3_2; d3(3)<=disp3_3;
d4(0)<=disp4_0; d4(1)<=disp4_1; d4(2)<=disp4_2; d4(3)<=disp4_3;

-- 2 bit counter
process (clk)
begin
  if rising_edge(clk) then
	  if cnt_en = '1' then
		  count <= count + 1;
    end if;
  end if;
end process;

-- en rotate
process (clk)
begin
	if rising_edge(clk) then
		if srg_en = '1' then
			srg_out <= srg_out(0) & srg_out(3 downto 1);
    end if;
  end if;
end process;
en <= srg_out when en_oe='1' else (others=>'0');

-- 4-to-1 Mux
with count select
  hex <= d4 when "00",
         d3 when "01",
         d2 when "10",
         d1 when others;

-- hex2led (decimal point is MSB)
with hex select
  led <= "11111001" when "0001",   --1
         "10100100" when "0010",   --2
         "10110000" when "0011",   --3
         "10011001" when "0100",   --4
         "10010010" when "0101",   --5
         "10000010" when "0110",   --6
         "11111000" when "0111",   --7
         "10000000" when "1000",   --8
         "10010000" when "1001",   --9
         "10001000" when "1010",   --A
         "10000011" when "1011",   --b
         "11000110" when "1100",   --C
         "10100001" when "1101",   --d
         "10000110" when "1110",   --E
         "10001110" when "1111",   --F
         "11000000" when others;   --0

-- state machine
cs <= ns when rising_edge(clk) else cs; 

process (cs)
begin
  en_oe <= '0';
	srg_en <= '0';
	cnt_en <= '0';
  case cs is
	  when S0 =>
		  ns <= S1;
		when S1 =>
		  en_oe <= '1';
			ns <= S2;
    when S2 =>
		  srg_en <= '1';
			cnt_en <= '1';
			ns <= S0;
    when others =>
		  ns <= S0;
	end case;
end process;

en1 <= not(en(0) and aceso1); en2 <= not(en(1) and aceso2);
en3 <= not(en(2) and aceso3); en4 <= not(en(3) and aceso4);

segm1 <= led(0); segm2 <= led(1); segm3 <= led(2);
segm4 <= led(3); segm5 <= led(4); segm6 <= led(5);
segm7 <= led(6); dp <= led(7);

end mixed;
