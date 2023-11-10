package body Uf2_Utils is

   -----------
   -- Reset --
   -----------

   procedure Reset (Block : in out UF2_Block) is
   begin
      Block := (others => <>);
   end Reset;
end Uf2_Utils;
