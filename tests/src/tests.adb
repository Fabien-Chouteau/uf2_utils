with UF2_Utils.File_IO;

procedure Tests is
   File : UF2_Utils.File_IO.UF2_Sequential_IO.File_Type;
begin

   UF2_Utils.File_IO.UF2_Sequential_IO.Create (File, Name => "test.uf2");

   UF2_Utils.File_IO.Write_UF2
     (Data => (0 .. 256 => 42),
      Start_Address => 0,
      File => File,
      Max_Block_Size => 256);
end Tests;
