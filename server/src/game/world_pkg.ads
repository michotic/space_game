with AWS.Net.WebSocket;
with Chunk_Pkg;
with GNATCOLL.JSON;

package World_Pkg is

   Test_Chunk : Chunk_Pkg.Chunk;

   procedure Create_World;

   function Get_Test_Chunk_JSON return String;

end World_Pkg;
