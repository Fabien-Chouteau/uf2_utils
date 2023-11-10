with Interfaces;
with System.Storage_Elements;

package UF2_Utils is

   package SSE renames System.Storage_Elements;

   subtype UF2_Payload_Count is SSE.Storage_Count range 0 .. 475;

   type UF2_Block is record
      Magic_Start_0  : Interfaces.Unsigned_32 := 16#0A324655#;
      Magic_Start_1  : Interfaces.Unsigned_32 := 16#9E5D5157#;
      Flags          : Interfaces.Unsigned_32 := 0;
      Target_Address : Interfaces.Unsigned_32 := 0;
      Payload_Size   : Interfaces.Unsigned_32 := 0;
      Block_Nbr      : Interfaces.Unsigned_32 := 0;
      Blocks_In_File : Interfaces.Unsigned_32 := 0;
      File_Size      : Interfaces.Unsigned_32 := 0;
      Data           : SSE.Storage_Array (UF2_Payload_Count) := (others => 0);
      Magic_End      : Interfaces.Unsigned_32 := 16#0AB16F30#;
   end record
     with Pack, Size => 512 * 8;

   procedure Reset (Block : in out UF2_Block);
   --  Set the magic numbers and clear other fields

end UF2_Utils;
