library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vhdl_adder is
   port(
      clk  : in  std_logic;
      en_i : in  std_logic;
      ina  : in  std_logic;
      inb  : in  std_logic;
      en_o : out std_logic;
      outp : out std_logic
   );
end entity vhdl_adder;

architecture RTL of vhdl_adder is

begin
   p_clk : process(clk) is
      variable counter, state : integer;
      variable temp_a, temp_b : unsigned(2 downto 0);
      variable temp_out       : unsigned(2 downto 0);

   begin
      if rising_edge(clk) then
         temp_a(2) := '0';
         temp_b(2) := '0';

         --State 0: Wait for en_i
         if en_i = '1' then
            state := 1;
         end if;

         outp <= '0';
         en_o <= '0';

         case state is
            --State 1: Start reading inputs
            when 1 =>
               temp_a(1 downto 0) := temp_a(0) & ina;
               temp_b(1 downto 0) := temp_b(0) & inb;
               counter            := counter + 1;

               --After 2 bits, do the operation an move to the next state
               if counter = 2 then
                  temp_out := temp_a + temp_b;
                  state    := 2;
               end if;

            --State 2: Enable en_o and sends result to the output
            when 2 =>
               outp     <= temp_out(2);
               temp_out := temp_out(1 downto 0) & '0';

               counter := counter + 1;

               if counter = 3 then
                  en_o <= '1';
               end if;

               if counter = 6 then
                  counter := 0;
                  state   := 0;
               end if;
            when others =>
               counter := 0;
         end case;
      end if;
   end process p_clk;

end architecture RTL;
