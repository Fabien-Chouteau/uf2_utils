with Interfaces; use Interfaces;

package body UF2_Utils.File_IO is

   use SSE;

   ---------------
   -- Write_UF2 --
   ---------------

   procedure Write_UF2
     (Data           : SSE.Storage_Array;
      Start_Address  : Interfaces.Unsigned_32;
      File           : in out UF2_Sequential_IO.File_Type;
      Max_Block_Size : UF2_Payload_Count := UF2_Payload_Count'Last;
      Flags          : Unsigned_32 := 0;
      Family         : Unsigned_32 := 0)
   is
      Block_Count : constant Unsigned_32 :=
        ((Data'Length - 1) / Unsigned_32 (Max_Block_Size)) + 1;

      From, To : Storage_Offset;
      Len : Unsigned_32;
      Block : UF2_Block;

      Next_Address : Unsigned_32 := Start_Address;
   begin

      Reset (Block);
      Block.Blocks_In_File := Block_Count;

      Block.Flags := Flags;
      if (Flags and 16#00002000#) /= 0 then
         Block.File_Size := Family;
      end if;

      From := Data'First;
      for Block_Nbr in 0 .. Block_Count - 1 loop
         To := Storage_Offset'Min (From + Max_Block_Size - 1, Data'Last);
         Len := Unsigned_32 (To - From + 1);

         Block.Block_Nbr := Block_Nbr;
         Block.Payload_Size := Len;
         Block.Target_Address := Next_Address;

         Block.Data (0 .. SSE.Storage_Count (Len - 1)) := Data (From .. To);
         Block.Data (SSE.Storage_Count (Len) .. UF2_Payload_Count'Last) :=
           (others => 0);


         UF2_Sequential_IO.Write (File, Block);

         From := To + 1;
         Next_Address := Next_Address + Len;
      end loop;

      if To /= Data'Last then
         raise Program_Error with "Missing data in output";
      end if;
   end Write_UF2;

end UF2_Utils.File_IO;
