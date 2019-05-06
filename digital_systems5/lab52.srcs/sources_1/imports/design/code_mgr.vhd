----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2016 10:47:20
-- Design Name: 
-- Module Name: float_add - Behavioral
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

entity code_mgr is
    Port ( clk       : in STD_LOGIC;
           reset     : in STD_LOGIC;
           L         : in STD_LOGIC;
           R         : in STD_LOGIC;
           state_ME  : out STD_LOGIC_VECTOR (15 downto 0);
           ctr_err   : out STD_LOGIC_VECTOR (3 downto 0);
           ctr_Dopen : out STD_LOGIC_VECTOR (3 downto 0));
 --          Dopen     : out STD_LOGIC);
end code_mgr;

architecture Behavioral of code_mgr is
--componentes
--     component ff_de 
--        Port ( din   : in STD_LOGIC;
--               clk   : in STD_LOGIC;
--               ce    : in STD_LOGIC;
--               reset : in STD_LOGIC;
--               set   : in STD_LOGIC;
--               dout  : out STD_LOGIC);
--    end component ;
    
--    component ctr_16 
--        Port ( clk   : in STD_LOGIC;
--               reset : in STD_LOGIC;
--               ce    : in STD_LOGIC;
--               ld    : in STD_LOGIC;
--               d     : in STD_LOGIC_VECTOR (3 downto 0);
--               q     : out STD_LOGIC_VECTOR (3 downto 0));
--    end component;

  component maquina_estados
        Port (
            L : in std_logic;
            R : in std_logic; 
            reset: in std_logic;
            clk: in std_logic;
            xopen: in std_logic;
            err: in std_logic;
            s: out std_logic_vector(7 downto 0));
    end component;
    
    component circuito_dados
      Port (
            s: in std_logic_vector(7 downto 0);
            clk, reset: in std_logic;
            xopen, err: out std_logic;
            state_ME  : out STD_LOGIC_VECTOR (15 downto 0);
            ctr_err   : out STD_LOGIC_VECTOR (3 downto 0);
            ctr_Dopen : out STD_LOGIC_VECTOR (3 downto 0)
             );
    end component;
   
    -- sinais  A DEFINIR PELOS ALUNOS!
    signal xopen_inter, err_inter: std_logic;
    signal s_inter: std_logic_vector(7 downto 0);
    signal state_ME_inter: std_logic_vector(15 downto 0);
    signal ctr_err_inter, ctr_Dopen_inter: std_logic_vector(3 downto 0);
  
begin

        ME: maquina_estados port map(
            L => L, R => R, reset => reset, clk => clk,
            xopen => xopen_inter , err => err_inter, s => s_inter
            );
            
        
        CD: circuito_dados port map(
            s => s_inter, clk => clk, reset => reset, 
            xopen => xopen_inter, err => err_inter, state_ME => state_ME_inter, 
            ctr_err => ctr_err_inter, ctr_Dopen => ctr_Dopen_inter
            );
            
       --saidas
       state_ME <= state_ME_inter;
       ctr_err <= ctr_err_inter;  
       ctr_Dopen <= ctr_Dopen_inter;


--INSTÂNCIAS DE CONTADORES E FFs - A DEFINIR PELOS ALUNOS


-- INICIALIZAÇÕES (SET E RESET) DE FFs E CONTADORES - A DEFINIR PELOS ALUNOS         

-- DEFINIÇÃO DE ESTADOS ONE-HOT - A DEFINIR PELOS ALUNOS           

-- DEFINIÇÕES DE CONTADORES - A DEFINIR PELOS ALUNOS   

-- SAÍDAS - A DEFINIR PELOS ALUNOS                          
           
end Behavioral;
