----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.12.2016 14:10:51
-- Design Name: 
-- Module Name: circuito_dados - Behavioral
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

entity circuito_dados is
  Port (
        s: in std_logic_vector(7 downto 0);
        clk, reset: in std_logic;
        xopen, err: out std_logic;
        state_ME  : out STD_LOGIC_VECTOR (15 downto 0);
        ctr_err   : out STD_LOGIC_VECTOR (3 downto 0);
        ctr_Dopen : out STD_LOGIC_VECTOR (3 downto 0)
         );
end circuito_dados;

architecture Behavioral of circuito_dados is
    component ctr_16
        Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           ld : in STD_LOGIC;
           d  : in STD_LOGIC_VECTOR (3 downto 0);
           q: out STD_LOGIC_VECTOR (3 downto 0));
end component;

        
        signal xopen_inter, xopen_inter_i, err_inter, err_inter_i, ctr_xopen_reset, ctr_err_reset: std_logic;
        signal q_ctr_xopen, q_ctr_err: std_logic_vector(3 downto 0);
begin


    ctr_16_open: ctr_16 port map (
        clk => clk , reset => ctr_xopen_reset, ce => s(2), 
        ld => '0' , d => "0000", q=> q_ctr_xopen
        );
        xopen_inter_i <= not(q_ctr_xopen(3)) and q_ctr_xopen(2) and not(q_ctr_xopen(1)) and q_ctr_xopen(0);
        ctr_xopen_reset <= reset or xopen_inter_i;
        xopen_inter <= not(xopen_inter_i) and s(2);
    
    ctr_16_err: ctr_16 port map (
        clk => clk , reset => ctr_err_reset, ce => s(6), 
        ld => '0' , d => "0000", q=> q_ctr_err
        );
        err_inter_i <= (q_ctr_err(3)) and not(q_ctr_err(2)) and not(q_ctr_err(1)) and q_ctr_err(0);
        ctr_err_reset <= reset or err_inter_i;
        err_inter <= not(err_inter_i) and s(6);
        
    --saidas
    xopen <= xopen_inter;
    err <= err_inter;
    ctr_err <= q_ctr_err;
    ctr_Dopen <= q_ctr_xopen;
    state_ME <= "00000000" & s;


end Behavioral;
