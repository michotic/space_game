with Tile_Pkg;

package body World_Pkg is

   procedure Create_World is
   begin
      --  Arguments should become types (chunk_x, chunk_y), and those (x,y) become keys in a hashmap for the world
      Test_Chunk := Chunk_Pkg.Create_Chunk (0, 0);
   end Create_World;

   function Get_Test_Chunk_JSON return String is

      Chunk_JSON : GNATCOLL.JSON.JSON_Value := GNATCOLL.JSON.Create_Object;

      Chunk_Tiles : GNATCOLL.JSON.JSON_Array := GNATCOLL.JSON.Empty_Array;
      --  begin
      --     My_Obj.Set_Field ("field1", Create (1))

   begin
      --  JSON Packet for a chunk
      --  cx/cy = chunk x/y
      --  t : array of tiles in array format [tileX, tileY, tileType]
      --
      --  { cx, cy, t => [ [x y t], [x y t], [x y t] ] }

      for Tile_X in Chunk_Pkg.Local_X loop
         for Tile_Y in Chunk_Pkg.Local_Y loop
            --  Declare JSON array for each tile
            declare
               Tile_Data : GNATCOLL.JSON.JSON_Array :=
                 GNATCOLL.JSON.Empty_Array;

               Tile_Type_Int : Integer := 0;

               use type Tile_Pkg.Tile_Kind;
            begin
               --  Ignore air tiles
               if Test_Chunk.Tiles (Tile_X, Tile_Y).Kind /= Tile_Pkg.Air then
                  --  Bundle tiles X, Y & type into an array
                  GNATCOLL.JSON.Append
                    (Tile_Data, GNATCOLL.JSON.Create (Tile_X));
                  GNATCOLL.JSON.Append
                    (Tile_Data, GNATCOLL.JSON.Create (Tile_Y));
                  Tile_Type_Int :=
                    Tile_Pkg.Tile_Kind'Pos
                      (Test_Chunk.Tiles (Tile_X, Tile_Y).Kind);
                  GNATCOLL.JSON.Append
                    (Tile_Data, GNATCOLL.JSON.Create (Tile_Type_Int));
                  --  Add tile array to chunk array
                  GNATCOLL.JSON.Append
                    (Chunk_Tiles, GNATCOLL.JSON.Create (Tile_Data));
               end if;
            end;
         end loop;
      end loop; --  end of chunk loop

      --  Add chunk data to JSON
      Chunk_JSON.Set_Field (Field_Name => "data", Field => "chunk");
      Chunk_JSON.Set_Field (Field_Name => "x", Field => Test_Chunk.X);
      Chunk_JSON.Set_Field (Field_Name => "y", Field => Test_Chunk.Y);
      Chunk_JSON.Set_Field (Field_Name => "tiles", Field => Chunk_Tiles);

      return Chunk_JSON.Write;

   end Get_Test_Chunk_JSON;

end World_Pkg;
