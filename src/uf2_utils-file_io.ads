with System.Storage_Elements;
with Ada.Sequential_IO;

package UF2_Utils.File_IO is

   package UF2_Sequential_IO is new Ada.Sequential_IO (UF2_Block);
   use UF2_Sequential_IO;

   procedure Write_UF2
     (Data           : SSE.Storage_Array;
      Start_Address  : Interfaces.Unsigned_32;
      File           : in out UF2_Sequential_IO.File_Type;
      Max_Block_Size : UF2_Payload_Count := UF2_Payload_Count'Last;
      Flags          : Interfaces.Unsigned_32 := 0;
      Family         : Interfaces.Unsigned_32 := 0)
     with Pre => Is_Open (File)
                   and then
                 Mode (File) in Append_File | Out_File;

end UF2_Utils.File_IO;
