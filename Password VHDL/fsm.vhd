-- fsm.vhd: Finite State Machine
-- Author(s):Nikolaj Vorobiev(xvorob00) 
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (TEST1, TEST2, TEST3, TEST4, TEST5, TEST6, TEST7, TEST8,
							TEST9, TEST10, TEST11, TEST4A, TEST5A, TEST6A, TEST7A, TEST8A, 
							TEST9A, TEST10A, TEST11A, TEST12A, PRINT_MESSAGE_OK, PRINT_MESSAGE_NOK,
							WAIT_NOK, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
begin
   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST1 =>
      if (KEY(15) = '1') then
            next_state <= PRINT_MESSAGE_NOK; 
	elsif (KEY(1) = '1') then
		next_state <= TEST2;
	elsif (KEY(15 downto 0) = "0000000000000000") then
      		next_state <= TEST1;
	else
		next_state <= WAIT_NOK;
			
      end if;
		   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST2 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
	elsif (KEY(7) = '1') then
		next_state <= TEST3;
	elsif (KEY(15 downto 0) = "0000000000000000") then
      		next_state <= TEST2;
	else
		next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST3 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(2) = '1') then
			next_state <= TEST4;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      			next_state <= TEST3;
		elsif (KEY(8) = '1') then
			next_state <= TEST4A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST4 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(5) = '1') then
			next_state <= TEST5;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      			next_state <= TEST4;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST5 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(0) = '1') then
			next_state <= TEST6;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST5;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST6 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(9) = '1') then
			next_state <= TEST7;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST6;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST7 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(2) = '1') then
			next_state <= TEST8;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST7;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST8 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(5) = '1') then
			next_state <= TEST9;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST8;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST9 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(5) = '1') then
			next_state <= TEST10;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST9;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST10 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(6) = '1') then
			next_state <= TEST11;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST10;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST11 =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_OK; 
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST11;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	
   when TEST4A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(0) = '1') then
			next_state <= TEST5A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST4A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST5A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(0) = '1') then
			next_state <= TEST6A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST5A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST6A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(7) = '1') then
			next_state <= TEST7A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST6A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST7A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(4) = '1') then
			next_state <= TEST8A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST7A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST8A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(0) = '1') then
			next_state <= TEST9A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST8A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST9A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(4) = '1') then
			next_state <= TEST10A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST9A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST10A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(4) = '1') then
			next_state <= TEST11A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST10A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST11A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_NOK; 
			
		elsif (KEY(8) = '1') then
			next_state <= TEST12A;
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST11A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when TEST12A =>
      if (KEY(15) = '1') then
         next_state <= PRINT_MESSAGE_OK; 
		elsif (KEY(15 downto 0) = "0000000000000000") then
      next_state <= TEST12A;
		else
			next_state <= WAIT_NOK;
			
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when WAIT_NOK => 
		if(KEY(15) = '1') then
			next_state <= PRINT_MESSAGE_NOK;
		else
			next_state <= WAIT_NOK;
		end if;
	
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_NOK =>
      next_state <= PRINT_MESSAGE_NOK;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	   when PRINT_MESSAGE_OK =>
      next_state <= PRINT_MESSAGE_OK;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -

   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST1; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is
   -- - - - - - - - - - - - - - - - - - - - - - -
	when WAIT_NOK =>
		if(KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
		end if;
		if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
	
   when TEST1 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST2 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST3 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST4 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST5 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST6 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST7 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST8 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST9 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST10 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST11 =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	
	when TEST4A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST5A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST6A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST7A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST8A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST9A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST10A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST11A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
	when TEST12A =>
      if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
      end if;
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_NOK =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
      FSM_MX_MEM     <= '0';
   -- - - - - - - - - - - - - - - - - - - - - - -
	when PRINT_MESSAGE_OK =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
      FSM_MX_MEM     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
	
	
	
   when FINISH =>
      if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
   end case;
end process output_logic;

end architecture behavioral;

