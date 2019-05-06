----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2016 12:37:35 AM
-- Design Name: 
-- Module Name: tb_float_add - Behavioral
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

entity tb_code_mgr is
--  Port ( );
end tb_code_mgr;

architecture Behavioral of tb_code_mgr is
    component code_mgr
    Port ( clk       : in STD_LOGIC;
           reset     : in STD_LOGIC;
           L         : in STD_LOGIC;
           R         : in STD_LOGIC;
           state_ME  : out STD_LOGIC_VECTOR (15 downto 0);
           ctr_err   : out STD_LOGIC_VECTOR (3 downto 0);
           ctr_Dopen : out STD_LOGIC_VECTOR (3 downto 0));
--           Dopen     : out STD_LOGIC);
    end component;
    --inputs
    signal clk : STD_LOGIC;
    signal L, R, reset : STD_LOGIC := '0';
    -- ouptuts 
    signal state_ME : STD_LOGIC_VECTOR(15 downto 0); 
    signal state_ME2 : STD_LOGIC_VECTOR(3 downto 0); 
    signal ctr_err, ctr_Dopen : STD_LOGIC_VECTOR (3 downto 0); 
--    signal Dopen : STD_LOGIC;  
begin

-- encoder das saídas

    state_ME2(3) <= state_ME(15) or state_ME(14) or state_ME(13) or state_ME(12) or
                    state_ME(11) or state_ME(10) or state_ME(9) or state_ME(8);
    state_ME2(2) <= state_ME(15) or state_ME(14) or state_ME(13) or state_ME(12) or
                    state_ME(7) or state_ME(6) or state_ME(5) or state_ME(4);
    state_ME2(1) <= state_ME(15) or state_ME(14) or state_ME(11) or state_ME(10) or
                    state_ME(7) or state_ME(6) or state_ME(3) or state_ME(2);
    state_ME2(0) <= state_ME(15) or state_ME(13) or state_ME(11) or state_ME(9) or
                    state_ME(7) or state_ME(5) or state_ME(3) or state_ME(1);


-- instancia do componente (unidade de teste) 
    test_unit : code_mgr port map (
     clk => clk, reset => reset,
     L => L, R => R, 
     state_ME => state_ME, ctr_err => ctr_err,
     ctr_Dopen => ctr_Dopen);
       
   -- process that will non-stop generate the clock signal
      -- '0' for 25ns, followed by '1' for another 25 ns (and so on...)
      process begin
          clk <= '0';
          wait for 25 ns;
          clk <= '1';
          wait for 25 ns;
      end process;
          
         -- process to test the circuit 
		 -- A PREENCHER PELOS ALUNOS
		 -- MUITO IMPORTANTE!!!
		 -- COMEÇAR POR FAZER RESET AO SISTEMA
		 
       process begin
          reset <= '1';
          wait for 50 ns;
          reset <= '0';
          wait for 50 ns;
          
          R <= '1';
          wait for 100 ns;
          R <= '0';
          L <= '1';
          wait for 50 ns;
          L <= '0';
          R <= '1';
          wait for 50 ns;
          R <= '0';
          
          L <= '1';
          wait for 100 ns;
          L <= '0';
          R <= '1';
          wait for 100 ns;
          R <= '0';
          wait for 400 ns;
          R <= '1';
          wait for 50 ns;
          R <= '0';
          L <= '1';
          wait for 50 ns;
          L <= '0';
          
--          wait for 20 ns;
--          R <= '1';
--          L <= '1';
--          wait for 50 ns;
--          R <= '0';
--          L <= '0';
--          wait for 30 ns;
                    
--          R <= '1';
--          wait for 50 ns;
--          R <= '0';
--          wait for 50 ns;
--          L <= '1';
--          wait for 50 ns;
--          L <= '0';
          
          
          
          wait; -- forever 
       end process;
 
end Behavioral;
