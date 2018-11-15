---- Vytvoril Nikolaj Vorobiev (xvorob00)----

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ledc8x8 is
Port( 
	SMCLK : in std_logic;
	RESET : in std_logic;
	ROW : out std_logic_vector(7 downto 0);
	LED : out std_logic_vector(7 downto 0)
);
end ledc8x8;

architecture main of ledc8x8 is
	signal ce : std_logic := '0';
	signal ce_cnt : std_logic_vector(7 downto 0) := (others => '0');
	
	signal cl : std_logic_vector (1 downto 0) := "00";
	signal cl_cnt : std_logic_vector(12 downto 0):= (others => '0');
	
	type t_state is (TEST1, TEST2, TEST3, TEST4, TEST5, TEST6, TEST7, TEST8);
	signal present_state, next_state : t_state;

begin

	ce_gen: process(SMCLK, RESET)
	begin
		if RESET = '1' then
			ce_cnt <= (others => '0');
		elsif SMCLK'event and SMCLK = '1' then
			ce_cnt <= ce_cnt + 1;
			if ce_cnt (7 downto 0) ="11111111" then
				ce <= '1';
			else
				ce <= '0';
			end if;
		end if;
	end process ce_gen;
	
	
	leds: process(present_state, cl)
	begin
	
		if cl = "00" then
		
		
			case present_state is
			------------------------------N---------------------------------
				when TEST1 => 
					ROW(7 downto 0) <= "10000000";
					LED(7 downto 0) <= "00111100";
					next_state <= TEST2;
					
					
				when TEST2 => 
					ROW(7 downto 0) <= "01000000";
					LED(7 downto 0) <= "00111100";
					next_state <= TEST3;
				
					
				when TEST3 =>
					ROW (7 downto 0) <= "00100000";
					LED (7 downto 0) <= "00011100";
					next_state <= TEST4;
				
					
				when TEST4 => 
					ROW(7 downto 0) <=  "00010000";
					LED (7 downto 0) <= "00001100";
					next_state <= TEST5;
				
				
				when TEST5 =>
					ROW(7 downto 0) <=  "00001000";
					LED (7 downto 0) <= "00100100";
					next_state <= TEST6;
				
				
				when TEST6 => 
					ROW(7 downto 0) <=  "00000100";
					LED (7 downto 0) <= "00110000";
					next_state <= TEST7;
				
					
				when TEST7 =>	
					ROW(7 downto 0) <=  "00000010";
					LED (7 downto 0) <= "00111000";
					next_state <= TEST8;
				
					
				when TEST8 =>
					ROW(7 downto 0) <=  "00000001";
					LED (7 downto 0) <= "00111100";
					next_state <= TEST1;
				end case;
				
			elsif cl = "01" then
					ROW(7 downto 0) <= (others => '0');
					LED(7 downto 0) <= (others => '1');
						next_state <= TEST1;
			
			elsif cl = "10" then
				case present_state is
				------------------------------V----------------------------------
					when TEST1 => 
						ROW(7 downto 0) <= "10000000";
						LED(7 downto 0) <= "00111100";
						next_state <= TEST2;
						
						
					when TEST2 => 
						ROW(7 downto 0) <= "01000000";
						LED(7 downto 0) <= "00111100";
						next_state <= TEST3;
						
						
					when TEST3 => 
						ROW(7 downto 0) <= "00100000";
						LED(7 downto 0) <= "00111100";
						next_state <= TEST4;
						
						
					when TEST4 => 
						ROW(7 downto 0) <= "00010000";
						LED(7 downto 0) <= "00111100";
						next_state <= TEST5;
						
						
					when TEST5 => 
						ROW(7 downto 0) <= "00001000";
						LED(7 downto 0) <= "00111100";
						next_state <= TEST6;
						
						
					when TEST6 => 
						ROW(7 downto 0) <= "00000100";
						LED(7 downto 0) <= "10011001";
						next_state <= TEST7;
						
						
					when TEST7 => 
						ROW(7 downto 0) <= "00000010";
						LED(7 downto 0) <= "10011001";
						next_state <= TEST8;
						
						
					when TEST8 => 
						ROW(7 downto 0) <= "00000001";
						LED(7 downto 0) <= "11100111";
						next_state <= TEST1;
						
						
					end case;
				elsif cl = "11" then
					ROW(7 downto 0) <= (others => '0');
					LED(7 downto 0) <= (others => '1');
					next_state <= TEST1;
			end if;
		
	end process leds;
	
	
	state: process(SMCLK, RESET, ce)
	begin
		if RESET = '1' then
			present_state <= TEST1;
			cl_cnt <= (others => '0');
		elsif SMCLK'event and SMCLK = '1' and ce = '1' then
				present_state <= next_state;	
				cl_cnt <= cl_cnt + 1;				
				if cl_cnt (12 downto 0) = "1110000100000" then
					cl <= cl + 1;
					cl_cnt <= (others => '0');
				
				end if;
		end if;
	end process state;
	

end main;
