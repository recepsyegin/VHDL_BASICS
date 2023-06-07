-- VHDL VERİ NESNELERİ --
-- 3 temel veri nesnesi : " signal, variable, constant "
-- ---------------------------------------------------------------------------------------------------------------------
-- signal -> "KABLOLAR,YOLLAR"
-- signal sinyal_adi : tip_adi := baslangic_degeri;
	
-- 1-) Entity tanımlamalarında kullanılabilir:
		entity ornek is
		port(
				toplam : std_logic_vector(3 downto 0);
			);
		end ornek;

-- 2-) Architecture tanımlamalarında kullanılabilir:
		...
		architecture Behavioral of ornek is
			signal bayrak : std_logic;
			signal toplam : bit_vector(0 to 3);
			signal sayac  : integer range 0 to 255;
		begin
		...
-- 3-) Package tanımlama bölümünde kullanılabilir:
		package ornek is
			signal bayrak : std_logic;
			signal toplam : bit_vector (0 to 3);
			signal sayac  : integer range 0 to 255;
		end ornek;

-- 4-) Block tanımlama bölümünde kullanılabilir:
		block
			signal bayrak : std_logic;
			signal toplam : bit_vector (0 to 3);
			signal sayac  : integer range 0 to 255;
		end block;
------------------------------------------------------------------------------------------------------------------------
-- variable -> signal veri nesnesi ile arasındaki en temel fark, variable veri nesnesinin içeriğinin
--			   hemen güncellenmesidir.
			   -- variable degisken_adi : tip_adi := baslangic_degeri;
-- variable nesnesi VHDL kodunda 3 farklı yerde kullanılabilir:
-- 1-) Process tanımlama bölümünde:
	process(...)
		variable bayrak : std_logic;
		variable toplam : bit_vector (0 to 3);
		variable sayac  : integer range 0 to 255;
		begin ....... end process; ......
-- 2-) function tanımlama bölümünde:
	function fonksiyon_adi(parametreler listesi) return donus_tipi is
		variable bayrak : std_logic;
		variable toplam : bit_vector (0 to 3);
		variable sayac  : integer range 0 to 255;
	begin .. .. .. .. end fonksiyon_adi;
--
-- 3-) Procedure tanımlama bölümünde:
		procedure procedure_adi (parametreler listesi) is
			variable bayrak : std_logic;
			variable toplam : bit_vector (0 to 3);
			variable sayac  : integer range 0 to 255;
		begin .. .. .. end procedure_adi; .. .. ..
------------------------------------------------------------------------------------------------------------------------
-- constant veri nesnelerinin değerleri değiştirilemez. Sabit olarak saklanacak değerler için kullanılır.
-- constant veri nesnesi VHDL kodlarında şu yerlerde tanımlanabilir:
-- "package","body","block","entity","architecture","process","procedure","function" -----------------------------------
------------------------------------------------------------------------------------------------------------------------
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- LİSTELEME TİPİ (ENUMERATION): Listeleme tipi, kullanıcının belirlediği olası değerlerdir:
	type listeleme_tipi_adi is (isim,[, isim]);
-- Köşeli parantez, bir veya daha fazla eklenebilir "öğelerin" içerebileceğini gösterir. "Enumeration" en çok sonlu
-- durum makinelerinin durum gösterimi için kullanılır.
-- Ex:
	type t_Kontrol is (BOSTA, BASLA, DUR)
	signal r_Kontrol := t_Kontrol;
	..
	..
	case r_Kontrol is
		when BOSTA =>
			..
			..
		when BASLA =>
			..
			..
		when DUR =>
			..
			..
		when others => null;
	end case;
------------------------------------------------------------------------------------------------------------------------			
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- TİP DÖNÜŞÜMLERİ:
-- EX:
	Y <= conv_std_logic_vector(X,12); -- integer tipindeki sayiyi stdlogvec 12bit'e çevirmek --
	X <= conv_integer(Y)	          -- std_logic_vector tipini integer tipine çevirmek --
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ALT-TİPLER (SUBTYPE): Veri tipinin özellikleri kullanılarak alt tipler oluşturmak için kullanılır.
	subtype alt_tip_adi is ana_tip sinir_limiti;
-- EX:
	subtype hex_kelime is std_logic_vector(3 downto 0);
	subtype byte is bit_vector(7 downto 0);
	subtype sayac is integer range 0 to 15;
	subtype dogal_sayilar is integer range 0 to 2^31-1;
	subtype pozitif_sayilar is integer range 1 to 2^31-1;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- DİZİLER: std_logic_vector ve bit_vector tipleri std_logic ve bit sinyallerinden oluşan dizilerdir.
	type bit_vector is array(natural range<>) of bit;
	type std_logic_vector is array (natural range<>) of std_logic;
