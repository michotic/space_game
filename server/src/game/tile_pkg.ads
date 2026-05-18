package Tile_Pkg is

   type Tile_Kind is (Air, Stone, Dirt, Grass);

   type Tile is record
      Kind : Tile_Kind := Air;
      X    : Integer;
      Y    : Integer;
   end record;

end Tile_Pkg;
