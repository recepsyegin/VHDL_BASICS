-- COMPONENTS --
-- Büyük bir tasarımı küçük birer parçalara bölüp, onları tekrar
-- kullanmak,gereksiz yazımdan kaçınmak. Örnekle inceleyelim.
 
-- nand gate
entity comp1 is
	port(
		A,B : in std_logic;
		C   : out std_logic
		);
end comp1;

architecture comp1_arch of comp1 is
begin
	C <= A nand B;
end comp1_arch;

-- and gate

entity comp2 is
	port(
		E,F : in std_logic;
		G   : out std_logic
		);
end comp2;

architecture comp2_arch of comp2 is
begin
	G <= E and F;
end comp2_arch;

------------------------------------------------------------------
-- Şimdi bu ikisini bir "top entity"de tanımlayalım.
-- "Top entity" bu farklı iki "entities"i "component" olarak içerecek
---

entity Top_entity is
	port(
		top_A, top_B, top_E,top_F : in std_logic;
		
		top_C, top_G              : out std_logic
		);
end Top_entity;

architecture Top_arch of Top_entity is

-- component'ler "architecture" ile "begin" arasında tanımlanıyor:

component comp1 is -- comp
	port(
		A,B : in std_logic;
		C   : out std_logic
		);
end component;

component comp2 is
	port(
		E,F : in std_logic;
		G   : out std_logic
		);
end component;

begin -- "Top" için portları top_A,top_B ... için bağlıyoruz.

comp1 : comp1 port map( -- Soldaki değerler kendi tanımlandığı isimler, sağdaki ise alt devre olarak kullanılacak isimleri
	A => top_A,
	B => top_B,
	C => top_C		  );
------------------------------
comp2 : comp2 port map(
	E => top_E,
	F => top_F,
	G => top_G        );

end Top_arch;     		
-- FINISH !
