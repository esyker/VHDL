----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2016 22:10:00
-- Design Name: 
-- Module Name: ctr_16 - Behavioral
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

entity ctr_16 is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           ld : in STD_LOGIC;
           d  : in STD_LOGIC_VECTOR (3 downto 0);
           q: out STD_LOGIC_VECTOR (3 downto 0));
end ctr_16;

architecture Behavioral of ctr_16 is
 -- declaracao dos componentes
    component ff_de 
        Port ( din : in STD_LOGIC;
           clk : in STD_LOGIC;
           ce  : in STD_LOGIC;
           reset : in STD_LOGIC;
           set : in STD_LOGIC;
           dout : out STD_LOGIC);
    end component;
    
     --declaracao dos sinais internos
       signal ce_intern : STD_LOGIC;
       signal set : STD_LOGIC;
       signal q_next : STD_LOGIC_VECTOR (3 downto 0);
       signal q_intern : STD_LOGIC_VECTOR (3 downto 0);
       signal cnt_next : STD_LOGIC_VECTOR (3 downto 0);
       
       signal a1, a2 : STD_LOGIC;
    
begin

    set <= '0';

 -- ff are enable when ce = 1 or ld = 1
    ce_intern <= ld or ce;
    
 -- quad mux 2:1 que trata o load
     q_next <= cnt_next when ld='0' else d;    

 -- toogle AULA-17 slide 9
    a1 <= q_intern(0) and q_intern(1);
    a2 <= a1          and q_intern(2);
 
    cnt_next(0) <= not q_intern(0);
    cnt_next(1) <= q_intern(1) xor q_intern(0);
    cnt_next(2) <= q_intern(2) xor a1;
    cnt_next(3) <= q_intern(3) xor a2;

 -- instanciação automática de 4 FF_D
    uGen: for i in 0 to 3 generate
        FFD: ff_de port map (
            din => q_next(i), dout => q_intern(i), 
            clk => clk,  reset => reset, set => set, ce => ce_intern
        );
    end generate;

-- atribuição do sinal de saida	
    q <= q_intern;

end Behavioral;
