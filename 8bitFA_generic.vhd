-- GENERIC ORNEK -- 
--8-Bit FullAdder--
-------------------
-- FOR GENERATE SYNTAX:
------------------------------------------
label : for parameter in range generate	--
										--
		...ifadeler...					--
										--
end generate;							--
------------------------------------------
------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
-------------------

entity generic_toplayici is 
	GENERIC(
			n_bit : integer := 8 -- 8-bit toplayici icin,baslangic degerini 8 atadik
		   );

	Port(
		in_giris_elde  : in std_logic;
		in_giris_1     : in std_logic_vector(n_bit - 1 downto 0);
		in_giris_2     : in std_logic_vector(n_bit - 1 downto 0);
		
		out_cikis      : out std_logic_vector(n_bit - 1 downto 0);
		out_cikis_elde : out std_logic
		);
end generic_toplayici;

architecture Behavioral of generic_toplayici is

	component tam_toplayici
		Port(
			in_giris_elde  : in std_logic;
			in_giris_1     : in std_logic;
			in_giris_2     : in std_logic;
			
			out_cikis      : out std_logic;
			out_cikis_elde : out std_logic
			);
	end component;
	
signal r_elde(0) : std_logic_vector(0 to n_bit);
	
begin
	r_elde(0) <= in_giris_elde;

	for_kontrol : for n_i in to 0 to n_bit - 1 generate -- 4-Bitlik toplayıcıda yaptığımız atamaları for ... generate ile yapıyoruz.
		adim    : tam_toplayici port map(
										in_giris_elde  => r_elde(n_i),
										in_giris_1     => in_giris_1(n_i),
										in_giris_2     => in_giris_2(n_i),
										out_cikis      => out_cikis(n_i),
										out_cikis_elde => r_elde(n_i + 1)
										);
	end generate for_kontrol;
	out_cikis_elde <= r_elde(n_bit);
	
end Behavioral;