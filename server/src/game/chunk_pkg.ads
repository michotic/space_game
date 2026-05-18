with Tile_Pkg;

package Chunk_Pkg is

   Chunk_Width  : constant := 16;
   Chunk_Height : constant := 16;

   subtype Local_X is Integer range 0 .. Chunk_Width - 1;
   subtype Local_Y is Integer range 0 .. Chunk_Height - 1;

   type Tile_Array is array (Local_X, Local_Y) of Tile_Pkg.Tile;

   type Chunk is record
      X     : Integer;
      Y     : Integer;
      Tiles : Tile_Array;
   end record;

   function Create_Chunk (X : Integer; Y : Integer) return Chunk;

end Chunk_Pkg;
