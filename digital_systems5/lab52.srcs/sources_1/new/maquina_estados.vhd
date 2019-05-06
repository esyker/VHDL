----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2016 12:40:32
-- Design Name: 
-- Module Name: maquina_estados - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity maquina_estados is
  Port (
        L : in std_logic;
        R : in std_logic; 
        reset: in std_logic;
        clk: in std_logic;
        xopen: in std_logic;
        err: in std_logic;
        s: out std_logic_vector(7 downto 0));
end maquina_estados;



architecture Behavioral of maquina_estados is

component ff_de 
        Port ( din : in STD_LOGIC;
           clk : in STD_LOGIC;
           ce  : in STD_LOGIC;
           reset : in STD_LOGIC;
           set : in STD_LOGIC;
           dout : out STD_LOGIC);
    end component;
    
    signal s0_inter, s1_inter, s2_inter, s3_inter, s4_inter, s5_inter, s6_inter, s7_inter: std_logic;
    signal s0_ce, s0_din, s1_ce, s1_din, s2_ce, s2_din, s3_ce, s3_din, s4_ce, s4_din, s5_ce, s5_din, s6_ce, s6_din, s7_ce, s7_din: std_logic;
begin
    
    --ff S0
    s0_din <= (s2_inter and not(xopen));
    s0_ce <= ((L xnor R) nand s0_inter);
    
    S0_ff: ff_de port map (
            din => s0_din, dout => s0_inter , 
            clk => clk,  reset => '0', set => reset, ce => s0_ce 
        );
    
    --ff S1
    s1_din <= (s0_inter and not(L) and R);
    s1_ce <= ((L xnor R) nand s1_inter);
    S1_ff: ff_de port map (
            din => s1_din, dout => s1_inter , 
            clk => clk,  reset => reset, set => '0', ce => s1_ce 
        );
    
    --ff S2
    s2_din <= ((s5_inter and L and not(R)) or (s1_inter and L and not(R)));
    s2_ce <=  (s2_inter nand xopen);  
    S2_ff: ff_de port map (
            din => s2_din, dout => s2_inter , 
            clk => clk,  reset => reset, set => '0', ce => s2_ce 
        );  
    
    --ff S3
    s3_din <= (s0_inter and L and not(R));
    s3_ce <= ((L xnor R) nand s3_inter);     
    S3_ff: ff_de port map (
            din => s3_din, dout => s3_inter , 
            clk => clk,  reset => reset, set => '0', ce => s3_ce 
        );  
    
    --ff S4
    s4_din <= ((s6_inter and not(err)) or ((L xor R) and s3_inter) or (s1_inter and R and not(L)));
    s4_ce <= ((L xnor R) nand s4_inter);                    
    S4_ff: ff_de port map (
            din => s4_din, dout => s4_inter , 
            clk => clk,  reset => reset, set => '0', ce => s4_ce 
        ); 
        
    --ff S5
    s5_din <= s4_inter and R and not(L);
    s5_ce <= ((L xnor R) nand s5_inter);                               
    S5_ff: ff_de port map (
            din => s5_din, dout => s5_inter , 
            clk => clk,  reset => reset, set => '0', ce => s5_ce 
        );
    
    --ff S6
    s6_din <= ((s5_inter and R and not(L)) or ((L xor R) and s7_inter));
    s6_ce <= (err nand s6_inter);
    S6_ff: ff_de port map (
            din => s6_din, dout => s6_inter , 
            clk => clk,  reset => reset, set => '0', ce => s6_ce 
        ); 
    
    --ff S7
    s7_din <= s4_inter and L and not(R);
    s7_ce <= ((L xnor R) nand s7_inter);     
    S7_ff: ff_de port map (
            din => s7_din, dout => s7_inter , 
            clk => clk,  reset => reset, set => '0', ce => s7_ce 
        );    
    
    --saidas
    s <= s7_inter & s6_inter & s5_inter & s4_inter & s3_inter & s2_inter & s1_inter & s0_inter;

end Behavioral;
