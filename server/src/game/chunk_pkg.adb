package body Chunk_Pkg is

   function Create_Chunk (X : Integer; Y : Integer) return Chunk is
      New_Chunk : Chunk;
   begin
      New_Chunk.X := X;
      New_Chunk.Y := Y;

      for Tile_X in Local_X loop
         for Tile_Y in Local_Y loop

            case Tile_Y is
               when 0 .. 5 =>
                  New_Chunk.Tiles (Tile_X, Tile_Y) :=
                    (Kind => Tile_Pkg.Stone, X => Tile_Y, Y => Tile_Y);

               when 6 .. 8 =>
                  New_Chunk.Tiles (Tile_X, Tile_Y) :=
                    (Kind => Tile_Pkg.Dirt, X => Tile_Y, Y => Tile_Y);

               when others =>
                  New_Chunk.Tiles (Tile_X, Tile_Y) :=
                    (Kind => Tile_Pkg.Air, X => Tile_Y, Y => Tile_Y);
            end case;

         end loop;
      end loop;

      return New_Chunk;
   end Create_Chunk;

end Chunk_Pkg;