-- EX:
	type t_Kelime_10 is array (9 downto 0) of std_logic;
	signal r_Kelime_10 : t_Kelime_10;
-- Çok Boyutlu Diziler:
-- EX:
	type t_dizi_1d is array (2 downto 0) of std_logic_vector (3 downto 0);
	signal r_dizi_1d : t_dizi_1d;
	--- r_dizi_1d bileşeni için atama işlemleri:
	r_dizi_1d <= ("0010","1100","1001");     -- TÜM DEĞERLERİN ATANMASI
	r_dizi_1d(0) 	<= "1001"; 		         -- 0.Elemanın ataması
	r_dizi_1d(1) 	<= "1100";				 -- 1.Elemanın ataması
	r_dizi_1d(2) 	<= "0010";				 -- 2.Elemanın ataması
	r_dizi_1d(2)(1) <= '1';					 -- 2.Elemanın 1.bitine değer ataması
-- EX2:
	type t_dizi_2d is array (0 to 1, 2 downto 0) of std_logic_vector(3 downto 0);
	signal r_dizi_2d : t_dizi_2d;
	
	r_dizi_2d	 <= (("0010","1100","1001"),
					 ("1101","0011","0110")) -- TÜM DEĞERLERİN ATANMASI
	
	r_dizi_2d(0)      <= ("0010","1100","1001");	 -- 0.Satıra değer ataması
	r_dizi_2d(1)      <= ("1101","0011","0110");     -- 1.Satıra değer ataması
	r_dizi_2d(0,2)    <= "0010";					 -- 0.Satırın 2.elemanına değer ataması 
	r_dizi_2d(0,1)    <= "1100";					 -- 0.Satırın 1.elemanına değer ataması
	r_dizi_2d(1,1)    <= "0011";					 -- 1.Satırın 1.elemanına değer ataması
	r_dizi_2d(1,0) 	  <= "0110"; 				     -- 1.Satırın 0.elemanına değer ataması
	r_dizi_2d(1,0)(1) <= '1';						 -- 1.Satırın 0.elemanının 1.bitine değer atama
	r_dizi_2d(1,0)(0) <= '0';						 -- 1.Satırın 0.elemanının 0.bitine değer atama
------------------------------------------------------------------------------------------------------------------------	
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- PORT DİZİLERİ: VHDL dilinde "entity" kısmında doğrudan istenilen tipte veri nesnesi tanımlayıp kullanmak mümkün değildir.
-- VHDL dili ancak önceden tanımlanmış veri nesnelerinin "entity" kısmında kullanılmasına izin vermektedir.Bu kısıtlama
-- ile en çok karşılaşılan durum ise "entity" kısmında çok boyutlu dizilerin kullanılmaya çalışıldığı anlardır.
-- Bu kısıtlamadan kurtulmak ve istediğiniz veri nesneleri, ilgili "package"in çağrıldığı tüm proje dosyaları tarafından
-- "entity" kısmı da dahil olmak üzere her yerde kullanılabilir.
-- EX:
	package port_dizi_paket is
		type port_dizi is array (3 downto 0) of std_logic_vector (0 to 7);
	end port_dizi_paket;
-- EX2:
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use work.port_dizi_paket.all;
	
	entity port_dizi_ornek is
		port(
			in_giris : in port_dizi;
			out_cikis: out port_dizi;
			);
	architecture Behavioral of port_dizi_ornek is
		begin
			out_cikis <= in_giris;
		end Behavioral;
------------------------------------------------------------------------------------------------------------------------
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- RECORD TANIMLAMASI: "record" yapısı diziler ile benzer olmakla beraber, en önemli farkı içeriğinde farklı veri
-- tiplerine izin veriyor olmasıdır.Yani bir "record" tanımlaması içinde birbirinden farklı tiplerde veriler olabilir.
-- EX:
	type record_ornek is record 
		bilesen_adi : biles_tipi;
		bilesen_adi2: bilesen_tipi2;
		.. .. ..
	end record;
------------------------------------------------------------------------------------------------------------------------
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- ÇOKLU VERİ NESNESİNE DEĞER ATAMAK:
-- EX:
	kelime <= "001100110011";  -- Binary Atama İfadesi (İkilik tabanda)
	kelime <= B"001100110011"; -- Binary Atama İfadesi (İkilik tabanda)
	kelime <= O"1463";         -- Octal Atama İfadesi  (Sekizlik tabanda)
	kelime <= X"333";          -- Hex Atama İfadesi    (Onaltılık tabanda)
------------------------------------------------------------------------------------------------------------------------
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--
--
--
--
--
--
--
--
--
--
--

